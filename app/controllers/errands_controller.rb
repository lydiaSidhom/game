class ErrandsController < ApplicationController
	def show
	end

  	def destroy
    	@user = User.find(params[:id])
    	@errand = Errand.find(params[:errand_id])
    	@errand.destroy

    	respond_to do |format|
      		format.html { redirect_to users_profile_path(@user) }
      		format.xml  { head :ok }
    	end
  	end
end
