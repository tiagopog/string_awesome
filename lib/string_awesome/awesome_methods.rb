# coding: utf-8

require 'active_support/inflector'

module StringAwesome
  # These methods are all included into the String class.
  module AwesomeMethods
  	# Replaces \n to <br /> tags.
  	# 
  	# Example:
  	#   >> "Hello 
  	#          world!".nl2br 
  	#   #=> "Hello <br/ > world!"

	  def nl2br
	  	self.gsub /\n/, '<br />'
	  end

	  # Converts the string to the title style and prevents other 
	  # letters in the middle of the word from being uppercase.
		# 
		# Example:
		#   >> "loREm IPsuM DOLOR" 
		#   #=> "Lorem Ipsum Dolor"
	
		def to_title
			self.downcase.titleize
		end

		# Removes HTML tags from text.
		# 
		# Example:
		#   >> "<h1><a href="http://somecoolurl.com">Aloha!</a></h1>" 
		#   #=> "Aloha!"
    
    def strip_tags
      Sanitize.clean self
    end
  end	
end
