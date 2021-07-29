class PagesController < ApplicationController
  # Skipping login for some pages
  # the authentication is skipped for the home action, the inly view or action that does not need to be authenticated

  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end
end
