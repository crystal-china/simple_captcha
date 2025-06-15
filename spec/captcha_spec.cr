require "./spec_helper"

describe CaptchaGenerator do
  it "passing string works" do
    captcha = CaptchaGenerator.new("1234")
    captcha.code.should eq "1234"
    captcha.base64.should be_a String
    captcha.img_tag.should start_with("<img")
    captcha.img_tag.should contain("data:image/png;base64")
  end

  it "passing number work" do
    captcha = CaptchaGenerator.new(length: 6)
    captcha.code.size.should eq 6
    captcha.base64.should be_a String
    captcha.img_tag.should start_with("<img")
    captcha.img_tag.should contain("data:image/png;base64")
    (captcha.img_tag.size > 3000).should be_true
  end

  it "default arg work" do
    captcha = CaptchaGenerator.new
    captcha.code.size.should eq 4
    captcha.base64.should be_a String
    captcha.img_tag.should start_with("<img")
  end

  it "save a image" do
    captcha = CaptchaGenerator.new
    captcha.write_html_file("spec/sample.html")
    File.exists?("spec/sample.html").should be_true
  end
end
