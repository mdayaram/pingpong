class Team < ActiveRecord::Base
	before_save :default_values
	attr_accessible :bio, :members, :name, :smack, :league
	attr_accessible :lose_img, :win_img, :smack_img

	validates :members, :presence => true
	validates :name, :presence => true
	validates :bio, :presence => true
	validates :smack, :presence => true
	validates :league, :inclusion => { :in => %w(serious fun doubles), :message => "%{value} is not a valid league" }
	validates :lose_img, :presence => true
	validates :win_img, :presence => true
	validates :smack_img, :presence => true

	validates :name, :uniqueness => { :case_sensitive => false }

	def img_url(kind)
		return "https://dl.dropbox.com/u/9921601/moovweb/pingpong/default/#{kind}.jpg"
	end
	
	def default_values
		if self.lose_img.blank?
			self.lose_img = img_url("lose")
		end
		if self.win_img.blank?
			self.win_img = img_url("win")
		end
		if self.smack_img.blank?
			self.smack_img = img_url("smack")
		end
	end

end
