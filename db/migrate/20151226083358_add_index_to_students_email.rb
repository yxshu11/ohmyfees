class AddIndexToStudentsEmail < ActiveRecord::Migration
  def change
    add_index :students, :email, unique: true
    add_index :students, :student_number, unique: true
  end
end
