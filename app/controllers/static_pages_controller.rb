class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_user
  def home; end

  private

  def check_user
    return unless user_signed_in?

    redirect_to groups_path
  end
end
