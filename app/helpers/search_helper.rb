module SearchHelper

  def prices(person)
    min = person.min_price
    max = person.max_price
    return '&ndash;'.html_safe if min + max == 0
    return "$#{min}" if min == max
    "$#{min} &ndash; $#{max}".html_safe
  end

  def langs(person)
    person.languages.empty? ? '&ndash;'.html_safe : truncate(person.languages.map(&:name).join(', '), length: 50)
  end

  def contacts_count(user, who)
    return 0 unless current_user
    ContactLog.where(user_sent: current_user.id, user_received: user.id, received_as: who).count
  end

end