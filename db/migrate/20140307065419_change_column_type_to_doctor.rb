class ChangeColumnTypeToDoctor < ActiveRecord::Migration
  def change
  	rename_column :doctors, :country, :con
  end
end
