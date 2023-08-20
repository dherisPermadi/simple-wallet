Rails.application.routes.draw do
  devise_for :users

  use_doorkeeper do
    skip_controllers :authorizations, :applications,
                     :authorized_applications
  end
end
