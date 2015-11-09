class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.string :type
      t.float :latitude
      t.float :longitude
      t.belongs_to :network_service

      t.timestamps
    end
  end
end
