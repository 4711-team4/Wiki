# Lets user interact with wiki pages
class WikiPageController < ApplicationController

  # @!method redirects the user to a random page
  def random
    if WikiPage.all.blank?
      redirect_to action: 'index'
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

  # @!method lets users create a new wiki page
  def new
    @page = WikiPage.new
  end

  # @!method creates a new wiki page
  def create
    @page = WikiPage.new(wiki_page_params)
    redirect_to @page if @page.save
  end

  # @!method list all wiki pages created
  def index
    @pages = WikiPage.all
  end

  # @!method checks if the form is valid for backend
  def wiki_page_params
    params.require(:wiki_page).permit(:title)
  end

end
