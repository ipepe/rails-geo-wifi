class CreateWifiServices < ActiveRecord::Migration
  def change
    create_table :wifi_services do |t|
      t.string :bssid
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :wifi_services, :bssid, unique: true
    add_index :wifi_services, :latitude
    add_index :wifi_services, :longitude
  end
end
