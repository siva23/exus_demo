class ChangeColumnToPatient < ActiveRecord::Migration
  def change
  	rename_column :patients, :country, :con
  end
end
