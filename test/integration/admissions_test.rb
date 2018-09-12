require_relative '../test_helper'

class AdmissionsTest < Redmine::IntegrationTest
  fixtures :projects, :users, :roles

  setup do
    @project = Project.find 'ecookbook'
    @project.members.delete_all
    @role = Role.find 1
    @user = User.find_by_login 'dlopper'
  end

  test 'joining and leaving a project' do
    refute RedmineAdmissions.enabled?(@project)
    refute RedmineAdmissions.can_join?(@project, user: @user)

    @project.update_columns is_public: true
    @project.admission_assigned_roles << @role

    assert RedmineAdmissions.enabled?(@project)
    assert RedmineAdmissions.can_join?(@project, user: @user)

    log_user("dlopper", "foo")

    get "/projects/ecookbook"
    assert_response :success
    assert_select 'a', /join this project/i

    # should not allow unconfigured roles
    assert_no_difference 'Member.count' do
      post '/projects/ecookbook/admissions', role_id: 2
    end

    assert_difference 'Member.count' do
      post '/projects/ecookbook/admissions', role_id: 1
    end

    refute RedmineAdmissions.can_join?(@project, user: @user)
    assert m = @user.membership(@project)
    assert_equal 1, m.roles.size
    assert_equal @role, m.roles.first

    get "/projects/ecookbook"
    assert_response :success
    assert_select 'a', /leave this project/i

    assert_difference 'Member.count', -1 do
      delete '/projects/ecookbook/admissions'
    end

    get "/projects/ecookbook"
    assert_response :success
    assert_select 'a', /join this project/i
    assert RedmineAdmissions.can_join?(@project, user: @user)
  end

  test 'should not be able to join unconfigured project' do
    @project.update_columns is_public: true

    log_user("dlopper", "foo")
    get "/projects/ecookbook"
    assert_response :success

    assert_select 'a', text: /join this project/, count: 0

    assert_no_difference 'Member.count' do
      post '/projects/ecookbook/admissions'
    end
  end

end

