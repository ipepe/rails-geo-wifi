class CreateWifiNames < ActiveRecord::Migration
  def change
    create_table :wifi_names do |t|
      t.string :ssid

      t.timestamps
    end

    add_index :wifi_names, :ssid
  end
end
