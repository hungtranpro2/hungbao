module StaticPagesHelper
  def current_division
    @current_division = current_user.division
  end
end
