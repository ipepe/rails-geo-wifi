class CreateNetworkNames < ActiveRecord::Migration
  def change
    create_table :network_names do |t|
      t.string :ssid

      t.timestamps
    end
  end
end
