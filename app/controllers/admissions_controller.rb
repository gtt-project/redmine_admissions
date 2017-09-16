class AdmissionsController < ApplicationController
  before_action :find_project_by_project_id
  accept_api_auth :create, :destroy

  def create
    if RedmineAdmissions.can_join?(@project)
      Member.create_principal_memberships(
        User.current,
        project_ids: @project.id,
        role_ids: @project.admission_assigned_role_id
      )
      redirect_to project_path(@project)
    else
      render_error status: 422, message: "cannot join this project"
    end
  end

  def destroy
    if RedmineAdmissions.can_leave?(@project)
      User.current.memberships.where(project: @project).destroy_all
      redirect_to project_path(@project)
    else
      render_error status: 422, message: "cannot leave this project"
    end
  end

end
