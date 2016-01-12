class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string  :name
      t.string  :paid_by
      t.integer :student_fee_id
      
      t.timestamps null: false
    end
  end
end
