class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :dom
      t.integer :flags
      t.string :xml
      t.references :plug

      t.timestamps
    end
    add_index :fields, :plug_id
  end
end
