class EntrysController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @entry = current_user.entrys.build(entry_params)
    if @entry.save
      flash[:success] = "entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "entry deleted"
    redirect_to request.referrer || root_url
  end

  private

    def entry_params
      params.require(:entry).permit(:title,:body :picture)
    end

    def correct_user
     @entry = current_user.entrys.find_by(id: params[:id])
     redirect_to root_url if @entry.nil?
    end
end
