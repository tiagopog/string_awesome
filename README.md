# StringAwesome

This gem adds some awesome and easy-to-use extensions to Ruby String class.

## Installation

Compatible with Ruby 1.9.3+

Add this line to your application's Gemfile:

    gem 'string_awesome'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install string_awesome

## Usage

### HTML

#### String#linkify

Finds URLs in the text and wrap in anchor tag.

``` ruby
'Awesome site: http://foobar.com'.linkify
#=> 'Awesome site: <a href="http://foobar.com">http://foobar.com</a>' 

'www.foobar.com'.linkify
#=> '<a href="http://www.foobar.com">www.foobar.com</a>'

'foobar.com'.linkify
#=> '<a href="http://foobar.com">foobar.com</a>'

'Awesome site: http://foobar.com'.linkify(class: 'link', truncate: 10)
#=> 'Awesome site: <a href="http://foobar.com" class="link">http://foo...</a>'

'Awesome site: http://foobar.com'.linkify(class: 'link', target: '_blank')
#=> 'Awesome site: <a href="http://foobar.com" class="link" target="_blank">http://foobar.com</a>'

'Awesome site: http://foobar.com'.linkify(truncate: { length: 10, html_encoded: true })
#=> 'Awesome site: <a href="http://foobar.com">http://foo&hellip;</a>'
```

#### String#tweetify

Finds URLs, Twitter handles, hashtags in the text and wrap in anchor tag.

``` ruby
'What about to follow @tiagopog?'.tweetify
#=> 'What about to follow <a href="https://twitter.com/tiagopog" target="_blank" class="tt-handle">@tiagopog</a>?'

"Let's code! #rubyrocks".tweetify
#=> "Let's code! <a href=\"https://twitter.com/search?q=%23rubyrocks\" target=\"_blank\" class=\"hashtag\">#rubyrocks</a>"

'Cool link from @tiagopog! http://foobar.com #rubyrocks'.tweetify(only: [:hashtag])
#=> 'Cool link from @tiagopog! http://foobar.com <a href="https://twitter.com/search?q=%23rubyrocks" target="_blank" class="hashtag">#rubyrocks</a>'

'Cool link from @tiagopog! http://foobar.com #rubyrocks'.tweetify(only: [:hashtag, :tt_handle])
#=> 'Cool link from <a href="https://twitter.com/tiagopog" target="_blank" class="tt-handle">@tiagopog</a>! http://foobar.com <a href="https://twitter.com/search?q=%23rubyrocks" target="_blank" class="hashtag">#rubyrocks</a>'
```

#### String#nl2br

Replaces \n to \<br /\> tags.

``` ruby
"Hello 
   world!".nl2br
#=> "Hello <br/ > world!"
```

#### String#strip_tags

Removes all HTML tags from text.

``` ruby
'<h1><a href="http://somecoolurl.com">Aloha!</a></h1>'.strip_tags
#=> 'Aloha!'
```

### Other Cool Features

#### String#ellipsis

Appends ellipsis to the text.

``` ruby
'lorem ipsum!'.ellipsis
#=> 'lorem...'

"It's a very loooooong text!".ellipsis 11
#=> "It's a very..."

"It's a very loooooong text!".ellipsis 8, after_a_word: true
#=> "It's a..."

'lorem ipsum'.ellipsis(5, html_encoded: true)
#=> 'lorem&hellip;'
```

#### String#no_accents

Removes accents from words in the text.

``` ruby
'lórem ipsùm dólor sìt ãmet!'.no_accents
#=> 'lorem ipsum dolor sit amet!'
```

#### String#slug

Parses the text to a valid format for URLs.

``` ruby
'Lórem IPSUM Dolor?'.slug
#=> 'lorem-ipsum-dolor'
```

#### String#to_title

Converts the string into a title style and prevents other letters in the middle of the word from being uppercase.

``` ruby
'loREm IPsuM DOLOR'.to_title
#=> 'Lorem Ipsum Dolor'
```

#### String#reverse_words

Reverses a string by words, instead of reversing it by characters like the String#reverse.

``` ruby
'lorem ipsum dolor'.reverse_words
#=> 'dolor ipsum lorem'
```

#### String#count_words

Counts how many words there are in the text.

``` ruby
'lorem ipsum dolor'.count_words
#=> 3

'lorem ipsum dolor'.count_words 7 # it will count words until this length: 7
#=> 1
```

#### String#first_words

Returns an Array with the N first words from the text.

``` ruby
'lorem ipsum dolor'.first_words 2
#=> 'lorem ipsum'
```

#### String#last_words

Returns am Array with the N last words from the text.

``` ruby
'lorem ipsum dolor'.last_words 2
#=> 'ipsum dolor'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
