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

    # Converts the string into a title style and prevents 
    # other letters in the middle of the word from being uppercase.
    # 
    # Example:
    #   >> 'loREm IPsuM DOLOR'.to_title
    #   => 'Lorem Ipsum Dolor'

    def to_title
      self.downcase.titleize
    end

    # Removes all HTML tags from text.
    # 
    # Example:
    #   >> '<h1><a href="http://somecoolurl.com">Aloha!</a></h1>'.strip_tags 
    #   => 'Aloha!'
    
    def strip_tags
      Sanitize.clean(self).gsub(/\s+/, ' ').strip
    end

    # Removes accents from words in the text.
    # 
    # Example:
    #   >> 'lórem ipsùm dólor sìt ãmet!'.no_accents
    #   => 'lorem ipsum dolor sit amet!'
    
    def no_accents
      self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    end

    # Parses the text to a valid format for URLs.
    # 
    # Example:
    #   >> 'Lórem IPSUM Dolor?'.slug
    #   => 'lorem-ipsum-dolor'
    #
    # Arguments:
    #   downcase: (Boolean)
    #    - If true, it will force the String to be in downcase.
    
    def slug(downcase = true)
      str = self.no_accents.words.join '-'
      downcase ? str.downcase : str
    end

    # Returns an array with all the words from the string.
    # 
    # Example:
    #   >> 'Lorem! Ipsum dolor, sit amet 2013.'.words
    #   => ['Lorem', 'Ipsum', 'dolor', 'sit', 'amet', '2013']
    
    def words
      self.split(/[\s\W]+/)
    end

    # Reverses a string by words, instead of reversing it by characters.
    # 
    # Example:
    #   >> 'lorem ipsum dolor'.reverse_words
    #   => 'dolor ipsum lorem'
    
    def reverse_words
      self.words.reverse.join(' ')
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
      # Counts words
      count  = (max_length ? self[0...max_length] : self).words.count
      # Checks if the last word is complete
      count -= 1 if max_length and self[max_length - 1, 2] =~ /\w{2}/
      
      count
    end

    # Returns an Array with the N first words from the text.
    # 
    # Example:
    #   >> 'lorem ipsum'.first_words
    #   => 'lorem ipsum'
    #   >> 'lorem ipsum dolor'.first_words 2
    #   => 'lorem ipsum'
    # Arguments:
    #   amount: (Integer)
    #    - Indicates how many words it expects to ge
    
    def first_words(amount = nil)
      amount ? self.words[0...amount] : self.words
    end  

    # Returns am Array with the N last words from the text.
    # 
    # Example:
    #   >> 'lorem ipsum'.last_words
    #   => 'lorem ipsum'
    #   >> 'lorem ipsum dolor'.last_words 2
    #   => 'ipsum dolor'
    # Arguments:
    #   amount: (Integer)
    #    - Indicates how many words it expects to ge
    
    def last_words(amount = nil)
      words = self.words.reverse
      (amount ? words[0...amount] : words).reverse
    end

    # Appends ellipsis to the text.
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
      return self if length <= 1 or length < max_length
      
      # Adjusts the max_length
      max_length = (length / 2).round if max_length == 0
      
      # If ellipsis must be applied after a word
      str = self[0...max_length]
      str = str.words[0..words.length - 2].join(' ') if options[:after_a_word] == true
      
      # Defines how the ellipsis will be displayed
      ellip = options[:html_encoded] == true ? '&hellip;' : '...'
       
      str.strip + ellip
    end

    # Finds URLs in text and wrap in anchor tag.
    # 
    # Example:
    #   >> 'Awesome site: http://foobar.com'.linkify
    #   => 'Awesome site: <a href="http://foobar.com">http://foobar.com</a>'
    #   >> 'Awesome site: http://foobar.com'.linkify(class: 'link', truncate: 10)
    #   => 'Awesome site: <a href="http://foobar.com" class="link">http://foo...</a>'
    # Arguments:
    #   options: (Hash)
    #    - Options for the link tag, such as: 
    #      - :truncate - If set, it will truncate the URL displayed in the anchor tag 
    #                    and put an ellipsis according to the given length. It can
    #                    be also a Hash of options:
    #        - :length - URLs new length.
    #        - :html_encoded - Ellipsis will be displayed as HTML encoded char.
    #      - :class - Value for "class" attribute: <a href="url" class="link">url</a>
    #      - :target - Value for "target" attribute: <a href="url" target="_blank">url</a>
    
    def linkify(options = {})
      self.gsub!(/\b(((ht|f)tp[s]?:\/\/)?([a-z0-9]+\.)?(?<!@)([a-z0-9\_\-]+)(\.[a-z]+)+([\?\/\:][a-z0-9_=%&@\?\.\/\-\:\#\(\)]+)?\/?)/i) do |match|
        # Truncates the URL
        if options[:truncate]
          t         = options[:truncate]
          displayed = t.instance_of?(Hash) ? match.ellipsis(t[:length], html_encoded: t[:html_encoded]) : match.ellipsis(t)
        else
          displayed = match
        end

        # Applies 'class' and 'target' options
        options = !options ? '' : options.reduce(' ') do |s, v| 
          s << (v[0] == :truncate ? '' : "#{v[0]}=\"#{v[1]}\" ")
        end.gsub(/\s+$/, '')

        # Forces the presence of the 'http://'
        match = "http://#{match}" unless match =~ /(ht|f)tp[s]?/i
        
        "<a href=\"#{match}\"#{options}>#{displayed}</a>"
      end
      self 
    end

    # Finds URLs, Twitter handles, hashtags in the text and wrap in anchor tag.
    # 
    # Example:
    #   >> 'What about to follow @tiagopog?'.tweetfy
    #   => 'What about to follow <a href="https://twitter.com/tiagopog" target="_blank" class="tt-handle">@tiagopog</a>?' 
    #   >> "Let's code! #rubyrocks".tweetfy
    #   => "Let's code! <a href=\"https://twitter.com/search?q=%23rubyrocks\" target=\"_blank\" class=\"hashtag\">#rubyrocks</a>"
    # Arguments:
    #   options: (Hash)
    #    - Options such as: 
    #      - :only - Array of Symbols restricting what will be matched on the text.
    
    def tweetify(options = {})      
      # Applies linkify unless there's some restriction
      only = options[:only]
      str  = only ? self : self.linkify(class: 'link')

      # Iterates with the matched expressions
      str.gsub!(/(((^[@#])|([^a-z0-9\W]|\s)([@|#]))([a-z0-9\_]+))/i) do |match|
        is_hashtag = match =~ /#/
        
        if only and ([:hashtag, :tt_handle] != only.sort) and ((is_hashtag and !only.include?(:hashtag)) or (!is_hashtag and !only.include?(:tt_handle)))
          match
        else
          match      = match.strip
          tt_url     = 'https://twitter.com/'       
          tag        = {
            href:    is_hashtag ? "#{tt_url}search?q=%23#{match.gsub(/#/, '')}" : "#{tt_url}#{match.gsub(/@/, '')}",
            class:   is_hashtag ? 'hashtag' : 'tt-handle'
          }
          
          " <a href=\"#{tag[:href]}\" target=\"_blank\" class=\"#{tag[:class]}\">#{match}</a>"
        end
      end      
      str
    end
  end 
end
