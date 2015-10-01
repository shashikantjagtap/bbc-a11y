Given(/^a standards-compliant website running at http:\/\/localhost:(\d+)$/) do |port|
  WebServer.ensure_running_on(port)
end

Given(/^all the tests pass$/) do
  WebServer.ensure_running_on(54321)
  step "I run `a11y http://localhost:54321/perfect.html`"
end

Given(/^one test fails$/) do
  WebServer.ensure_running_on(54321)
  step "I run `a11y http://localhost:54321/missing_header.html`"
end

require 'aruba/cucumber'
Given(/^a page with this HTML:$/) do |body|
  write_file 'test.html', <<-BODY
<!DOCTYPE html>
<html>
  <body>
    #{body}
  </body>
</html>
BODY
end

When(/^I run the tool$/) do
  step "I run `a11y test.html`"
end

Then(/^I see the warnings:$/) do |warnings|
  warnings.raw.flatten.each do |warning|
    assert_partial_output all_output, warning
  end
end
