module RedmineAdmissions
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_projects_form, partial: 'redmine_admissions/projects_form_hook'
  end
end
