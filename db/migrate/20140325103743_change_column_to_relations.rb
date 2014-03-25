class ChangeColumnToRelations < ActiveRecord::Migration
  def change
  	rename_column :relations, :relation_id, :relative_id
  end
end
