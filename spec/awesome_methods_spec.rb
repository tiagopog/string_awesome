# coding: utf-8

require 'spec_helper'

# 
# String#nl2br
# 
describe 'String#nl2br' do
  it 'should replace "\n" to "<br />"' do
    "break\nrow".nl2br.should eq 'break<br />row'
  end

  it 'should not replace "\n" to "<br />" when "\n" is literal' do
    "\\no break row".nl2br.should_not eq '<br />o break row'
  end  
end

# 
# String#to_title
# 
describe 'String#to_title' do
  it 'should format the text properly to looks like a title' do
    "here's aN AWEsome TiTle!".to_title.should eq "Here's An Awesome Title!"
  end
end

# 
# String#strip_tags
# 
describe 'String#strip_tags' do
  it 'should remove any HTML tag from a given text' do
    '<h1><a href="http://somecoolurl.com">Aloha!</a></h1>'.strip_tags.should eq 'Aloha!'
  end

  it 'should remove the whitespaces that were allocated in place of HTML tags' do
    '<h1>lorem ipsum </h1> dolor'.strip_tags.should eq 'lorem ipsum dolor'
  end
end

# 
# String#no_accents
# 
describe 'String#no_accents' do
  it 'should remove accents from words in the text' do
    'lórem ipsùm dólor sìt ãmet!'.no_accents.should eq 'lorem ipsum dolor sit amet!'
  end
end

# 
# String#slug
# 
describe 'String#slug' do
  it 'should parse the text to an URL valid format, downcase by default' do
    'Lorem IPSUM Dolor?'.slug.should eq 'lorem-ipsum-dolor'
  end

  it 'should parse the text to an URL valid format without forcing it to downcase' do
    'Lorem Ipsum Dolor 2013!'.slug(false).should eq 'Lorem-Ipsum-Dolor-2013'
  end
end

# 
# String#truncate
# 
describe 'String#truncate' do
  it 'shoud truncate the text' do
    "It's a very loooooong text!".truncate(11).should eq "It's a very"
  end

  it 'shoud truncate the text after a word' do
    "It's a very loooooong text!".truncate(8, true).should eq "It's a"
  end
end

# 
# String#ellipsis
# 
describe 'String#ellipsis' do
  it "shoud not append ellipsis when String's length is less then 2" do
    'l'.ellipsis.should eq 'l'
  end

  it "shoud not have the max_length value greater than text's length" do
    'foo'.ellipsis(10).should eq 'foo'
  end

  it "should append ellipsis in the text's half length (default behaviour)" do
    'lorem ipsum!'.ellipsis.should eq 'lorem...'
  end

  it "should append ellipsis in the text's rounded half length when the number of characters is odd (default behaviour)" do
    'lorem ipsum'.ellipsis.should eq 'lorem...'
  end

  it 'should append the HTML encoded ellipsis in the text' do
    'lorem ipsum'.ellipsis(5, html_encoded: true).should eq 'lorem&hellip;'
  end

  it "should not append the HTML encoded ellipsis in the text when it's not required" do
    'lorem ipsum'.ellipsis(5, html_encoded: false).should_not eq 'lorem&hellip;'
  end

  it 'should append ellipsis after a word' do
    'lorem ipsum dolor'.ellipsis(14, after_a_word: true).should eq 'lorem ipsum...'
  end

  it 'should append the HTML encoded ellipsis after a word' do
    'lorem ipsum dolor'.ellipsis(13, html_encoded: true, after_a_word: true).should eq 'lorem ipsum&hellip;'
  end
end

# 
# String#words
# 
describe 'String#words' do
  it 'should return an array with all the words from the string' do
    'Lorem! Ipsum dolor, sit amet 2013.'.words.should eq ['Lorem', 'Ipsum', 'dolor', 'sit', 'amet', '2013']
  end
end

# 
# String#reverse_words
# 
describe 'String#reverse_words' do
  it 'should reverse a string by words' do
    'lorem ipsum dolor'.reverse_words.should eq 'dolor ipsum lorem'
  end
end

# 
# String#count_words
# 
describe 'String#count_words' do
  it 'should count how many words there are in the string' do
    'lorem ipsum dolor'.count_words.should eq 3
  end

  it 'should count how many words there are in the string limited by the max_length value (whitespace test)' do
    'lorem ipsum dolor'.count_words(6).should eq 1
  end

  it 'should count how many words there are in the string limited by the max_length value (splitted word, test 1)' do
    'lorem ipsum dolor'.count_words(7).should eq 1
  end

  it 'should count how many words there are in the string limited by the max_length value (splitted word, test 2)' do
    'lorem ipsum dolor'.count_words(8).should eq 1
  end

  it 'should not condiser a non-word character (!) as a word' do
    'lorem ipsum ! dolor'.count_words.should eq 3
  end

 it 'should not condiser a non-word character (!) as a word' do
    'lorem ipsum ! dolor'.count_words(13).should eq 2
  end
