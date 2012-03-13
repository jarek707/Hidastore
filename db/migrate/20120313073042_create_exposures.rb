class CreateExposures < ActiveRecord::Migration
  def change
    create_table :exposures do |t|
      t.string :description
      t.string :flag

      t.timestamps
    end
  end
end
