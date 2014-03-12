class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :cname
      t.string :cnum
      t.date :expd
      t.string :biladd
      t.string :bilcity
      t.string :bilstate
      t.string :bilzip

      t.timestamps
    end
  end
end
