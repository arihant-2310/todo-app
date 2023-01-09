class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy show]

  def index
    @tasks = current_user.all_tasks
  end

  def show
    @comment = @task.comments.build
  end

  def new
    @task = Task.new
    @task.assignments.build
  end

  def edit
    @task.assignments.build if @task.assignments.size == 0
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to task_url(@task), notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_url(@task), notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :status, assignments_attributes: [:id, :user_id, :_destroy])
  end

  def task_assigned?
    @task.assignees.include?(current_user)
  end

  def require_same_user
    return if current_user == @task.user || task_assigned?

    redirect_to(tasks_path, alert: 'You can only view, edit or delete your own task')
  end
end
