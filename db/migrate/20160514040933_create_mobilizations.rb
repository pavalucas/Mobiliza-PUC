class CreateMobilizations < ActiveRecord::Migration
  def change
    create_table :mobilizations do |t|
      t.string :title
      t.integer :category
      t.text :description
      t.text :mail_content

      t.timestamps null: false
    end
  end
end
