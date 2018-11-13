class RevisionsController < ApplicationController
  def show
    @page = WikiPage.find(params[:wiki_page_id])
    @revision = @page.revisions.find(params[:id])
  end

  def destroy
    @page = WikiPage.find(params[:wiki_page_id])
    @revision = @page.revisions.find(params[:id])
    @revision.destroy
    byebug
    if @page.revisions.empty?
      @page.destroy
      redirect_to 'wiki_page#index'
    else
      redirect_to @page
    end
  end
end
