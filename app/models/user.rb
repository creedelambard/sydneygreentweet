class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter]
         
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
         return registered_user
      else
         user = User.create(
           username:            auth.info.nickname,
           provider:            auth.provider,
           uid:                 auth.uid,
           twitter_user_token:  auth.credentials.token,
           twitter_user_secret: auth.credentials.secret,
           is_active:           true,
           role:                'user',
           email:               auth.uid+"@twitter.com",
           password:            Devise.friendly_token[0,20]
         )
      end
    end
  end
end