end

# 
# String#first_words
# 
describe 'String#first_words' do
  it 'should return all the words when the amount is not passed' do
    'lorem ipsum dolor'.first_words.should eq ['lorem', 'ipsum', 'dolor']
  end

  it 'should return only the 2 first words (Array)' do
    'lorem. ! ipsum dolor'.first_words(2).should eq ['lorem', 'ipsum']
  end
end

# 
# String#last_words
# 
describe 'String#last_words' do
  it 'should return all the words when the amount is not passed' do
    'lorem ipsum dolor'.last_words.should eq ['lorem', 'ipsum', 'dolor']
  end

  it 'should return only the 2 last words (Array)' do
    'lorem. ! ipsum dolor'.first_words(2).should eq ['lorem', 'ipsum']
  end
end

# 
# String#linkify
# 
describe 'String#linkify' do
  it 'should find all the HTTP URLs in text and wrap in anchor tags' do
    str  = 'Awesome site: http://foobar.com'
    this = 'Awesome site: <a href="http://foobar.com">http://foobar.com</a>'
    str.linkify.should eq this
  end

  it 'should find all the HTTPS URLs in text and wrap in anchor tags' do
    str  = 'Awesome site: https://foobar.com'
    this = 'Awesome site: <a href="https://foobar.com">https://foobar.com</a>'
    str.linkify.should eq this
  end

  it 'should find all the FTP URLs in text and wrap in anchor tags' do
    str  = 'Awesome site: ftp://foobar.com'
    this = 'Awesome site: <a href="ftp://foobar.com">ftp://foobar.com</a>'
    str.linkify.should eq this
  end

  it 'should match http://sub.sub.domain' do
    url  = 'http://www3.blog.foo.bar'
    str  = "Awesome site: #{url}"
    this = "Awesome site: <a href=\"#{url}\">#{url}</a>"
    str.linkify.should eq this
  end

  it 'should match query strings' do
    url  = 'http://www.foobar.com/blog?category_id=54322&itle=lorem-ipsum-dolor'
    str  = "Awesome site: #{url}"
    this = "Awesome site: <a href=\"#{url}\">#{url}</a>"
    str.linkify.should eq this
  end

  it 'should match friendly URLs' do
    url  = 'http://www.foobar.com/blog/tech/lorem-ipsum-dolor'
    str  = "Awesome site: #{url}"
    this = "Awesome site: <a href=\"#{url}\">#{url}</a>"
    str.linkify.should eq this
  end

  it 'can set the "class" HTML attribute to be applied on the anchor tag' do
    str  = 'Awesome site: http://foobar.com'
    this = 'Awesome site: <a href="http://foobar.com" class="link">http://foobar.com</a>'
    str.linkify(class: 'link').should eq this
  end

  it 'can set the "target" HTML attribute to be applied on the anchor tag' do
    str  = 'Awesome site: http://foobar.com'
    this = 'Awesome site: <a href="http://foobar.com" target="_blank">http://foobar.com</a>'
    str.linkify(target: '_blank').should eq this
  end

  it 'can set the class and target HTML attributes to be applied on the anchor tag' do
    str  = 'Awesome site: http://foobar.com'
    this = 'Awesome site: <a href="http://foobar.com" class="link" target="_blank">http://foobar.com</a>'
    str.linkify(class: 'link', target: '_blank').should eq this
  end

  it 'can truncate the URL displayed whithin the anchor tag (Interger param)' do
    str  = 'Awesome site: http://foobar.com'
    this =  'Awesome site: <a href="http://foobar.com">http://foo...</a>'
    str.linkify(truncate: 10).should eq this
  end

  it 'can truncate the URL displayed whithin the anchor tag (Hash param)' do
    str  = 'Awesome site: http://foobar.com'
    this = 'Awesome site: <a href="http://foobar.com">http://foo&hellip;</a>'
    str.linkify(truncate: { length: 10, html_encoded: true }).should eq this
  end

  it 'can set HTML attributes and truncate the URL' do
    str  = 'Awesome site: http://foobar.com'
    this = 'Awesome site: <a href="http://foobar.com" class="link">http://foo...</a>'
    str.linkify(class: 'link', truncate: 10).should eq this
  end

  it "matches URLs without the presence of 'http://' but presenting 'www'" do
    'www.foobar.com'.linkify.should eq '<a href="http://www.foobar.com">www.foobar.com</a>'
  end

  it "should not match URLs without the presence of 'http://' and 'www'" do
    'foobar.com'.linkify.should eq 'foobar.com'
  end
