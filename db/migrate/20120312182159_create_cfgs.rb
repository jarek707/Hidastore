class CreateCfgs < ActiveRecord::Migration
  def change
    create_table :cfgs do |t|
      t.string :descr
      t.string :flag

      t.timestamps
    end
  end
end
