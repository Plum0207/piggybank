class CategoriesController < ApplicationController
  before_action :set_book
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = @book.categories.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = @book.categories.new(category_params)
    if @category.save
      redirect_to book_categories_path(@book),
      notice: '費目と予算を追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
    redirect_to book_categories_path(@book), notice: '費目と予算を更新しました'
    else
      flash.new[:alert] = "費目と予算を入力してください"
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to book_categories_path(@book),
    notice: '費目と予算を削除しました'
  end

  private

  def category_params
    params.require(:category).permit(:name, :budget)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
