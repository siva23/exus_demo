class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :patient_id
      t.integer :relation_id
      t.string :relate

      t.timestamps
    end
  end
end
