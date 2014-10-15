class User

	attr_accessor :username, :password, :tweets, :following, :likes

	def initialize(username, password)
		@username = username
		@password = password
		@tweets = []
		@following = []
		@likes = []
		$global_users.push(self)
	end

	def self.sign_in(un, pw)
		match = false
		$global_users.each do |user|
			if user.username == un && user.password == pw
				$session = user
				match = true
				puts "Welcome back, #{user.username}"
				break
			end
		end
		if match == false 
			puts "Incorrect sign in credentials"
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

	def like(tweet) # takes a tweet object as an input
		if $session == self
			self.likes.push(tweet)
		else 
			puts "Please log in to like tweets"
		end 
	end

	def read_likes
		if $session == self
			self.likes.each{ |t| puts "title: #{t.title}\nauthor: #{t.author}\ntweet: #{t.content}\n\n"}
		else 
			puts "Please log in to see the tweets you've liked"
		end 
	end

end 