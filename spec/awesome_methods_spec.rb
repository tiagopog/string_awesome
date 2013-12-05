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

  it 'should remove by default the whitespaces that are allocated in place of HTML tags' do
  	'<h1>no whitespaces</h1>'.strip_tags.should eq 'no whitespaces'
  end

  it 'should let the whitespaces that are allocated in place of HTML tags when required' do
  	'<h1>whitespaces</h1>'.strip_tags(true).should eq ' whitespaces '
  end
end

# 
# String#slug
# 
describe 'String#slug' do
  it 'should parse the text to a proper format for URL\'s' do
  	# EscapeUtils.escape_url avoids the "...warning: regexp match /.../n against to UTF-8 string" message
  	str = EscapeUtils.escape_url('Lórem IPSUM Dolor?')
  	str.slug.should eq 'lorem-ipsum-dolor'
  end

  it 'should return an empty string when it has only non (word|number)s charaters' do
  	'!@#$%ˆ&*(){}[]|\\:;"<>?,./`-=+_'.slug.should eq ''
  end
end