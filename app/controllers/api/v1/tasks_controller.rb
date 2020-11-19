# frozen_string_literal: true

KEY = "tasks_controller"
module Api
  module V1
    class TasksController < ApplicationController
      # before_action :find_task,
      def index
        json = Rails.cache.fetch("tasksall#{Task.collection_cache_key}", expires_in:600) do
          Task.all
        end
        render json: json

      end

      def show

        tasks = Rails.cache.fetch("specific#{Task.collection_cache_key}", expires_in: 600) do
          Task.find_by id: params[:id], user_id: @user.id
        end

        render json: { payload: tasks }
      end

      def update
        @task = Task.find(params[:id])
        if @task
          @task.update(name: params[:name]) if params[:name]
          @task.update(task_type: params[:task_type]) if params[:task_type]
          @task.update(description: params[:description]) if params[:description]

          render json: @task, status: 200
        else
          render json: { error: 'Error' }, status: 400
        end
      end

      def create
        @task = Task.new(task_params)
        @task.user = @user
        if !@task.save
          render json: { error: 'Unable to save' }, status: 400
        else
          render json: @task, status: 200
        end
      end

      def destroy
        @task = Task.find(params[:id])
        if @task
          @task.destroy
          render json: { message: 'Success' }, status: 200
        else
          render json: { message: 'Not success' }, status: 400
        end
      end

      private

      def task_params
        params.require(:task).permit(:name, :description, :task_type)
      end

    end
  end
end
