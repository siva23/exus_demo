class CreateSpecialnames < ActiveRecord::Migration
  def change
    create_table :specialnames do |t|
      t.string :name

      t.timestamps
    end
  end
end
