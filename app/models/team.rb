class Team < ActiveRecord::Base
  attr_accessible :bio, :members, :name, :smack, :league
	attr_accessible :lose_img, :win_img, :smack_img

	def img_url(kind)
		#This will take a given title (My & Title5:) and:
		#* downcase it (my & title5:)
		#* * replace one or more white space characters with a - (my-&-title5:)
		#* * replace non letters/number characters with nothing (my--title5)
		#* * replace multiple occurrences of - with - (my-title5)
		url = name.downcase.gsub(/\s+/, '-').gsub(/[^a-z0-9_-]/, '').squeeze('-')
		return "https://dl.dropbox.com/u/9921601/moovweb/pingpong/teams/#{league}/#{name}/#{kind}.jpg"
	end

	def lose_img
		return img_url("lose")
	end

	def win_img
		return img_url("win")
	end

	def smack_img
		return img_url("smack")
	end
end
