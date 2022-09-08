# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task!, only: %i[show update destroy]

  def index
    tasks = Task.all.as_json(include: { assigned_user: { only: %i[name id] } })
    respond_with_json({ tasks: tasks })
  end

  def create
    task = Task.new(task_params)
    task.save!
    respond_with_success(t("successfully_created"))
  end

  def update
    @task.update!(task_params)
    respond_with_success(t("successfully_updated"))
  end

  def show
    # respond_with_json({ task: @task, assigned_user: @task.assigned_user })
    render
  end

  def destroy
    @task.destroy!
    respond_with_json
  end

  def load_task!
    @task = Task.find_by!(slug: params[:slug])
  end

  private

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end
end
