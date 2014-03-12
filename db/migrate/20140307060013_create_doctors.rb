class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :fname
      t.string :lname
      t.string :clname
      t.string :clstadd
      t.string :sex
      t.string :clcity
      t.string :state
      t.string :zip
      t.string :country
      t.date :dob
      t.string :clnum

      t.timestamps
    end
  end
end
