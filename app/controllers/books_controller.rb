class BooksController < ApplicationController

  before_action :set_book, only: [:edit, :update]
  def index
    @books = current_user.books.order("title ASC")
  end

  def new
    @book = Book.new
    @book.users << current_user
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to new_book_category_path(@book), notice: '帳簿を作成しました。<br>カテゴリーと予算を設定してください。'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to root_path, notice: '帳簿を編集しました。'
    else
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, {user_ids: []})
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
