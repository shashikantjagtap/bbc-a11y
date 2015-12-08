var xpath = require('./xpath');

function ExactlyOneMainLandmark(page) {
  this.page = page;
}

ExactlyOneMainLandmark.prototype.call = function(errors) {
  var count = this.page.all('*[role=main]').length;
  if (count != 1) {
    errors([
      "A document must have exactly one main landmark." +
      " Found " + count + " elements with role=\"main\"."
    ]);
  }
}

module.exports = ExactlyOneMainLandmark;
