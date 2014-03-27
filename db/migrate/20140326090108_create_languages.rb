class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.integer :doctor_id

      t.timestamps
    end
  end
end
