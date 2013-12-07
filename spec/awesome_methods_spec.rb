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

  it 'should remove by default the whitespaces that were allocated in place of HTML tags' do
    '<h1>no whitespaces</h1>'.strip_tags.should eq 'no whitespaces'
  end

  it 'should not remove the whitespaces that were allocated in place of HTML tags, when required' do
    '<h1>whitespaces</h1>'.strip_tags(true).should eq ' whitespaces '
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

  it "should append the HTML encoded ellipsis in the text" do
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
  it "should replace all the URL's in the text with HTML link tags" do
    'Awesome site: http://foobar.com'.linkify.should eq 'Awesome site: <a href="http://foobar.com">http://foobar.com</a>'
  end

  it 'can set the "class" HTML attribute to be applied on the link tag' do
    'Awesome site: http://foobar.com'.linkify(class: 'link').should eq 'Awesome site: <a href="http://foobar.com" class="link">http://foobar.com</a>'
  end

  it 'can set the "target" HTML attribute to be applied on the link tag' do
    'Awesome site: http://foobar.com'.linkify(target: '_blank').should eq 'Awesome site: <a href="http://foobar.com" target="_blank">http://foobar.com</a>'
  end

  it 'can set the class and target HTML attributes to be applied on the link tag' do
    'Awesome site: http://foobar.com'.linkify(class: 'link', target: '_blank').should eq 'Awesome site: <a href="http://foobar.com" class="link" target="_blank">http://foobar.com</a>'
  end

  it 'can truncate the URL displayed whithin the link tag (Interger param)' do
    'Awesome site: http://foobar.com'.linkify(truncate: 10).should eq 'Awesome site: <a href="http://foobar.com">http://foo...</a>'
  end

  it 'can truncate the URL displayed whithin the link tag (Hash param)' do
    'Awesome site: http://foobar.com'.linkify(truncate: { length: 10, html_encoded: true }).should eq 'Awesome site: <a href="http://foobar.com">http://foo&hellip;</a>'
  end

  it 'can set HTML attributes and truncate the URL' do
    'Awesome site: http://foobar.com'.linkify(class: 'link', truncate: 10).should eq 'Awesome site: <a href="http://foobar.com" class="link">http://foo...</a>'
  end

  it "matches URL's without the presence of 'http://' but presenting 'www'" do
    'www.foobar.com'.linkify.should eq '<a href="http://www.foobar.com">www.foobar.com</a>'
  end

  it "matches URL's without the presence of 'http://' and 'www'" do
    'foobar.com'.linkify.should eq '<a href="http://foobar.com">foobar.com</a>'
  end
end