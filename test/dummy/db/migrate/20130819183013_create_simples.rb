class CreateSimples < ActiveRecord::Migration
  def change
    create_table :simples do |t|
      t.string :name
      t.integer :age
      t.string :slug

      t.timestamps
    end
  end
end
