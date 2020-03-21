module ProfilesHelper

  def gender_select
    User.genders.keys.map{|i| i}
  end

end
