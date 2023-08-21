module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      before_action :check_username, only: :create
      def create
        if @user.save
          @user.create_token

          render json: @user, serializer: RegistrationSerializer
        else
          render json: { response: 'Bad Request' }, status: 400
        end
      end

      protected

      def sign_up_params
        params.fetch(:registration, {}).permit(:username)
      end

      def check_username
        @user = User.new(sign_up_params)

        if User.where('LOWER(username) = LOWER(?)', @user.username).present?
          render json: { response: 'Username already exists' }, status: 409
        end
      end
    end
  end
end
