module ApplicationHelper

  def format_time(time)
    if time.strftime("%Y-%m-%d") == Time.now.strftime("%Y-%m-%d")
      "today at #{time.strftime("%I:%M %p")}"
    else
      time.strftime("%I:%M %p on %b %d, %Y")
    end
  end

  def slug
    current_group.group_slug if current_group
  end

end
