class AddColumnsToInsurances < ActiveRecord::Migration
  def change
  	add_column :insurances, :insurable_id, :integer
  	add_column :insurances, :insurable_type, :string
  end
end
