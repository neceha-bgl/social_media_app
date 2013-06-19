module Api
  module V1
    class UsersController < Api::BaseController
      doorkeeper_for :all
      respond_to :json

      def show
        respond_with current_user.as_json(only: [:id, :email])
      end
    end
  end
end
