class Api::V1::WebDataController < ApplicationController
  require 'open-uri'
  skip_before_action :verify_authenticity_token

  #GET request
  #url: http://localhost:3000/api/v1/web_data
  def index
    web_data = WebData.all.select("id, h1, h2, h3, links, website")
    render json: web_data, status: 200
  end
  
  #POST request
  #url: http://localhost:3000/api/v1/web_data/get_web_source?url=https://m.facebook.com
  def get_web_source
    begin
      url = params[:url]
      if request.post?
        h1 = ""
        h2 = ""
        h3 = ""
        links = ""       
        source = open(url).read
        page = Nokogiri::HTML(source)
        page.css('h1').each{|l| h1 << l.text << "\n" }
        page.css('h2').each{|l| h2 << l.text << "\n" }
        page.css('h3').each{|l| h3 << l.text << "\n" }
        page.css('a').each{|l| links << l["href"]  << "\n" if !l["href"].nil? }
        web_data = WebData.find_or_create_by(website: url)
        web_data = web_data.update(h1: h1, h2: h2, h3: h3, links: links)
        render json: {message: "success"}, status: 200
      else
        render json: {message: "error"}, status: 404
      end      
    rescue Exception => e
      response = {status: 'error', message: "Not Found"}
      render json: response, status: 404
    end    
  end

end
