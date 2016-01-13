class CreateUtilityFees < ActiveRecord::Migration
  def change
    create_table :utility_fees do |t|
      t.string  :name
      t.float   :amount
      t.text    :description
      t.boolean :repetitive_payment

      t.timestamps null: false
    end
  end
end
