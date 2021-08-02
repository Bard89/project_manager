class PagesController < ApplicationController
  # Skipping login for some pages
  # the authentication is skipped for the home action, the inly view or action that does not need to be authenticated

  skip_before_action :authenticate_user!, only: [ :home ] # authenticate user everywhere excep when the user is in home -> that's the default page for when the user first goes to the webpage

  def home # here will be what the user sees before logging in
  end
end
