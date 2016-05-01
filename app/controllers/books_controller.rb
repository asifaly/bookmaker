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
      flash[:success] = I18n.t('flash_msgs.books.updation_success')
      redirect_to book_path(@book) 
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if params[:title_confirmation].downcase == @book.title.downcase
      @book.destroy
      flash[:success] = I18n.t('flash_msgs.books.deletion_success')
      redirect_to books_path
    else
      flash[:danger] = I18n.t('flash_msgs.books.deletion_failure')
      redirect_to book_path(@book)
    end
  end

  private
  def fetch_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :notes)
  end

end