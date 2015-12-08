var xpath = require('./xpath');

function AnchorHrefs(page) {
  this.page = page;
}

AnchorHrefs.prototype.call = function(errors) {
  this.page.all("a:not([href])").each(function(index, anchor) {
    errors([
      "Anchor has no href attribute: " + xpath.forElement(anchor)
    ]);
  });
}

module.exports = AnchorHrefs;
