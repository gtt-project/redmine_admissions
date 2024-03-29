class MigrateAdmissionAssignedRoles < ActiveRecord::Migration[5.2]
  def up
    Project.where.not(admission_assigned_role_id: nil).each do |p|
      p.admission_assigned_roles << Role.find(p.admission_assigned_role_id)
    end
  end
end
