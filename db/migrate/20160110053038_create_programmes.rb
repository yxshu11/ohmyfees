class CreateProgrammes < ActiveRecord::Migration
  def change
    create_table :programmes do |t|
      t.string :programme_type
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
