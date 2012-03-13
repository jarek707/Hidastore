class AddTypToCfg < ActiveRecord::Migration
  def change
    add_column :cfgs, :typ, :string
  end
end
