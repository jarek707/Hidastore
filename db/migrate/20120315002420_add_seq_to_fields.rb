class AddSeqToFields < ActiveRecord::Migration
  def change
    add_column :fields, :seq, :integer
  end
end
