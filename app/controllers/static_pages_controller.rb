class StaticPagesController < ApplicationController
  def home
    @user = User.new
  end

  def help
  end

  def about
  end

  def contact
  end

  #each week:
  #1) change boundaries to current week
  #2) add 3 new challenges
  #3) check if challenges fullfilled

  def challenges
    if(Time.now.saturday?)
      @user = User.find(params[:user_id])

      @week_errands = @user.errands.where(:check_start_time => ("2016-02-14 08:00:00".."2016-02-21 23:00:00"), :check_end_time => ("2016-02-14 08:00:00".."2016-02-21 23:00:00"))

      @car_use = @week_errands.where("choice like?","#{"Using own Car"}%")
      if(@car_use.size <= 2)
        @ch1 = ["Use car only twice or less per week",true]
        @user.update_attribute :score, @user.score+100
      else
        @ch1 = ["Use car only twice or less per week",false]
      end

      cost = 0
      @week_errands.each do |e|
        if(e.choice.starts_with?("Metro"))
          cost+=1
        elsif(e.choice.starts_with?("Bus"))
          cost+=2  
        elsif(e.choice.starts_with?("Using own Car")) ########################### why 50??
          cost+=50
        end
      end
      if(cost <= 30)
        @ch2 = ["Don't spend more than 30 pounds on transportation",true]
        @user.update_attribute :score, @user.score+100
      else
        @ch2 = ["Don't spend more than 30 pounds on transportation",false]
      end

      @metro_use = @week_errands.where("choice like?","#{"Metro"}%")
      if(@metro_use.size >= 5)
        @ch3 = ["Use metro at least 5 times per week",true]
        @user.update_attribute :score, @user.score+100
      else
        @ch3 = ["Use metro at least 5 times per week",false]
      end

      #save and reset values with each new set of challenges
    else
      @ch1 = ["Use car only twice or less per week",false]
      @ch2 = ["Don't spend more than 30 pounds on transportation",false]
      @ch3 = ["Use metro at least 5 times per week",false]
    end
  end
end
