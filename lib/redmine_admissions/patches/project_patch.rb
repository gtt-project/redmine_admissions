module RedmineAdmissions
  module Patches
    module ProjectPatch
      def self.apply
        unless Project < self
          Project.prepend self
          Project.class_eval do
            belongs_to :admission_assigned_role, class_name: 'Role'
            safe_attributes :admission_assigned_role_id
          end
        end
      end

    end
  end
end
