class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.string :skill
      t.integer :doctor_id

      t.timestamps
    end
  end
end
