# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[show edit update destroy]

  # GET /bookmarks or /bookmarks.json
  def index
    @bookmarks = current_user.bookmarks
    @bookmarks = filter_bookmarks(params[:filter]) if params[:filter].present? and !params[:filter].blank?
    @bookmarks = @bookmarks.joins(:tags).where('tags.name = ?', params[:tag]) if params[:tag].present? and !params[:tag].blank?
  end

  def show; end

  def new
    @bookmark = current_user.bookmarks.new
  end

  def edit; end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)

    return render_new_bookmark unless @bookmark.save

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to bookmark_url(@bookmark), notice: 'Bookmark was successfully created.' }
      format.json { render :show, status: :created, location: @bookmark }
    end
  end

  # PATCH/PUT /bookmarks/1 or /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.turbo_stream
        format.html { redirect_to bookmark_url(@bookmark), notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def filter_bookmarks(filter)
    @bookmarks.joins(:tags)
                           .where('bookmarks.description ILIKE :filter OR ' \
                                  'bookmarks.title ILIKE :filter OR ' \
                                  'bookmarks.url ILIKE :filter OR ' \
                                  'tags.name ILIKE :filter',
                                  filter: "%#{filter}%")
                           .distinct
  end

  def render_new_bookmark
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @bookmark.errors, status: :unprocessable_entity }
    end
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :description, :tag_list)
  end
end
