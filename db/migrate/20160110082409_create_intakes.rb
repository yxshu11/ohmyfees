class CreateIntakes < ActiveRecord::Migration
  def change
    create_table :intakes do |t|
      t.string :intake_code, unique: true
      t.date :starting_date
      t.float :local_student_fee
      t.float :international_student_fee
      t.integer :programme_id

      t.timestamps null: false
    end
  end
end
