class CreateAdmissionAssignedRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :admission_assigned_roles, id: false do |t|
      t.references :project
      t.references :role
    end
  end
end
