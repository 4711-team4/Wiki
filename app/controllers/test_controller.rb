class TestController < ApplicationController
  before_action :authenticate_user!, only: :user
  before_action :authenticate_admin!, only: :admin
  
  def user
  end

  def admin
  end
end
