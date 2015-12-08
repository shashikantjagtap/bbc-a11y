var cheerio = require('cheerio');

function HtmlPage(html) {
  this.dom = cheerio.load(html);
}

HtmlPage.prototype.all = function(selector) {
  return this.dom(selector);
}

module.exports = HtmlPage;
