class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :login]

  def index
  end

  def about
  end

  def callback
    config = {
        :consumer_key        => 'ey3AzBioWcS5567sCRc6OZ511',
        :consumer_secret     => 'qnndBCa1aHJ7qPdIXNiv25fU3CQIsmnzMY2458MejLs5LEdEMX',
        :access_token        => current_user.user_token,
        :access_token_secret => current_user.user_secret
    }

    @client = Twitter::REST::Client.new(config)
    
    @tweet = @client.home_timeline(count: 1).first
  end
end
