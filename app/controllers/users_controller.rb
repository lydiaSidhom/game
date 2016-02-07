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
    @users = User.all.order(score: :desc)
    @rank = 0 

    #Update Score
    @choices = params[:choices]
    $i = 1
    while $i <= @choices.size
      choice = @choices["optionsRadios#{$i}"]
      e = ""

      $s=0
      while(is_number?(choice[$s]))
        e = e + choice[$s]
        $s += 1
      end

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

    render 'profile'
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
              end
            end
          end
        end
      end

      $count += 3
      @i += 1
    end
    @results = @results.uniq
  end

  def addErrands
  end

  def checkin
    @user = User.find(params[:id])
    @user.update_attribute :score, @user.score+10
    @lat_lng = cookies[:lat_lng].split("|")
    render 'new'
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
