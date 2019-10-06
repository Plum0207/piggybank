class RecordsController < ApplicationController
  before_action :set_book

  def index
    @records = @book.records.all
  end

  def new
    @record= Record.new
  end

  def create
    @record = @book.records.new(record_params)
    if @record.save
      redirect_to book_records_path(@book),
      notice: '記録を追加しました'
    else
      render :new
    end
  end

  def record_params
    params.require(:record).permit(:date, :content, :amount, :wallet).merge(user_id: current_user.id)
  end

  def set_book
    @book= Book.find(params[:book_id])
  end

end