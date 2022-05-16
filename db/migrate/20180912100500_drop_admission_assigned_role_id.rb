class DropAdmissionAssignedRoleId < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :projects, :roles,
      column: :admission_assigned_role_id,
      on_delete: :nullify
    remove_column :projects, :admission_assigned_role_id, :integer
  end
end
