class DropAdmissionAssignedRoleId < ActiveRecord::Migration
  def change
    remove_reference :projects, :admission_assigned_role
  end
end
