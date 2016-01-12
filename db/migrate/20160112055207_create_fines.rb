class CreateFines < ActiveRecord::Migration
  def change
    create_table :fines do |t|
      t.string  :name
      t.float   :amount
      t.integer :student_fee_id
      
      t.timestamps null: false
    end
  end
end
