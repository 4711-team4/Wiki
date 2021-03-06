require 'fastimage'
require 'open-uri'

# Lets user interact with wiki pages
class WikiPageController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
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

    if @page.locked && !authenticate_admin!
      redirect_to 'wiki_page#index'
    end
  end

  # @!method updates a wiki page with some edits
  def update
    @page = WikiPage.find(params[:id])

    if @page.locked && !authenticate_admin!
      head :unauthorized
    end

    @page.assign_attributes(wiki_page_params)
    @page.revisions.last.user = current_user
    parse_images params[:wiki_page][:revisions_attributes]["0"][:content]
    if @page.save
      redirect_to @page
    else
      flash[:error] = @page.errors.full_messages.to_sentence
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
    if @page.save
      parse_images params[:wiki_page][:revisions_attributes]["0"][:content]
      redirect_to @page
    else
      flash[:error] = @page.errors.full_messages.to_sentence
      render 'new'
    end
  end

  # @!method list all wiki pages created
  def index
    @pages = WikiPage.all
  end

  def destroy
    WikiPage.find(params[:id]).destroy
    redirect_to wiki_page_index_url
  end

  def lock
      page = WikiPage.find(params[:id])
      page.locked = true
      page.save
      redirect_to action: :show
  end

  def unlock
    page = WikiPage.find(params[:id])
    page.locked = false
    page.save
    redirect_to action: :show
  end

  # @!method checks if the form is valid for backend
  def wiki_page_params
    params.require(:wiki_page).permit(:locked, revisions_attributes: [:title, :content])
  end
  

  def parse_images(content)
    wiki_content = Nokogiri::HTML(content)
    images = wiki_content.css('img')
    images.each do |img|
      unless image_in_page?(img['src'], @page)
        image = Image.new(wiki_page_id: @page.id, user: current_user, location: img['src'])
        image.upload_date = DateTime.now
        size_array = FastImage.size(image.location)
        image.height = size_array[1]
        image.width = size_array[0]
        image.size = open(image.location).size
        image.save
      end
    end
    delete_images_if_removed images
  end

  def image_in_page?(image, page)
    page.images.each do|img|
      return true if img.location == image
    end
    false
  end

  def image_removed_from_page?(image, img_links)
    img_links.each do |img|
      return false if image.location == img['src']
    end
    true
  end

  def delete_images_if_removed(imgs)
    unless imgs.size == @page.images.size
      @page.images.each do |model|
        model.destroy if image_removed_from_page?(model, imgs)
      end
    end
  end

end
