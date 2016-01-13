class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string  :name
      t.float   :amount
      t.string  :paid_by
      t.string  :paying_method
      t.integer :student_fee_id

      t.timestamps null: false
    end
  end
end
