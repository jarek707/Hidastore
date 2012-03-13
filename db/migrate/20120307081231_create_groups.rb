class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :descr
      t.string :hex_val

      t.timestamps
    end
  end
end
