class Tweet

	attr_accessor :title, :content, :author
	def initialize(title, content, author)
		@title = title
		@content = content
		@author = author
	end

	def self.all(user = nil)
		if user != nil
			user.tweets.each{|t| puts "title: #{t.title}\nauthor: #{t.author}\ntweet: #{t.content}\n\n"}
		else
			$global_tweets.each{|t| puts "title: #{t.title}\nauthor: #{t.author}\ntweet: #{t.content}\n\n"}
		end
	end 

end