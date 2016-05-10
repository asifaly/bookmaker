class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :translate]
  
  def index
  end

  def translate
    I18n.locale = params[:locale].to_sym
    redirect_to :back
  end
end
