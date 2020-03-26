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
      image_tag "user-5.png", class: "profile-user-img img-fluid img-circle"
    end
  end

end
