class HomeController < ApplicationController
	include SessionHelper
  before_action :should_login, only: [:admin]
  def index
  end

  def about
  end

  def admin
  end
end
