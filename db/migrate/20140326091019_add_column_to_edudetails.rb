class AddColumnToEdudetails < ActiveRecord::Migration
  def change
    add_column :edudetails, :doctor_id, :integer
  end
end
