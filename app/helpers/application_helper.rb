module ApplicationHelper

  def format_time(time)
    if time.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")
      "Today at #{time.strftime("%I:%M %p")}"
    else
      time.strftime("%I:%M %p on %b %d, %Y")
    end
  end

end
