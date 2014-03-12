class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :aptdoc
      t.string :aptreason
      t.date :aptdate
      t.string :apttime
      t.text :comments

      t.timestamps
    end
  end
end
