# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[show edit update destroy]
  before_action :collect_bookmarks, only: %i[index]
  def index
    @bookmarks = filter_bookmarks(params[:filter])
    return unless params[:tag].present? && !params[:tag].blank?

    @bookmarks = @bookmarks.joins(:tags).where('tags.name = ?',
                                               params[:tag])
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

  def update
    return render_edit_bookmark unless @bookmark.update(bookmark_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to bookmark_url(@bookmark), notice: 'Bookmark was successfully updated.' }
      format.json { render :show, status: :ok, location: @bookmark }
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
    return @bookmarks unless params[:filter].present? && !params[:filter].blank?

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

  def render_edit_bookmark
    respond_to do |format|
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @bookmark.errors, status: :unprocessable_entity }
    end
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def collect_bookmarks
    @bookmarks = current_user.bookmarks.paginate(page: params[:page], per_page: 5).order('bookmarks.title ASC')
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :description, :tag_list)
  end
end
