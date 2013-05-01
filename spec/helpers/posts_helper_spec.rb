require 'spec_helper'

describe PostsHelper do
  helper PostsHelper
  helper ApplicationHelper

  describe "#fix_images" do
    it "should replace imgur urls" do
      text = 'Lorem ip<img src="http://i.imgur.com/o5BToBq.jpg">Lorem ip'
      fix_images(text, '').should match /src="\/i\/o5BToBq\.jpg"/
    end

    it "should not replace local urls" do
      text = 'Lorem ip<img src="/images/normal.jpg">Lorem ip'
      fix_images(text, '').should match /src="\/images\/normal\.jpg"/
    end

    it "adds alt and title" do
      title = 'tasty test title'
      text = 'Lorem ip<img src="/images/normal.jpg">Lorem ip'
      fixed_text = "Lorem ip<img alt='#{title}' title='#{title}' src=\"/images/normal.jpg\">Lorem ip"
      fix_images(text, title).should eq(fixed_text)
    end

    it "should not add alt when its already there" do
      title = 'tasty test title'
      text = 'Lorem ip<img src="/images/normal.jpg" alt="lets try">Lorem ip'
      fixed_text = "Lorem ip<img title='#{title}' src=\"/images/normal.jpg\" alt=\"lets try\">Lorem ip"
      fix_images(text, title).should eq(fixed_text)
    end

    it "should not add title when its already there" do
      title = 'tasty test title'
      text = 'Lorem ip<img src="/images/normal.jpg" title="lets try">Lorem ip'
      fixed_text = "Lorem ip<img alt='#{title}' src=\"/images/normal.jpg\" title=\"lets try\">Lorem ip"
      fix_images(text, title).should eq(fixed_text)
    end

    it "replaces quotes in alts" do
      title = 'tasty "test\' title'
      fixed_title = 'tasty "test" title'
      text = 'Lorem ip<img src="/images/normal.jpg">Lorem ip'
      fixed_text = "Lorem ip<img alt='#{fixed_title}' title='#{fixed_title}' src=\"/images/normal.jpg\">Lorem ip"
      fix_images(text, title).should eq(fixed_text)
    end
  end

  describe "#fix_links" do
    context "local links" do

    end

    context "external link" do
      before :each do
        @text = 'test <a href="http://test.com/t/t?z=1"> test'
      end

      it "adds nofollow" do
        fix_links(@text).should match /rel=('|")nofollow('|")/
      end

      it "opens link in a new window" do
        fix_links(@text).should match /target=('|")_blank('|")/
      end

      it "adds redirect" do
        fix_links(@text).should match /href=('|")\/r\//
      end
    end

  end

end