class WelcomeController < ApplicationController
  def index
    @users = User.all.with_attached_avatar
    @randusers = User.all.with_attached_avatar.order('RANDOM()').limit(4)
  end
end