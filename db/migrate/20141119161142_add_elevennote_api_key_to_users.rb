class AddElevennoteApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :elevennote_api_key, :string
  end
end
