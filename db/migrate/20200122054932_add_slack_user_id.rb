class AddSlackUserId < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :slack_id, :string
    add_index :users, :slack_id
  end
end
