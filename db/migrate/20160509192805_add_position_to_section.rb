class AddPositionToSection < ActiveRecord::Migration
  def change
    add_column :sections, :position, :integer
    add_index :sections, :position
  end
end
