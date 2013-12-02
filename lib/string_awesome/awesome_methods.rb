# encoding: UTF-8

module StringAwesome
  module AwesomeMethods
	  # These methods are all included into the String class.
	  module PublicInstanceMethods
	  	# Matches \n turning them into <br /> tags.
	  	# Usage:
	  	#
	  	#   "Hello 
	  	#      world!".nl2br #=> "Hello <br/ > world!"
		  #
		  def nl2br
		  	self.gsub(/\n/, '<br />').force_encoding('UTF-8')
		  end
	  end
	end
end
