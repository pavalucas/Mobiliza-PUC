class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :commenter_id
      t.string :commenter_type

      t.timestamps null: false
    end
  end
end
