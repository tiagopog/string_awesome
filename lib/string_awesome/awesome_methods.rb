# coding: utf-8

require 'active_support/inflector'

module StringAwesome
  module AwesomeMethods
	  # These methods are all included into the String class.
	  module PublicInstanceMethods
	  	# Matches \n turning them into <br /> tags.
	  	# 
	  	# Example usage:
	  	#
	  	#   "Hello 
	  	#      world!".nl2br #=> "Hello <br/ > world!"
		  #
		  def nl2br
		  	self.gsub(/\n/, '<br />').force_encoding('UTF-8')
		  end

		  # Converts the string to the title style and prevents other 
		  # letters in the middle of the word from being uppercase.
			# 
			# Example usage:
			#
			# "loREm IpSuM" #=> "Lorem Ipsum"
			#
			def to_title
				self.downcase.titleize
			end
	  end
	end
end
