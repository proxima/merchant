class CreateRestrictions < ActiveRecord::Migration
  def up
    create_table :restrictions do |t|
      t.string :name
      t.timestamps
    end
 
    Restriction.create(name: "Good")
    Restriction.create(name: "Evil")
  end

  def down
    drop_table :restrictions
  end
end
