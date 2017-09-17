# frozen_string_literal: true

module RedmineAdmissions

  def self.setup
    RedmineAdmissions::Patches::ProjectPatch.apply
  end

  def self.enabled?(project)
    project.is_public? and project.admission_assigned_role.present?
  end

  def self.can_join?(project, user: User.current)
    user.logged? and
      enabled?(project) and
      !user.admin? and
      user.memberships.where(project: project).none?
  end

  def self.can_leave?(project, user: User.current)
      user.logged?
      enabled?(project) and
      !user.admin? and
      user.memberships.where(project: project).one? and
      m = user.memberships.where(project: project).includes(:roles).first and
      m.roles.one? and
      m.roles.first == project.admission_assigned_role
  end
end

require 'redmine_admissions/view_hooks'