end

# 
# String#tweetify
# 
describe 'String#tweetify' do
  it 'should find Twitter handles (@username) and wrap them in anchor tags' do
    str  = 'What about to follow @tiagopog?'
    this = 'What about to follow <a href="https://twitter.com/tiagopog">@tiagopog</a>?' 
    str.tweetify.should eq this
  end

  it 'should find Twitter handles (@username) and wrap them in anchor tags (attributes included)' do
    str  = 'What about to follow @tiagopog?'
    this = 'What about to follow <a href="https://twitter.com/tiagopog" target="_blank" class="tt-handle">@tiagopog</a>?' 
    str.tweetify(tt_handle: { target: '_blank', class: 'tt-handle' }).should eq this
  end

  it 'should not match foo@bar as being a Twitter handle' do
    'foo@bar'.tweetify.should eq 'foo@bar'
  end

  it 'should find hashtags (#hashtag) and wrap them in anchor tags' do
    str  = "Let's code! #rubyrocks"
    this = "Let's code! <a href=\"https://twitter.com/search?q=%23rubyrocks\">#rubyrocks</a>"
    str.tweetify.should eq this
  end

  it 'should find hashtags (#hashtag) and wrap them in anchor tags (attributes included)' do
    str  = "Let's code! #rubyrocks"
    this = "Let's code! <a href=\"https://twitter.com/search?q=%23rubyrocks\" target=\"_blank\" class=\"hashtag\">#rubyrocks</a>"
    str.tweetify(hashtag: { target: '_blank', class: 'hashtag' }).should eq this
  end

  it 'should not match foo#bar as being a hashtag' do
    'foo#bar'.tweetify.should eq 'foo#bar'
  end

  it 'should find URLs and wrap them in anchor tags' do
    str  = 'Tweet some cool link: http://foobar.com'
    this = 'Tweet some cool link: <a href="http://foobar.com">http://foobar.com</a>'
    str.tweetify.should eq this
  end

  it 'should find URLs and wrap them in anchor tags (attributes included)' do
    str  = 'Tweet some cool link: http://foobar.com'
    this = 'Tweet some cool link: <a href="http://foobar.com" class="link">http://foobar.com</a>'
    str.tweetify(url: { class: 'link' }).should eq this
  end

  it 'should find links, Twitter handles, hashtags and wrap them in anchor tags' do
    str  = 'Cool link from @tiagopog! http://foobar.com #rubyrocks'
    this = 'Cool link from <a href="https://twitter.com/tiagopog">@tiagopog</a>! <a href="http://foobar.com">http://foobar.com</a> <a href="https://twitter.com/search?q=%23rubyrocks">#rubyrocks</a>'
    str.tweetify.should eq this
  end

  it 'should find only Twitter handles' do
    str  = 'Cool link from @tiagopog! http://foobar.com #rubyrocks'
    this = 'Cool link from <a href="https://twitter.com/tiagopog">@tiagopog</a>! http://foobar.com #rubyrocks'
    str.tweetify(only: [:tt_handle]).should eq this
  end

  it 'should find only hashtags' do
    str  = 'Cool link from @tiagopog! http://foobar.com #rubyrocks'
    this = 'Cool link from @tiagopog! http://foobar.com <a href="https://twitter.com/search?q=%23rubyrocks">#rubyrocks</a>'
    str.tweetify(only: [:hashtag]).should eq this
  end

  it 'should not find URLs, just hashtags and Twitter handles' do
    str  = 'Cool link from @tiagopog! http://foobar.com #rubyrocks'
    this = 'Cool link from <a href="https://twitter.com/tiagopog">@tiagopog</a>! http://foobar.com <a href="https://twitter.com/search?q=%23rubyrocks">#rubyrocks</a>'
    str.tweetify(only: [:hashtag, :tt_handle]).should eq this
  end

  it 'should not find URLs, just hashtags and Twitter handles' do
    str  = 'Cool link from @tiagopog! http://foobar.com #rubyrocks'
    this = 'Cool link from <a href="https://twitter.com/tiagopog" target="_blank" class="tt-handle">@tiagopog</a>! http://foobar.com <a href="https://twitter.com/search?q=%23rubyrocks" target="_blank" class="hashtag">#rubyrocks</a>'
    str.tweetify(only: [:hashtag, :tt_handle], tt_handle: { target: '_blank', class: 'tt-handle' }, hashtag: { target: '_blank', class: 'hashtag' }).should eq this
  end
end