module RedmineAdmissions
  module Patches
    module ProjectPatch

      def self.apply
        unless Project < self
          Project.prepend self

          Project.class_eval do
            has_and_belongs_to_many :admission_assigned_roles,
              class_name: "Role",
              join_table: "admission_assigned_roles"
            safe_attributes :admission_assigned_role_ids
          end
        end
      end

    end
  end
end
