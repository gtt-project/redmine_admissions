# frozen_string_literal: true

module RedmineAdmissions

  def self.setup
    RedmineAdmissions::Patches::ProjectPatch.apply
  end

end

require 'redmine_admissions/view_hooks'
