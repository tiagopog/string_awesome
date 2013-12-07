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
    'lorem ipsum dolor'.ellipsis(14, after_word: true).should eq 'lorem ipsum...'
  end

  it 'should append the HTML encoded ellipsis after a word' do
    'lorem ipsum dolor'.ellipsis(13, html_encoded: true, after_word: true).should eq 'lorem ipsum&hellip;'
  end
end