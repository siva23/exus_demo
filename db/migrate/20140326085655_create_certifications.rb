class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :name
      t.integer :year

      t.timestamps
    end
  end
end
