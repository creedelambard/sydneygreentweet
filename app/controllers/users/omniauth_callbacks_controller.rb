class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = env["omniauth.auth"]
    # Rails.logger.info("auth is **************** #{auth.to_yaml}")
    puts "New user registration URL is #{new_user_registration_url}"
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      # that_banjo_guy is persisted
      flash[:notice] = "Welcome to Sydney!"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end