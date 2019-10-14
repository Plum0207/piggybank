class RecordsController < ApplicationController
  before_action :set_book
  before_action :set_record, except: [:index, :new, :create]

  def index
    @records = @book.records
    respond_to do |format|
      format.html do
        @records = @records.order("date DESC").page(params[:page]).per(10)
      end
      format.csv { send_data @records.generate_csv,
      filename: "#{@book.title}_#{Time.zone.now.strftime("%Y%m%d")}.csv"}
    end
  end

  def new
    @record= Record.new
    @users=[]
    @book.users.each do |user|
      @users << user[:nickname]
    end
    @users << "共通"
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

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to book_records_path(@book),notice: '記録を更新しました'
    else
      flash.now[:alert] = "記録を入力してください"
      render :edit
    end
  end

  def destroy
    @record.destroy
    redirect_to book_records_path(@book),
    notice: '記録を削除しました'
  end

  private
  def record_params
    params.require(:record).permit(:date, :content, :amount, :category, :wallet).merge(user_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_record
    @record = Record.find(params[:id])
  end

end