class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :staff_number, unique: true
      t.string :student_number, unique: true
      t.string :intake
      t.string :type
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
