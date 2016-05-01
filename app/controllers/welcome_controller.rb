class WelcomeController < ApplicationController
  def index
  end

  def translate
    I18n.locale = params[:locale].to_sym
    redirect_to :back
  end
end
