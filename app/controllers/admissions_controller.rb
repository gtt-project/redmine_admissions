class AdmissionsController < ApplicationController
  before_action :find_project_by_project_id
  accept_api_auth :create, :destroy

  def create
    if RedmineAdmissions.can_join?(@project) and
        role = @project.admission_assigned_roles.find(params[:role_id])

      Member.create_principal_memberships(
        User.current,
        project_ids: @project.id,
        role_ids: role.id
      )
      respond_to do |format|
        format.html { redirect_to project_path(@project) }
        format.any { head 201 }
      end
    else
      render_error status: 422, message: "cannot join this project"
    end
  end

  def update
    if RedmineAdmissions.can_change_role?(@project) and
      role = @project.admission_assigned_roles.find(params[:role_id])

      User.transaction do
        User.current.memberships.where(project: @project).destroy_all
        Member.create_principal_memberships(
          User.current,
          project_ids: @project.id,
          role_ids: role.id
        )
      end

      respond_to do |format|
        format.html { redirect_to project_path(@project) }
        format.any { head 204 }
      end
    else
      render_error status: 422, message: "cannot leave this project"
    end
  end

  def destroy
    if RedmineAdmissions.can_leave?(@project)
      User.current.memberships.where(project: @project).destroy_all
      respond_to do |format|
        format.html { redirect_to project_path(@project) }
        format.any { head 204 }
      end
    else
      render_error status: 422, message: "cannot leave this project"
    end
  end

end
