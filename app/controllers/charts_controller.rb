class ChartsController < ApplicationController
  before_action :set_book

  def index
    @categories = @book.categories.all
    @income = @categories.find_by(name:"収入")
    @spending = @categories.where.not(name: "収入")

    budget_data = {}
    @spending.each do |category|
      budget_data["#{category.name}"] = category.budget
    end
    budget = {name: "予算", data: budget_data}

    amount_data = {}
    @spending.each do |category|
      amount_data["#{category.name}"] = category.records_amount(@book)
    end
    amount = {name: "実績", data: amount_data}

    @column_chart_data = [budget, amount]
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

end
