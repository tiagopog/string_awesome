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
    #   >> "It's a very loooooong text!".ellipsis 8, after_a_word: true
    #   => "It's a..."
    #
    # Arguments:
    #   max_length: (Integer)
    #    - Indicates the max length expected, before ellipsis, for the result.
    #   options: (Hash)
    #    - Other options such as: 
    #      - :html_encoded - If true, the ellipsis will be displayed in HTML encoded format: &hellip;.
    #      - :after_a_word   - If true, the ellipsis will be displayed necessarily after a word.
    
    def ellipsis(max_length = 0, options = {})
      length = self.length
      
      if length > 1 and max_length <= length
        # Adjusts the max_length
        max_length  = (length / 2).round if max_length == 0
        
        # Truncates the text according to the max_length
        str = self[0...max_length]

        # Defines how the ellipsis will be displayed
        ellip = options[:html_encoded] == true ? '&hellip;' : '...'

        # If ellipsis must be applied after a word
        if options[:after_a_word] == true
          words = str.split(/\s/)
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

    # Counts how many words there are in the string limited by the max_length value.
    # 
    # Example:
    #   >> 'lorem ipsum dolor'.count_words
    #   => 3
    #   >> 'lorem ipsum dolor'.count_words 7
    #   => 1
    # Arguments:
    #   max_length: (Integer)
    #    - References where it will stop counting words in the string.
    
    def count_words(max_length = nil)
      # No duplicated whitespace
      str    = self.gsub(/[\s\W]+/, ' ')
      # Counts words
      count  = (max_length ? str[0...max_length] : str).split(/\s/).count
      # Checks whether the last word is really a word (must be followed by a whitespace)
      count -= 1 unless !max_length or (str[max_length - 1] =~ /\s/) or (!(str[max_length - 1] =~ /\W/) and (str[max_length] =~ /\s/))
      
      count
    end

    # Returns the N first words of a string.
    # 
    # Example:
    #   >> 'lorem ipsum'.first_words
    #   => 'lorem ipsum'
    #   >> 'lorem ipsum dolor'.first_words 2
    #   => 'lorem ipsum'
    # Arguments:
    #   amount: (Integer)
    #    - Indicates how many words it expects to ge
    #   options: (Hash)
    #    - Other options such as:
    #      - :as_array - If false, it will return a String instead of an Array.
    
    def first_words(amount = nil, options = {})
      words = amount ? self.split(/[\s\W]+/)[0...amount] : self
      options[:as_array] == false ? words.join(' ') : words
    end  

    # Returns the N last words of a string.
    # 
    # Example:
    #   >> 'lorem ipsum'.last_words
    #   => 'lorem ipsum'
    #   >> 'lorem ipsum dolor'.last_words 2
    #   => 'ipsum dolor'
    # Arguments:
    #   amount: (Integer)
    #    - Indicates how many words it expects to ge
    #   options: (Hash)
    #    - Other options such as:
    #      - :as_array - If false, it will return a String instead of an Array.
    
    def last_words(amount = nil, options = {})
      words = amount ? self.split(/[\s\W]+/).reverse[0...amount].reverse : self
      options[:as_array] == false ? words.join(' ') : words
    end
  end 
end
