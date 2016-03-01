class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string  :ip
      t.string  :express_token
      t.string  :express_payer_id
      t.float   :amount
      t.string  :paid_by
      t.string  :payment_method
      t.integer :student_fee_id, index: true

      t.timestamps null: false
    end
  end
end
