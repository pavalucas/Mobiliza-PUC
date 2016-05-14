class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :email
      t.string :name
      t.string :role

      t.timestamps null: false
    end
  end
end
