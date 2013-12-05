require 'spec_helper'

describe 'String#nl2br' do
  it 'should replace "\n" to "<br />"' do
  	"break\nrow".nl2br.should eq 'break<br />row'
  end

	it 'should not replace "\n" to "<br />" when "\n" is literal' do
  	"\\no break row".nl2br.should_not eq '<br />o break row'
  end  
end

describe 'String#to_title' do
  it 'should format the text properly to looks like a title' do
  	"here's aN AWEsome TiTle!".to_title.should eq "Here's An Awesome Title!"
  end
end

describe 'String#strip_tags' do
  it 'removes any HTML tag from a given text' do
  	'<h1><a href="http://somecoolurl.com">Aloha!</a></h1>'.should eq 'Aloha!'
  end
end