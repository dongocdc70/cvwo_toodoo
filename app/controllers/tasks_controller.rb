class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def toggle_completed
    @task = Task.find(params[:id])
    @task.toggle!(:completed)
    respond_to do |format|
        format.js
    end
  end

  def filter_by_tag
    @tag = params[:tag]
    @tasks_tag = Task.where('? = ANY(tags)', @tag)
    respond_to do |format|
      format.js do
        render partial: 'table', locals: {tasks: @tasks_tag}
      end
    end
  end

  # GET /tasks
  def index
    @tasks_today = Task.where(deadline: Date.today.beginning_of_day..Date.today.end_of_day).order(:deadline)
    @tasks_today_ongoing = @tasks_today.where(completed: false).where('deadline > ?', Time.now).count

    @tasks_other = Task.where.not(deadline: Date.today.beginning_of_day..Date.today.end_of_day).or(Task.where(deadline: nil))
    @tasks_other_ongoing = Task.where.not(deadline: Date.today.beginning_of_day..Date.today.end_of_day).where("deadline > ?", DateTime.now).or(Task.where(deadline: nil)).where(completed: false).count

    @all_tags = Task.pluck(:tags).flatten.uniq

    @tasks_untagged = Task.where("tags = '{}'")

    @i = 0
    @task = Task.new


  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @all_tags = Task.pluck(:tags).flatten.uniq
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to :root, notice: 'Task was successfully created.' }
      else
        format.html { redirect_to :root, alert: 'Task was not created. <br>Reason: '+@task.errors.full_messages.join('; ') }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to :root, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :completed, :deadline, :notes, tags: [])
    end
end
