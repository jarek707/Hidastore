class AddParentIdToPlugs < ActiveRecord::Migration
  def change
    add_column :plugs, :parent_id, :integer
  end
end
