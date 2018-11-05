# Lets user interact with wiki pages
class WikiPageController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :authenticate_admin!, only: :destroy

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
    @revisions = @page.revisions.all.sort_by{|revision| revision.created_at}
    @current_revision = @revisions.last
  end

  # @!method lets users edit a wiki page
  def edit
    @page = WikiPage.find(params[:id])
  end

  # @!method updates a wiki page with some edits
  def update
    @page = WikiPage.find(params[:id])
    if @page.update(wiki_page_params)
      redirect_to @page
    else
      flash[:error] = 'Could not save your changes' # let the user know about the error
      render 'edit'
    end
  end

  # @!method lets users create a new wiki page
  def new
    @page = WikiPage.new
  end

  # @!method creates a new wiki page
  def create
    @page = WikiPage.new(wiki_page_params)
    @page.revisions.last.user = current_user
    redirect_to @page if @page.save!
  end

  # @!method list all wiki pages created
  def index
    @pages = WikiPage.all
  end

  def destroy
    WikiPage.find(params[:id]).destroy
    redirect_to wiki_page_index_url
  end

  # @!method checks if the form is valid for backend
  def wiki_page_params
    params.require(:wiki_page).permit(:locked, revisions_attributes: [:title, :content])
  end
end
