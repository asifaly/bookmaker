class BooksController < ApplicationController
  before_action :fetch_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    if @book.save
      flash[:success] = I18n.t('flash_msgs.books.creation_success')
      redirect_to books_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes(book_params)
      if params[:book][:sorted_chapter_ids]
        render nothing: true
      else
        flash[:success] = I18n.t('flash_msgs.books.updation_success')
        redirect_to book_path(@book) 
      end
    else
      render :edit
    end
  end

  def show
    @chapters = @book.chapters.includes(:sections).all
    @new_chapter = @book.chapters.new
    @new_sections = {}
    @chapters.each do |chapter|
      @new_sections[chapter.id] = chapter.sections.new
    end
  end

  def destroy
    if params[:title_confirmation].downcase == @book.title.downcase
      @book.destroy
      flash[:success] = i18n.t('flash_msgs.books.deletion_success')
      redirect_to books_path
    else
      flash[:danger] = i18n.t('flash_msgs.books.deletion_failure')
      redirect_to book_path(@book)
    end
  end

  private
  def fetch_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :notes, :sorted_chapter_ids)
  end

end
