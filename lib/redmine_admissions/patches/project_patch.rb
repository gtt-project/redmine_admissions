module RedmineAdmissions
  module Patches
    module ProjectPatch
      def self.apply
        unless Project < self
          Project.prepend self
          Project.class_eval do
            safe_attributes :admission_assigned_role_id
          end
        end
      end

    end
  end
end
