function ExactlyOneMainHeading(page) {
  this.page = page;
}

ExactlyOneMainHeading.prototype.call = function(errors) {
  var count = this.page.all('h1').length;
  if (count != 1) {
    errors(["A document must have exactly one heading." +
            " Found " + count + " h1 elements."]);
  }
}

module.exports = ExactlyOneMainHeading;
