# frozen_string_literal: true

module Api
  module V1
    class TaskController < ApplicationController
      def index
        render json: { message: 'Fact successfully updated.' }, status: 200
      end
    end
  end
end
