class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :style
      t.belongs_to :breweries, index: true
      t.integer :score
    end
  end
end
