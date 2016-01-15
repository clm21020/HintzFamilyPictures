module ItemsHelper
	def current_user_interest_level(item)
		cu_ranking = item.rankings.where(user_id: current_user.id)

		if cu_ranking.empty? || cu_ranking.first.interest_level == 0
			"neutral"
		else
			cu_ranking.first.interest_level > 0 ? "interested" : "not interested"
		end
	end

	def interested_users(item)
		interested_usernames = item.interested_rankings.map { |ranking| ranking.user.username }

		users_string = comma_separate_multiples(interested_usernames)
		users_string << "No one " if users_string.empty?

		verb = interested_usernames.length < 2 ? " has" : " have"
		"#{users_string} #{verb} expressed interest in #{item.title} so far."
	end

	def comma_separate_multiples(things)
		str = ""

		things.each_with_index do |thing, idx|
			str << thing
			str << ", " if idx < (things.length - 2)
			str << " and " if idx == (things.length - 2)
		end

		str
	end
end
