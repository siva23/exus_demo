class CreateEdudetails < ActiveRecord::Migration
  def change
    create_table :edudetails do |t|
      t.string :clgname
      t.integer :year

      t.timestamps
    end
  end
end
