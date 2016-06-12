class AddMobilizationIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :mobilization_id, :integer
  end
end
