# coding: utf-8

require 'active_support/inflector'
require 'sanitize'

module StringAwesome
  # These methods are all included into the String class.
  module AwesomeMethods
  	# Replaces \n to <br /> tags.
  	# 
  	# Example:
  	#   >> "Hello 
  	#          world!".nl2br 
  	#   => "Hello <br/ > world!"

	  def nl2br
	  	self.gsub /\n/, '<br />'
	  end

	  # Converts the string to the title style and prevents other 
	  # letters in the middle of the word from being uppercase.
		# 
		# Example:
		#   >> 'loREm IPsuM DOLOR'.to_title
		#   => 'Lorem Ipsum Dolor'
	
		def to_title
			self.downcase.titleize
		end

		# Removes HTML tags from text.
		# 
		# Example:
		#   >> '<h1><a href="http://somecoolurl.com">Aloha!</a></h1>'.strip_tags 
		#   => 'Aloha!'
		#
		# Arguments:
		#  allow_whitespace: (Boolean)
		#    - Let it returns the replaced block HTML tags as whitespaces.
    
    def strip_tags(allow_whitespace = false)
    	str = Sanitize.clean self
    	allow_whitespace ? str : str.strip
    end

    # Parses text to a valid format for URL's.
    # 
		# Example:
		#   >> 'Lórem IPSUM Dolor?'.slug
		#   => 'lorem-ipsum-dolor'
		#
		# Arguments:
		#   downcase: (Boolean)
		#    - If true, it will force the String to be in downcase.
		
		def slug(downcase = true)
			str = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').gsub(/\W|_/, '-').gsub(/[-]{2,}/, '-').gsub(/^-|-$/, '').to_s
			downcase ? str.downcase : str
	  end

	  # Append ellipsis to the end of a text. By default, it will be
	  # applied to the text's half length.
    # 
		# Example:
		#   >> "It's a very loooooong text!".ellipsis 11
		#   => "It's a very..."
		#
		# Arguments:
		#   downcase: (Boolean)
		#    - If true, it will force the String to be in downcase.
		
		def ellipsis(max_length = nil, after_a_word = true, html_encoded = false)
			if self.length > 1
				max_length = (self.length / 2).round - 1 if max_length.blank?
				# html: &hellip;
				# todo: remove whitespaces "foobar ..."
				# todo: enable to append it only after words
				(self[0..max_length] + '...').gsub /\s+/, ''
			end
	  end
  end	
end
