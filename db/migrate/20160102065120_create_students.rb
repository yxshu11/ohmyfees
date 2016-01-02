class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :student_number, unique: true
      t.string :intake
      
      t.timestamps null: false
    end
  end
end
