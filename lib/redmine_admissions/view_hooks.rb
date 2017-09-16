module RedmineAdmissions
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_projects_form,
      partial: 'redmine_admissions/projects_form_hook'

    render_on :view_projects_show_sidebar_bottom,
      partial: 'redmine_admissions/projects_show_sidebar_bottom_hook'
  end
end
