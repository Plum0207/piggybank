class RecordsController < ApplicationController
  before_action :set_book
  before_action :set_record, only: [:edit, :update,:destroy]
  before_action :set_users, only: [:new, :create, :edit]

  def index
    @records = @book.records
    respond_to do |format|
      format.html do
        @q = @book.records.ransack(params[:q])
        @records = @q.result(distinct: true).recent.page(params[:page]).per(10)
      end
      format.csv { send_data @records.generate_csv,
      filename: "#{@book.title}_#{Time.zone.now.strftime("%Y%m%d")}.csv"}
    end
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

  def import
    if params[:file]
      @book.records.import(params[:file])
      redirect_to book_records_path(@book),
      notice: '記録をインポートしました'
    else
      redirect_to book_records_path(@book)
      flash[:alert] = "インポートするファイルを選択してください"
    end
  end

  def download
    download_file_name = "public/files/import-records.csv"
    send_file download_file_name,
    filename: "import-records.csv",
    type: 'csv'
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

  def set_users
    @users=[]
    @book.users_order.each do |user|
      @users << user[:nickname]
    end
    @users << "共通"
  end

end