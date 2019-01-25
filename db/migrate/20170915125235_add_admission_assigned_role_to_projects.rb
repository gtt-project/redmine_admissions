class AddAdmissionAssignedRoleToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :admission_assigned_role_id, :integer
    add_foreign_key :projects, :roles,
      column: :admission_assigned_role_id,
      on_delete: :nullify
  end
end
