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

  def profileAfterChoices_old
    @user = User.find(params[:id])    
    #To get only users that are activated
    #@users = User.where(:activated => true).order(score_time: :desc)
    @users = User.where(:activated => true).order('score_time + score_money + score_pollution DESC')
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
          @user.update_attribute :score_time, @user.score_time+10
          @user.update_attribute :score_money, @user.score_money+10
          @user.update_attribute :score_pollution, @user.score_pollution+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Metro line")
          @user.update_attribute :score_time, @user.score_time+10
          @user.update_attribute :score_money, @user.score_money+10
          @user.update_attribute :score_pollution, @user.score_pollution+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Carpooling")
          @user.update_attribute :score_time, @user.score_time+10
          @user.update_attribute :score_money, @user.score_money+10
          @user.update_attribute :score_pollution, @user.score_pollution+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Walking")
          @user.update_attribute :score_time, @user.score_time+10
          @user.update_attribute :score_money, @user.score_money+10
          @user.update_attribute :score_pollution, @user.score_pollution+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Using own Car")
          @user.update_attribute :score_time, @user.score_time+10
          @user.update_attribute :score_money, @user.score_money+10
          @user.update_attribute :score_pollution, @user.score_pollution+10
          @errand.update_attribute :choice, c
        elsif(c.include? "Cycling")
          @user.update_attribute :score_time, @user.score_time+10
          @user.update_attribute :score_money, @user.score_money+10
          @user.update_attribute :score_pollution, @user.score_pollution+10  
          @errand.update_attribute :choice, c
        end
        $i += 1
      end
    end
    redirect_to @user
  end

  def profileAfterChoices
    @user = User.find(params[:id])    
    #To get only users that are activated
    @users = User.where(:activated => true).order('score_time + score_money + score_pollution DESC')
    @rank = 0 

    #Update Score
    if(params[:choices] != nil)
      @choices = params[:choices]
      choice = @choices["optionsRadios"]
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
        @errand.update_attribute :choice, c
      elsif(c.include? "Metro line")
        @errand.update_attribute :choice, c
      elsif(c.include? "Carpooling")
        @errand.update_attribute :choice, c
      elsif(c.include? "Walking")
        @errand.update_attribute :choice, c
      elsif(c.include? "Using own Car")
        @errand.update_attribute :choice, c
      elsif(c.include? "Cycling")
        @errand.update_attribute :choice, c
      end
    end
    redirect_to @user
  end

  def choices_old
    @locations = params[:locations]
    
    @i = 1
    $count = 0
    @busResults = []
    @metroResults = []
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
        busStopsFrom = from.bus_stops
        busStopsTo = to.bus_stops

        busStopsFrom.each do |f|
          busStopsTo.each do |t|
            busLinesFrom = f.bus_lines
            busLinesTo = t.bus_lines
            if(!(busLinesFrom.empty?) && !(busLinesTo.empty?))
              common = busLinesFrom & busLinesTo
              if(!(common.empty?))
                common.each do |c|
                  @busResults.push([errand.id,f.name,t.name,c.name,carpool])
                end
              end
            end
          end
        end

        metroStopsFrom = from.metro_stops
        metroStopsTo = to.metro_stops
        
        metroStopsFrom.each do |f|
          metroStopsTo.each do |t|
            metroLinesFrom = f.metro_lines
            metroLinesTo = t.metro_lines
            if(!(metroLinesFrom.empty?) && !(metroLinesTo.empty?))
              common = metroLinesFrom & metroLinesTo
              if(!(common.empty?))
                common.each do |c|
                  @metroResults.push([errand.id,f.name,t.name,c.name,carpool])
                end
              end
            end
          end
        end

      else
        @results.push([errand.id])
      end

      $count += 3
      @i += 1
    end

    @busResults = @busResults.uniq
    @metroResults = @metroResults.uniq
    if(@busResults.size == 0 && @metroResults.size == 0)
      @results.push([errand.id])
    else
      @busResults.each do |res|
        res.push("Bus")
        @results.push(res)
      end
      @metroResults.each do |res|
        res.push("Metro")
        @results.push(res)
      end
    end
  end

  def choices

    @latStart = params[:latStart]
    @lngStart = params[:lngStart]
    @latEnd = params[:latEnd]
    @lngEnd = params[:lngEnd]
    @carpool = params[:carpool]

    @busResults = []
    @metroResults = []
    @results = []
    @errands = []

    @debug = ""

    errand = Errand.new(start_lat: @latStart, start_lng: @lngStart, end_lat: @latEnd, end_lng: @lngEnd, choice: "", user_id: params[:id])
    errand.save
    @errands.push(errand)

    busStopsStart = BusStop.near([@latStart,@lngStart], 1, :units => :km)
    busStopsEnd = BusStop.near([@latEnd, @lngEnd], 1, :units => :km)
    #@debug = busStopsStart.join(',') + "-" + busStopsEnd.join(',')

    busStopsStart.each do |stopStart|
      busStopsEnd.each do |stopEnd|
        if(stopStart != stopEnd)
          busLinesStart = stopStart.bus_lines
          busLinesEnd = stopEnd.bus_lines
          #@debug = busLinesStart.join(',') + "-" + busLinesEnd.join(',')
          if(!(busLinesStart.empty?) && !(busLinesEnd.empty?))
            common = busLinesStart & busLinesEnd
            if(!(common.empty?))
              common.each do |line|
                @busResults.push([errand.id,stopStart,stopEnd,line.name,@carpool])
              end
            end
          end
        end
      end
    end

    metroStopsStart = MetroStop.near([@latStart,@lngStart], 1, :units => :km)
    metroStopsEnd = MetroStop.near([@latEnd, @lngEnd], 1, :units => :km)

    metroStopsStart.each do |stopStart|
      metroStopsEnd.each do |stopEnd|
        if(stopStart != stopEnd)
          metroLinesStart = stopStart.metro_lines
          metroLinesEnd = stopEnd.metro_lines
          if(!(metroLinesStart.empty?) && !(metroLinesEnd.empty?))
            common = metroLinesStart & metroLinesEnd
            if(!(common.empty?))
              common.each do |line|
                @metroResults.push([errand.id,stopStart,stopEnd,line.name,@carpool])
              end
            end
          end
        end
      end
    end

    @busResults = @busResults.uniq
    @metroResults = @metroResults.uniq

    if(@busResults.size == 0 && @metroResults.size == 0)
      @results.push([errand.id])
    else
      @busResults.each do |res|
        res.push("Bus")
        @results.push(res)
      end
      @metroResults.each do |res|
        res.push("Metro")
        @results.push(res)
      end
    end

    #@results = [[errand.id, BusStop.first, BusStop.second, "348", nil, "Bus"],[errand.id, MetroStop.first, MetroStop.second, "3", nil,"Metro"]]
  end

  def addErrands
  end

  def checkin_start
    @user = User.find(params[:id])
    @errand = Errand.find(params[:errand_id])
    if(is_near(params[:lat], params[:lng], @errand.start_lat, @errand.start_lng) && params[:datetime])
      @errand.update_attribute :check_start_lat, params[:lat]
      @errand.update_attribute :check_start_lng, params[:lng]
      @errand.update_attribute :check_start_time, params[:datetime]
      render status: 200, text: ""
    else
      render status: 200, text: "The location you checked in is different from the start location of your errand."
    end
  end
  
  def checkin_end
    @user = User.find(params[:id])
    @errand = Errand.find(params[:errand_id])

    @actual_duration = ActiveSupport::TimeZone['UTC'].parse(params[:datetime]) - @errand.check_start_time
    
    #logger.debug @actual_duration

    if(@errand.choice.include?("Bus line") || @errand.choice.include?("Carpooling") || @errand.choice.include?("Using own Car") || @errand.choice.include?("Walking"))
      @estimated_duration = params[:duration].to_i
    elsif(@errand.choice.include?("Metro line"))
      distance = Geocoder::Calculations.distance_between([@errand.check_start_lat,@errand.check_start_lng],[params[:lat],params[:lng]], :units => :km)
      @estimated_duration = (distance/100)*3600 #average metro speed is 100km/hr
    elsif(@errand.choice.include?("Cycling"))
      distance = Geocoder::Calculations.distance_between([@errand.check_start_lat,@errand.check_start_lng],[params[:lat],params[:lng]], :units => :km)
      @estimated_duration = (distance/16)*3600 #average cycling speed is 16km/hr
    end

    #if the difference between the actual duration and the estimated duration is more or less than 15 minutes then there is something wrong
    diff = ((@estimated_duration-@actual_duration).abs < 900) || ((@actual_duration-@estimated_duration).abs < 900)

    if(@errand.check_start_time)
      if(is_near(params[:lat], params[:lng], @errand.end_lat, @errand.end_lng) && params[:datetime])
        if(diff)
          @errand.update_attribute :check_end_lat, params[:lat]
          @errand.update_attribute :check_end_lng, params[:lng]
          @errand.update_attribute :check_end_time, params[:datetime]
          @errand.update_attribute :done, true

          c = @errand.choice
          if(c.include? "Bus line")
            @user.update_attribute :score_time, @user.score_time+10
            @user.update_attribute :score_money, @user.score_money+10
            @user.update_attribute :score_pollution, @user.score_pollution+10
          elsif(c.include? "Metro line")
            @user.update_attribute :score_time, @user.score_time+10
            @user.update_attribute :score_money, @user.score_money+10
            @user.update_attribute :score_pollution, @user.score_pollution+10
          elsif(c.include? "Carpooling")
            @user.update_attribute :score_time, @user.score_time+10
            @user.update_attribute :score_money, @user.score_money+10
            @user.update_attribute :score_pollution, @user.score_pollution+10
          elsif(c.include? "Walking")
            @user.update_attribute :score_time, @user.score_time+10
            @user.update_attribute :score_money, @user.score_money+10
            @user.update_attribute :score_pollution, @user.score_pollution+10
          elsif(c.include? "Using own Car")
            @user.update_attribute :score_time, @user.score_time+10
            @user.update_attribute :score_money, @user.score_money+10
            @user.update_attribute :score_pollution, @user.score_pollution+10
          elsif(c.include? "Cycling")
            @user.update_attribute :score_time, @user.score_time+10
            @user.update_attribute :score_money, @user.score_money+10
            @user.update_attribute :score_pollution, @user.score_pollution+10
          end

          render status: 200, text:""
        else
          @errand.update_attribute :check_end_lat, params[:lat]
          @errand.update_attribute :check_end_lng, params[:lng]
          @errand.update_attribute :check_end_time, params[:datetime]
          @errand.update_attribute :done, true
          render status: 200, text: "The time you took to finish the errand is more than the expected. Your score will not be updated."
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
    @users = User.where(:activated => true).order('score_time + score_money + score_pollution DESC')
    @rank = 0
    Errand.all.each do |err|
      if(err.choice == "")
        err.destroy
      end
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def is_near(checked_lat, checked_lng, errand_lat, errand_lng)
      #get the locations near the place the user checked-in in, that are maximum 1 mile away
      #????????????????????????????????????????????what is an appropriate range to say a location is near another

      if(Geocoder::Calculations.distance_between([checked_lat,checked_lng],[errand_lat,errand_lng], :units => :km) < 1)
        return true
      else
        return false
      end
      # near_checked_location = Location.near([checked_lat,checked_lng], 5, :units => :km)
      # near_errand_location = Location.near([errand_lat,errand_lng], 5, :units => :km)
      # common = near_errand_location & near_checked_location
      # if(common.empty?)
      #   return false
      # else
      #   return true
      # end
    end
end
