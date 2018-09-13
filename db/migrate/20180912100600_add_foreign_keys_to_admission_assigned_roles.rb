class AddForeignKeysToAdmissionAssignedRoles < ActiveRecord::Migration
  def change
    add_foreign_key :admission_assigned_roles, :projects,
      column: :project_id, on_delete: :cascade
    add_foreign_key :admission_assigned_roles, :roles,
      column: :role_id, on_delete: :cascade
  end
end

