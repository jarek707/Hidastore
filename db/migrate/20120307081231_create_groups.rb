class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :desc
      t.string :hex_val

      t.timestamps
    end
  end
end
