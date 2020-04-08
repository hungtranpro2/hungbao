module ProfilesHelper

  def gender_select
    User.genders.keys.map{|i| i}
  end

  def status_request_select
    PersonalRequest.statuses.keys.map{|i| "<option>#{i}</option>"}
  end

  def request_type_select
    PersonalRequest.request_types.keys.map{|i| i}
  end

  def my_group_select
    Project.all.map{|i| i}
  end

  def current_division_select
    current_division
  end

  def role_project_select
    UserProject.roles.keys.map{|i| i}
  end

  def percent_task_select
    Task.percents.keys.map {|i| i}
  end

  def progess_task_select
    [10, 20, 30, 40, 50, 60, 70, 80, 90, 100].map {|i| ["#{i} %", i]}
  end

  def project_tag
    current_division.projects.uniq
  end

  def parent_tasks
    [["Parent Tasks", current_user.id], ["Childrent Tasks", ]].map {|i| i}
  end

end
