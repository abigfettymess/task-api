class Api::V1::TaskController < ApplicationController
  def index
    render json: { message: 'Fact successfully updated.' }, status: 200
  end
end
