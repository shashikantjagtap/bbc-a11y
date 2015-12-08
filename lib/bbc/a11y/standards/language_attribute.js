var xpath = require('./xpath');

function LanguageAttribute(page) {
  this.page = page;
}

LanguageAttribute.prototype.call = function(errors) {
  this.page.all("html:not([lang])").each(function(index, img) {
    errors([
      "The main language must be specified. " +
      "<html> tag has no lang attribute."
    ]);
  });
}

module.exports = LanguageAttribute;
