class CreateNetworkServices < ActiveRecord::Migration
  def change
    create_table :network_services do |t|
      t.string :bssid
      t.belongs_to :network_name

      t.timestamps
    end
  end
end
