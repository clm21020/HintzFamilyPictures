module ItemsHelper
	# def interested_users(item)
	# 	interested_usernames = item.interested_rankings.map { |ranking| ranking.user.username }

	# 	if interested_users.empty?
	# 		users_string = "No users have"
	# 	elsif interested_users.length == 1
	# 		users_string = "#{interested_usernames.first} has"
	# 	else
	# 		users_string = "#{comma_separate_multiples(interested_usernames)} have"
	# 	end

	# 	"#{users_string} expressed interest so far"
	# end

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