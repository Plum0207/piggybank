class ChartsController < ApplicationController
  before_action :set_book

  def index
    @spending = @book.categories.where.not(name: "収入")

    budget_data = {}
    @amount_data = {}

    @spending.each do |category|
      budget_data["#{category.name}"] = category.budget
      @amount_data["#{category.name}"] = category.records_amount(@book)
    end

    @column_chart_data = [ 
      {name: "予算", data: budget_data},
      {name: "実績", data: @amount_data}
    ]
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

end