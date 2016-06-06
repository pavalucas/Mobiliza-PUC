class AddDetailsToMobilization < ActiveRecord::Migration
  def change
    add_column :mobilizations, :goal, :integer
  end
end
