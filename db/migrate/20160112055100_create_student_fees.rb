class CreateStudentFees < ActiveRecord::Migration
  def change
    create_table :student_fees do |t|
      t.string  :name
      t.float   :amount
      t.date    :due_date
      t.text    :description
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
