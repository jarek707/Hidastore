class CreatePlugs < ActiveRecord::Migration
  def change
    create_table :plugs do |t|
      t.string :tab_name
      t.string :flags
      t.string :legend

      t.timestamps
    end
  end
end
