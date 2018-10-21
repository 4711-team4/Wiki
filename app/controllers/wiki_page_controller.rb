# Lets user interact with wiki pages
class WikiPageController < ApplicationController

  # @!method redirects the user to a random page
  def random
    if WikiPage.all.blank?
      redirect_to action: 'list'
    else
      offset = rand(WikiPage.count)
      id = WikiPage.offset(offset).first.id
      redirect_to action: 'show', id: id
    end
  end

  # @!method shows a specific wiki page
  def show
    @page = WikiPage.find(params[:id])
  end

  # @!method lets users edit a wiki page
  def edit
    @page = WikiPage.find(params[:id])
  end

  # @!method updates a wiki page with some edits
  def update; end

  # @!method creates a new wiki page
  def new; end

  # @!method list all wiki pages created
  def list
    @pages = WikiPage.all
  end
end
