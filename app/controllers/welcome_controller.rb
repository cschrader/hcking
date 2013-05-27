class WelcomeController < ApplicationController
  def index
    single_events = SingleEvent.recent_to_soon(4.weeks)
    events_by_day = Calendar.events_by_day(single_events)
    @mini_calendar_events = Calendar.fill_gaps(events_by_day, Date.today - 4.weeks, Date.today + 4.weeks)
    @first_row = Box.first_grid_row
    @second_row = Box.second_grid_row
    @carousel = Box.in_carousel

  end

 def city
    @city = City.find_by_name params[:city].camelize
    single_events = SingleEvent.recent_to_soon_by_city(4.weeks,@city.id)
    events_by_day = Calendar.events_by_day(single_events)
    @mini_calendar_events = Calendar.fill_gaps(events_by_day, Date.today - 4.weeks, Date.today + 4.weeks)
    @first_row = Box.first_grid_row_by_city(@city.id)
    @second_row = Box.second_grid_row_by_city(@city.id)
    @carousel = Box.in_carousel_by_city(@city.id)

    render :template => 'welcome/index'
 end

end
