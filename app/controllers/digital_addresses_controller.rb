class DigitalAddressesController < ApplicationController
  def destroy
  	 @digi = DigitalAddress.find(params[:id])

  	 @digi.destroy
  	 redirect_to :back, :notice => "Information has been deleted"
  end
end
