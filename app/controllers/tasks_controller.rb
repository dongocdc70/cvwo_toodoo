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
  # GET /tasks.json
  def index
    @tasks_today = Task.where(deadline: Date.today.beginning_of_day..Date.today.end_of_day).order(:deadline)
    @tasks_today_ongoing = @tasks_today.where(completed: false).where('deadline > ?', Time.now).count

    @tasks_other_0 = Task.where.not(deadline: Date.today.beginning_of_day..Date.today.end_of_day)
    @tasks_other = @tasks_other_0.or(Task.where(deadline: nil))
    @tasks_other_ongoing = @tasks_other_0.where("deadline > ?", DateTime.now).or(Task.where(deadline: nil)).where(completed: false).count

    @all_tags = Task.pluck(:tags).flatten.uniq

    @tasks_untagged = Task.where("tags = '{}'")

    @i = 0
    @task = Task.new


  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to :root, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to :root, alert: 'Task was not created. <br>Reason: '+@task.errors.full_messages.join('; ') }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to :root, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :completed, :deadline, tags: [])
    end
end
