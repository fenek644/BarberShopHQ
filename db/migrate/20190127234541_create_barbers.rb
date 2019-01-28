class CreateBarbers < ActiveRecord::Migration
  def change

    create_table :barbers do |t|

      t.text :name

      t.timestamps
    end

    Barber.create :name => 'Jessie Pickman'
    Barber.create :name => 'Walter White'
    Barber.create :name => 'Gus Fring'
  end
end
