class AddVflagToFields < ActiveRecord::Migration
  def change
    add_column :fields, :label, :integer
  end
end
