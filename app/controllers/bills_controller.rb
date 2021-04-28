class BillsController < ApplicationController
  include ApplicationHelper, SessionsHelper

  def index
    @bills = current_user.bills
    render :index
  end

  def new
    @user = current_user
    @bill = Bill.new
  end

  def create
    bill_id = Bill.last.nil? ? 1 : Bill.last.id + 1
    @bill = Bill.new(:id => bill_id, :user => current_user, :name => params[:bill][:name], :description => params[:bill][:description], :amount => params[:bill][:amount])
    if @bill.valid?
      @bill.save

      print "###Bill Params"
      print params[:bill]

      params[:bill][:guests][0][:name] = current_user.name unless current_user.guest?
      Bill.calculate(bill_id,params[:bill][:amount].to_i, params[:bill][:guests])

      respond_to do |format|
				format.json { render :json => {:error => "none", :message => "Bill id: #{@bill.id} successfully added."} }
				format.html { redirect_to bill_url(@bill) }
			end
    else
        render :new
    end
  end

  def show
		@bill = Bill.find(params[:id])
		@guests = @bill.guests
		@debts = @bill.debts


		if current_user == @bill.user
			render :show
		else
			flash[:notice] = "Login required to edit bill."
			redirect_to login_url
		end
	end

  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
