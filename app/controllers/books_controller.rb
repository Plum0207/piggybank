class BooksController < ApplicationController
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
      redirect_to root_path, notice: '帳簿を作成しました'
    else
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, {user_ids: []})
  end

end
