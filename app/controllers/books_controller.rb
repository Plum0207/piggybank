class BooksController < ApplicationController

  before_action :set_book, only: [:edit, :update, :destroy]

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
      @book.categories.create(name: "収入", budget: 0)
      redirect_to books_path, notice: '帳簿を作成しました'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to books_path, notice: '帳簿を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path,
    notice: '帳簿を削除しました。'
  end

  private
  def book_params
    params.require(:book).permit(:title, {user_ids: []})
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
