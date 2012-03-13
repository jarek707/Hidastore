class CreateElmtypes < ActiveRecord::Migration
  def change
    create_table :elmtypes do |t|
      t.string :flag
      t.string :description

      t.timestamps
    end
  end
end
