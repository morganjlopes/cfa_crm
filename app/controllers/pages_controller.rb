class PagesController < ApplicationController
  def home
  	@tab_name         = ""
    @page_title       = "Start Here"
    @page_subtitle    = "Build a Healthy Community"
    @page_description = ""
  end
end
