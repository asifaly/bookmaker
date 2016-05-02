class ChaptersController < ApplicationController
  before_action :fetch_book
  before_action :fetch_chapter, only: [:edit, :update, :destroy]

  def create
    @chapter = @book.chapters.new(chapter_params)
    @save_success = !!@chapter.save
  end

  def edit
  end

  def update
    @chapter.update_attributes(chapter_params)
    @chapter.reload unless @chapter.valid?
  end

  def destroy
    @chapter.destroy
  end

private

  def chapter_params
    params.require(:chapter).permit(:title, :notes)
  end

  def fetch_book
    @book = Book.find(params[:book_id])
  end

  def fetch_chapter
    @chapter = @book.chapters.find(params[:id])
  end
end