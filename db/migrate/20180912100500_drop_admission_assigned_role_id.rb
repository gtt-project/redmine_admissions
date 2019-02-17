class DropAdmissionAssignedRoleId < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :admission_assigned_role
  end
end
