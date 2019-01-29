class CreateContacts < ActiveRecord::Migration[4.2]
  def change

    create_table :contacts do |t|
      t.text :ename
      t.text :email
      t.text :message

      t.timestamps
    end

  end
end
