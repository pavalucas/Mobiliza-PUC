class AddStatusesToMobilization < ActiveRecord::Migration
  def change
    add_column :mobilizations, :status, :integer
  end
end
