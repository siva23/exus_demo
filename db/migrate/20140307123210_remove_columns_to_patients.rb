class RemoveColumnsToPatients < ActiveRecord::Migration
  def change
  	remove_column :patients, :rship, :string
  end
end
