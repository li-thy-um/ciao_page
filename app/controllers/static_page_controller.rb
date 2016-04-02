class StaticPageController < ApplicationController
	include SessionHelper
	before_action :should_login, only: [:admin]

  def about
  end

  def admin
  end
end
