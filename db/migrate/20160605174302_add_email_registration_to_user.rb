class AddEmailRegistrationToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :registration, :string
  end
end
