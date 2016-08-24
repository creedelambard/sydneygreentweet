class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :login]

  def index
  end

  def about
  end

  def callback
  end
end
