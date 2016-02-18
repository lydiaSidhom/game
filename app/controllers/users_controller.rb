class UsersController < ApplicationController
  respond_to :js, :html, :json

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
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def is_number? string
    true if Float(string) rescue false
  end

  def profileAfterChoices
    @user = User.find(params[:id])    
    #To get only users that are activated
    @users = User.where(:activated => true).order(score: :desc)
    @rank = 0 

    #Update Score
    if(params[:choices] != nil)
      @choices = params[:choices]
      $i = 1
      while $i <= @choices.size
        choice = @choices["optionsRadios#{$i}"]
        e = ""

        #get errand number
        $s=0
        while(is_number?(choice[$s]))
          e = e + choice[$s]
          $s += 1
        end

        #getting choice string
        size = e.length
        $s=size
        c = ""
        while($s < choice.length)
          c = c + choice[$s]
          $s += 1
        end

        @errand = Errand.find(e.to_i)
        if(c.include? "Bus line")
          @user.update_attribute :score, @user.score+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Metro line")
          @user.update_attribute :score, @user.score+20
          @errand.update_attribute :choice, c
        elsif(c.include? "Carpooling")
          @user.update_attribute :score, @user.score+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Walking")
          @user.update_attribute :score, @user.score+40
          @errand.update_attribute :choice, c
        elsif(c.include? "Using own Car")
          @user.update_attribute :score, @user.score-10   
          @errand.update_attribute :choice, c
        end
        $i += 1
      end
    end
    redirect_to @user
  end

  def choices

    @locations = params[:locations]
    
    @i = 1
    $count = 0
    @results = []
    @errands = []
    while $count < @locations.size
      from = Location.find_by_name(@locations["locationFrom#{@i}"])
      to = Location.find_by_name(@locations["locationTo#{@i}"])

      errand = Errand.new(start_id: from.id, end_id: to.id, choice: "", user_id: params[:id])
      errand.save
      @errands.push(errand)

      carpool = @locations["carpool#{@i}"]
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
                  @results.push([errand.id,f.name,t.name,c.name,carpool])
                end
              else
                @results.push([errand.id])
              end
            else
              @results.push([errand.id])
            end
          end
        end
      else
        @results.push([errand.id])
      end

      $count += 3
      @i += 1
    end
    @results = @results.uniq
  end

  def addErrands
  end

  def checkin_start
    @user = User.find(params[:id])
    @errand = Errand.find(params[:errand_id])
    if(is_near(params[:lat], params[:lng], @errand.start.lat, @errand.start.lng))
      if(params[:datetime])
        @errand.update_attribute :check_start_time, params[:datetime]
      end
    else
      render status: 200, text: "The location you checked in is different from the start location of your errand."
    end
  end
  
  def checkin_end
    @user = User.find(params[:id])
    @errand = Errand.find(params[:errand_id])
    if(@errand.check_start_time)
      if(is_near(params[:lat], params[:lng], @errand.end.lat, @errand.end.lng) && params[:datetime])
      #if(@errand.check_start_time && is_near(params[:lat], params[:lng], @errand.end.lat, @errand.end.lng) && params[:datetime])
        if(params[:datetime])
          @errand.update_attribute :check_end_time, params[:datetime]
          @errand.update_attribute :done, true
        end
      else
        render status: 200, text: "The location you checked in is different from the end location of your errand."
      end
    else
      render status: 200, text: "You have not checked in at the start yet."
    end
  end

  def profile
    @user = User.find(params[:id])
    #To get only users that are activated
    @users = User.where(:activated => true).order(score: :desc)
    @rank = 0
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def is_near(checked_lat, checked_lng, errand_lat, errand_lng)
      #get the locations near the place the user checked-in in, that are maximum 1 mile away
      #????????????????????????????????????????????what is an appropriate range to say a location is near another
      near_checked_location = Location.near([checked_lat,checked_lng],4, :units => :km)
      near_errand_location = Location.near([errand_lat,errand_lng],4, :units => :km)
      common = near_errand_location & near_checked_location
      if(common.empty?)
        return false
      else
        return true
      end
    end
end
