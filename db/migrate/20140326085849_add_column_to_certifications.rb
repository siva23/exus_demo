class AddColumnToCertifications < ActiveRecord::Migration
  def change
    add_column :certifications, :doctor_id, :integer
  end
end
