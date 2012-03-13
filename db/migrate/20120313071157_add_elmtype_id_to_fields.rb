class AddElmtypeIdToFields < ActiveRecord::Migration
  def change
    add_column :fields, :elmtype_id, :integer
  end
end
