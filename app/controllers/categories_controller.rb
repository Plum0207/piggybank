class CategoriesController < ApplicationController
  before_action :set_book

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = @book.categories.new(category_params)
    if @category.save
      redirect_to book_categories_path(@book),
      notice: 'カテゴリーを追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def category_params
    params.require(:category).permit(:name, :budget)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
