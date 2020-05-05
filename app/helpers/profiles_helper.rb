module ProfilesHelper

  def gender_select
    User.genders.keys.map{|i| i}
  end

  def status_request_select
    PersonalRequest.statuses.keys.map{|i| "<option>#{i}</option>"}
  end

  # def request_type_select
  #   PersonalRequest.request_types.keys.map{|i| i}
  # end

  def my_group_select
    Project.all.map{|i| i}
    current_user.projects.map{|i| i}
  end

  def current_division_select
    current_division
  end

  def role_project_select
    UserProject.roles.keys.map{|i| i}
  end

  def avatar_for(user)
    if user.avatar?
      image_tag user.avatar.url(:thumb), class: "profile-user-img img-fluid img-circle"
    else
      image_tag "avatar.png", class: "profile-user-img img-fluid img-circle"
    end
  end

  def lock_task_select
    Task.locks.keys.map {|i| i}
  end

  def progress_task_select
    [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100].map {|i| ["#{i} %", i]}
  end

  def project_tag
    current_division.projects.uniq
  end

  def personal_project
    current_user.projects.uniq
  end

  def personal_parent_task
    current_user.tasks.where(parent_task: true)
  end

  def staff_type_select
    User.staff_types.keys.map{|i| i}
  end

  def workspace_select
    User.workspaces.keys.map{|i| i}
  end

  def nationality_select
    User.nationalities.keys.map{|i| i}
  end

  def positon_select
    User.positions.keys.map{|i| i}
  end

  def role_select
    User.roles.keys.map{|i| i}
  end

  def division_select
    Division.all.map{|i| i}
  end

  def division_request_select
    current_user.projects.first.divisions.where.not(id: current_division.id).uniq.map{|i| i}
  end

  def progress_project project
    @tasks = project.tasks.where(parent_task: true)

    sum_progress = @tasks.inject(0) do |sum, task|
       sum + task.progress*(task.start_time..task.end_time).count
    end

    sum_expected_day = @tasks.inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end
    if sum_expected_day != 0
      return (sum_progress.to_f / sum_expected_day).round(2)
    else
      return 0
    end
  end

  def expected_project project
    @tasks = project.tasks.where(parent_task: true)

    sum_expected_day = @tasks.inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end

    sum_progress_day =  @tasks.inject(0) do |sum, task|
      (task.end_time < Date.today) ? sum + (task.start_time..task.end_time).count : sum + (task.start_time..Date.today).count
    end

    if sum_expected_day != 0
      return (sum_progress_day.to_f / sum_expected_day *100).round(2)
    else
      return 0
    end
  end

  def progress_division project
    @tasks = current_division.tasks.where(parent_task: true, project_id: project.id).uniq

    sum_progress = @tasks.inject(0) do |sum, task|
       sum + task.progress*(task.start_time..task.end_time).count
    end

    sum_expected_day = @tasks.inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end
    if sum_expected_day != 0
      return (sum_progress.to_f / sum_expected_day).round(2)
    else
      return 0
    end
  end

  def expected_division project
    @tasks = current_division.tasks.where(parent_task: true, project_id: project.id).uniq

    sum_expected_day = @tasks.inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end

    sum_progress_day =  @tasks.inject(0) do |sum, task|
      (task.end_time < Date.today) ? sum + (task.start_time..task.end_time).count : sum + (task.start_time..Date.today).count
    end

    if sum_expected_day != 0
      return (sum_progress_day.to_f / sum_expected_day *100).round(2)
    else
      return 0
    end
  end

end
