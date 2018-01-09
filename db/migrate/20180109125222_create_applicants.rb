class CreateApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :region
      t.string :phone
      t.string :email, null: false
      t.string :phone_type
      t.string :source
      t.boolean :over_21
      t.text :reason
      t.string :workflow_state, default: "applied"
      t.timestamps
    end
  end
end
