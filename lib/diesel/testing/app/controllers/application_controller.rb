class ApplicationController < ActionController::Base
  def show
    render :text => "", :layout => 'application'
  end
end

