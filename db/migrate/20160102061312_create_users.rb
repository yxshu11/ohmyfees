class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email, unique: true
      t.string  :staff_number, unique: true
      t.string  :student_number, unique: true
      t.string  :contact_number
      t.string  :intake
      t.boolean :international
      t.string  :type
      t.string  :picture
      t.boolean :tfa
      t.string  :otp_secret_key
      t.string  :password_digest
      t.string  :remember_digest
      t.boolean :admin, default: false
      t.string  :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string  :reset_digest
      t.datetime :reset_sent_at


      t.timestamps null: false
    end
  end
end
