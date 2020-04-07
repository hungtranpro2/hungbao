module TasksHelper

  def priority_select
    Task.priorities.keys.map{|i| i}
  end

end
