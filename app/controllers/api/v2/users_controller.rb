module Api
  module V2
    class UsersController < Api::BaseController
      doorkeeper_for :all
      respond_to :json

      def show
         respond_with current_user.as_json(only: [:id, :email, :user_name])
      end
    end
  end
end

