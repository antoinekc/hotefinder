class WelcomeController < ApplicationController
  def index
    @randusers = User.where.not(is_admin: true).includes(:avatar).limit(3).order("RANDOM()")
    # If descriptions are necessary for all users, include them directly in the query
    @randusers = @randusers.where.not(description: [nil, ''])
  end
end