class AddExposureIdToFields < ActiveRecord::Migration
  def change
    add_column :fields, :exposure_id, :integer
  end
end
