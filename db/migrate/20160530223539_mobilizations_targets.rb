class MobilizationsTargets < ActiveRecord::Migration
  def change
    	create_table :mobilizations_targets, id: false do |t|
      		t.belongs_to :mobilization, index: true
      		t.belongs_to :target, index: true
    	end
  end
end
