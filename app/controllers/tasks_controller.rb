class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy show]

  def index
    @tasks = Task.includes(:assignments).where(assignments: { user_id: current_user }).or(Task.where(user: current_user))
  end

  def show; end

  def new
    @task = Task.new
    @task.assignments.build
  end

  def edit
    @task.assignments.build if @task.assignments.size == 0
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :status, assignments_attributes: [:id, :user_id, :_destroy])
  end

  def require_same_user
    return if current_user == @task.user

    redirect_to(tasks_path, alert: 'You can only view, edit or delete your own task')
  end
end
