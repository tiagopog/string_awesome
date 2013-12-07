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

    # Remove accents from words in the text.
    # 
    # Example:
    #   >> 'lórem ipsùm dólor sìt ãmet!'.no_accents
    #   => 'lorem ipsum dolor sit amet!'
    
    def no_accents
      self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
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
      str = self.no_accents.gsub(/\W|_/, '-').gsub(/[-]{2,}/, '-').gsub(/^-|-$/, '').to_s
      downcase ? str.downcase : str
    end

    # Append ellipsis to the text.
    # 
    # Example:
    #   >> "It's a very loooooong text!".ellipsis 11
    #   => "It's a very..."
    #
    # Arguments:
    #   max_length: (Integer)
    #    - Indicates the max length expected, before ellipsis, for the result.
    #   options: (Hash)
    #    - Other options such as 
    #      - :html_encoded - If true, the ellipsis will be displayed in HTML encoded format: &hellip;.
    #      - :after_a_word   - If true, the ellipsis will be displayed necessarily after a word.
    
    def ellipsis(max_length = 0, options = {})
      length = self.length
      
      if length > 1 and max_length <= length
        # Adjusts the max_length
        max_length  = (length / 2).round if max_length == 0
        max_length -= 1
        
        # Truncates the text according to the max_length
        str = self[0..max_length]

        # Defines how the ellipsis will be displayed
        ellip = options[:html_encoded] == true ? '&hellip;' : '...'

        # If ellipsis must be applied after a word
        if options[:after_a_word] == true
          words = str.split ' ' 
          words = words[0..words.length - 2] if words.length > 1
          str   = words.join(' ')
        else
          str = str.gsub(/\s+$/, '')
        end
         
        str + ellip
      else
        self
      end
    end

    # Reverses a string by words, instead of reversing it by every character (String#reverse).
    # 
    # Example:
    #   >> 'lorem ipsum dolor'.reverse_words
    #   => 'dolor ipsum lorem'
    
    def reverse_words
      self.split(/\s/).reverse.join(' ')
    end
  end 
end
