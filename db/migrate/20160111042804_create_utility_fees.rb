class CreateUtilityFees < ActiveRecord::Migration
  def change
    create_table :utility_fees do |t|

      t.timestamps null: false
    end
  end
end
