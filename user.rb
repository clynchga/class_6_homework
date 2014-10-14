class User

	attr_accessor :username, :password, :tweets, :following

	def initialize(username, password)
		@username = username
		@password = password
		@tweets = []
		@following = []
		$global_users.push(self)
	end

	def sign_in
		puts "Enter your username "
		un = gets.chomp
		puts "Enter your password "
		pw = gets.chomp
		if un == self.username && pw == self.password
			$session = self
			puts "Welcome back, #{self.username}"
		else 
			puts "Sorry, wrong information. Please try again"
		end
	end

	def sign_out
		$session = nil
		puts "Sign out successful. See you later!"
	end

	def tweet
		if $session == self
			# get the tweet
			puts "Write a title for your tweet: "
			title = gets.chomp
			puts "Write your tweet: "
			body = gets.chomp
			# make a new tweet object
			new_tweet = Tweet.new(title,body,self.username)
			# store in global tweets & user tweets
			self.tweets.push(new_tweet)
			$global_tweets.push(new_tweet)
		else 
			puts "Please sign in to create a tweet"
		end
	end


	def follow(user2) #takes a user object as an input
		if $session == self
			if $global_users.include?(user2)
				self.following.push(user2) 
				puts "You are now following #{user2.username}"
			else 
				puts "Sorry, we can't find that user."
			end
		else 
			puts "Please log in to complete your request"
		end 
	end

	def followers
		# check the $global_users array for other users who are following self
		followers = $global_users.select{ |u| u.following.include?(self) }
		if followers.length > 0 
			puts "You have #{followers.length} #{followers.length == 1 ? "follower" : "followers"} : "
			followers.each{ |obj| puts obj.username}
		else 
			puts "You don't have any followers yet"
		end
	end 

	def followed
		if $session == self
			if self.following.length > 0 
				puts "You are following: "
				self.following.each{|u| puts u.username}
			else 
				puts "You haven't followed anyone yet"
			end
		else 
			puts "Please log in to see who you've followed"
		end
	end

end 