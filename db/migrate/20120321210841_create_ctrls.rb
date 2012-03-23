class CreateCtrls < ActiveRecord::Migration
  def change
    create_table :ctrls do |t|
      t.string :uc_tab
      t.string :lc_tab

      t.timestamps
    end
  end
end
