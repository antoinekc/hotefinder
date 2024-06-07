class WelcomeController < ApplicationController
  def index
    @Users = User.all
    @randusers = User.order('RANDOM()').limit(4)
  end
end
