class CreateWebData < ActiveRecord::Migration[5.1]
  def change
    create_table :web_data do |t|
    	t.text  :h1
    	t.text  :h2
    	t.text  :h3
    	t.text  :links
    	t.string :website
      t.timestamps
    end
  end
end
