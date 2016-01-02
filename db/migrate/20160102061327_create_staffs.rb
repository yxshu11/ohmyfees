class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :staff_number, unique: true

      t.timestamps null: false
    end
  end
end
