class AddLegendToPlugs < ActiveRecord::Migration
  def change
    add_column :plugs, :legend, :string
  end
end
