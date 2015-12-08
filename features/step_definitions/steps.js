var Linter = require('../../lib/bbc/a11y/linter');
var Standards = require('../../lib/bbc/a11y/standards');
var HtmlPage = require('../../lib/bbc/a11y/html_page');

var expect = require('chai').expect;

module.exports = function() {

  this.Given(/^a page with the HTML:$/, function (bodyHtml, callback) {
    this.page = new HtmlPage('<html><body>' + bodyHtml + '</body></html>');
    callback();
  });

  this.When(/^I validate the (.+) standards$/, function (pattern, callback) {
    var regexp = new RegExp(pattern.replace(/ /g, ''), 'i');
    var standards = Standards.matching(regexp);
    if (standards.length == 0) {
      throw new Error("No standards match '" + pattern + "'");
    }
    var self = this;
    var linter = new Linter(this.page, standards);
    linter.run(function(lintResult) {
      self.lintResult = lintResult;
      callback();
    });
  });

  this.Then(/^it passes$/, function (callback) {
    expect(this.lintResult.passed()).to.be.true;
    callback();
  });

  this.Then(/^it fails with the message:$/, function (message, callback) {
    expect(this.lintResult.failed()).to.be.true;
    expect(this.lintResult.toString()).to.include(message);
    callback();
  });

}
