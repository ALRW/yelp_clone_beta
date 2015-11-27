module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = 5 - rating
    '★' * rating.round + '☆' * remainder
  end

  def time_ago(review)
    (Time.now - review.created_at).to_i
  end

  def time_since(review)
    # units_of_time = {
    #   1 => proc{time_ago(review).to_s + " seconds ago"},
    #   60 => proc{(time_ago(review)/60).to_s + " minutes ago"} ,
    #   3600 => proc{(time_ago(review)/3600).to_s + " hours ago"},
    #   86_400 => proc{(time_ago(review)/86_400).to_s + " days ago"},
    #   31_536_000 => proc{(time_ago(review)/31_536_000).to_s + " years ago"}
    # }

    # array_of_times = units_of_time.map{|units, seconds| (time_ago(review)/seconds) }
    #
    # array_of_times.select{|time| time > 0}.first


    case
      when time_ago(review) < 60 then time_ago(review).to_s + " seconds ago"
      when time_ago(review) < 3600 then (time_ago(review)/60).to_s + " minutes ago"
      when time_ago(review) < 86_400 then (time_ago(review)/3600).to_s + " hours ago"
      when time_ago(review) < 31_536_000 then (time_ago(review)/86_400).to_s + " days ago"
      else (time_ago(review)/31_536_000).to_s + " years ago"
    end
  end
end
