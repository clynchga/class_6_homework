# define global variables
$session = nil
$global_tweets = []
$global_users = []

# include the Tweet and User class
require_relative "user"
require_relative "tweet"

# write a command line interface that allows you to sign up users, sign in, sign out, tweet, follow,
# like tweets, see followers, see followed, and see liked tweets

command = true

while command == true
	puts "---------------------------------------------------------"
	puts "Welcome to the Twitter machine"
	puts "Please type a number to select from the commands below:"
	puts "0: end the program"
	puts "1: create a new user"
	puts "2: sign a user in"
	puts "3: sign out the current user"
	puts "4: create a tweet (must be signed in)"
	puts "5: follow another user (must be signed in)"
	puts "6: like a tweet (must be signed in)"
	puts "7: see who has followed the current user (must be signed in)"
	puts "8: see who the current user is following (must be signed in)"
	puts "9: see all published tweets"
	puts "10: see all tweets for a user"
	puts "11: see all tweets the current user has liked"
	puts "12: list all users\n"

	input = gets.chomp

	case input
	when "1"
		puts "Enter a username: "
		un = gets.chomp
		puts "Enter a password: "
		pw = gets.chomp 
		User.new(un,pw)
		puts "User created!"

	when "2"
		puts "Enter a username: "
		un = gets.chomp
		puts "Enter a password: "
		pw = gets.chomp 
		User.sign_in(un,pw)

	when "3"
		$session.sign_out


	when "4"
		if $session != nil
			$session.tweet
		else 
			puts "please sign in to tweet"
		end

	when "5"
		if $session != nil
			puts "Enter the username to follow"
			username2 = gets.chomp
			# find the user object that corresponds to that username in $global_users
			i = $global_users.index{ |u| u.username == username2}
			$session.follow($global_users[i])
		else 
			puts "please sign in a user first"
		end

	when "6"
		if $session != nil
			puts "Enter the title of the tweet you want to like "
			title = gets.chomp
			i = $global_tweets.index{ |t| t.title == title}
			$session.like($global_tweets[i])
		else 
			puts "please sign in first"
		end

	when "7"
		if $session != nil
			$session.followers
		else 
			puts "please sign in first"
		end

	when "8"
		if $session != nil
			$session.followed
		else 
			puts "please sign in first"
		end

	when "9"
		Tweet.all

	when "10"
		puts "Enter the username you'd like to see tweets for "
		un = gets.chomp
		i = $global_users.index{ |u| u.username == un}
		Tweet.all($global_users[i])

	when "11"
		$session.read_likes

	when "12"
		$global_users.each{ |u| puts u.username}

	when "0"
		puts "Ending program."
		command = false
		break

	end

end 