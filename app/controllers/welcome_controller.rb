class WelcomeController < ApplicationController
  def index
  	@artists = Artist.all
  end
end
