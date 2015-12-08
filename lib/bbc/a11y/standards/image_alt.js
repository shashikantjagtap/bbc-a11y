var xpath = require('./xpath');

function ImageAlt(page) {
  this.page = page;
}

ImageAlt.prototype.call = function(errors) {
  this.page.all("img:not([alt])").each(function(index, img) {
    errors([
      "Image has no alt attribute: " + xpath.forElement(img)
    ]);
  });
}

module.exports = ImageAlt;
