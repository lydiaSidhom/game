class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render 'home'
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to TrafficLess!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def choices
    @user = User.find(params[:id])
    @user.update_attribute :score, @user.score+10

    @locations = params[:locations]
    
    $i = 1
    $count = 0
    @results = []
    while $count < @locations.size
      from = Location.find_by_name(@locations["locationFrom#{$i}"])
      to = Location.find_by_name(@locations["locationTo#{$i}"])
      #carpool = @locations[$i+2]
      if(!(from.nil?) && !(to.nil?))
        stopsFrom = from.bus_stops
        stopsTo = to.bus_stops

        stopsFrom.each do |f|
          stopsTo.each do |t|
            lf = f.bus_lines
            lt = t.bus_lines
            if(!(lf.empty?) && !(lt.empty?))
              common = lf & lt
              if(!(common.empty?))
                common.each do |c|
                  @results.push([f.name,t.name,c.name])
                end
              end
            end
          end
        end
      end

      $count += 2
      $i += 1
    end
    @results = @results.uniq
  end

  def addErrands
  end

  def profile
    @user = User.find(params[:id])
    @users = User.all.order(score: :desc)
    @rank = 0 
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
