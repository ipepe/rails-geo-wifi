class CreateWifiObservations < ActiveRecord::Migration
  def change
    create_table :wifi_observations do |t|
      t.string :type
      t.float :latitude
      t.float :longitude
      t.belongs_to :wifi_service
      t.belongs_to :wifi_name
      t.text :raw_info_json

      t.timestamps
    end

    add_index :wifi_observations, :type
    add_index :wifi_observations, :latitude
    add_index :wifi_observations, :longitude
    add_index :wifi_observations, :wifi_name_id
    add_index :wifi_observations, :wifi_service_id
    add_index :wifi_observations, :raw_info_json, unique: true

  end
end
