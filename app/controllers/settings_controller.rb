class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize @current_user
  end
end
