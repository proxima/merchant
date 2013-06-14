class ChangeAroundExit < ActiveRecord::Migration
  def up
    rename_column(:exits, :source, :source_sector_id)
    rename_column(:exits, :destination, :dest_sector_id)
  end

  def down
    rename_column(:exits, :source_sector_id, :source)
    rename_column(:exits, :dest_sector_id, :destination)
  end
end
