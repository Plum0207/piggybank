class CategoriesController < ApplicationController
  before_action :set_book
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = @book.categories.chronological
    @income = @categories.find_by(name:"収入")
    @spending = @categories.where.not(name: "収入")

    @income_budget = @income.budget
    @income_amount = @income.records_amount(@book)

    @spending_budget = @spending.sum(:budget)
    @spending_amount = 0
    @spending.each do |category|
      @spending_amount += category.records_amount(@book)
    end

    respond_to do |format|
      format.html
      format.csv { send_data @categories.generate_csv,
      filename: "#{@book.title}-費目_#{Time.zone.now.strftime("%Y%m%d")}.csv"}
    end
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

  def update
    if @category.update(category_params)
    redirect_to book_categories_path(@book),
    notice: '費目と予算を更新しました'
    else
      flash.now[:alert] = "費目と予算を入力してください"
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to book_categories_path(@book),
    notice: '費目と予算を削除しました'
  end

  def import
    if params[:file]
      @book.categories.import(params[:file])
      redirect_to book_categories_path(@book),
      notice: '費目と予算をインポートしました'
    else
      redirect_to book_categories_path(@book)
      flash[:alert] = "インポートするファイルを選択してください"
    end
  end

  def download
    download_file_name = "public/files/import-categories.csv"
    send_file download_file_name,
    filename: "import-categories.csv",
    type: 'csv'
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
