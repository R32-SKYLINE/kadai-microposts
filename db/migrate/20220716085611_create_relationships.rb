class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :user, null: false, foreign_key: true
      #follow_idはusersテーブルを参照させたい
      t.references :follow, null: false, foreign_key: { to_table: :users }

      t.timestamps
      
      #user_idとfollow_idのペアで重複する物を保存しない
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
