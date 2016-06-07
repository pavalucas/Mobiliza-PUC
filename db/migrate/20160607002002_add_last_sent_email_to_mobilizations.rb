class AddLastSentEmailToMobilizations < ActiveRecord::Migration
  def change
    add_column :mobilizations, :last_sent_email, :datetime
  end
end
