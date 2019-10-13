class CategoriesController < ApplicationController
  before_action :set_book

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end
end
