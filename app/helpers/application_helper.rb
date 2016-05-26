module ApplicationHelper

  def format_time(time)
    if time.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")
      "today at #{time.strftime("%I:%M %p")}"
    else
      time.strftime("%I:%M %p on %b %d, %Y")
    end
  end

  def active?(url)
    if current_page?(url)
      "active"
    else
      ""
    end
  end

end
