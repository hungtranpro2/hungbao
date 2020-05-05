class MyWorksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_task, only: [:show]


  def index
    @q = current_user.tasks.where(parent_task: false).where(project_id: nil).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 7)
    overview @tasks
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @task = current_user.tasks.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @task = Task.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @task = Task.new task_params
    if params[:task][:start_time] <= Time.now.to_s || params[:task][:start_time] > params[:task][:end_time]
      @task.errors.add(:time_start, "time exceeding")
      render :new
    else
      if @task.save
        flash[:success] = "Bạn tạo task thành công"
        redirect_to my_works_path
      else
        render :new
      end
    end
  end

  def update
    @task = Task.find_by id: params[:id]
    if params[:task][:start_time] <= Time.now.to_s || params[:task][:start_time] > params[:task][:end_time]
      @task.errors.add(:time_start, "time exceeding")
      render :new
    else
      if @task.update(task_params)
        flash[:success] = "Cập nhật thành công"
        redirect_to my_works_path
      else
        flash.now[:error] = "Cập nhật thất bại"
        render :edit
      end
    end
  end

  def destroy
    @task = Task.find_by id: params[:id]
    if @task.destroy
      flash[:success] = "Xóa thành công"
      redirect_to my_works_path
    else
      flash.now[:error] = "Xóa thất bại"
      redirect_to errors_path
    end
  end

  private

  def task_params
    params.require(:task).permit Task::PARAMS
  end

  def correct_task
    @task = Task.find_by id: params[:id]
    return @task if @task.present?

    flash[:error] = "Task không tồn tại"
    redirect_to errors_path
  end

  def overview tasks
    @sum_days = tasks.inject(0) do |sum , task|
      sum + (task.start_time..task.end_time).count
    end
  end
end
