class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :iname
      t.string :memnum
      t.string :grpnum

      t.timestamps
    end
  end
end
