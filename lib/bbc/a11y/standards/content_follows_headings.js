function ContentFollowsHeadings(page) {
  this.page = page;
}

ContentFollowsHeadings.prototype.call = function(errors) {
  var page = this.page;
  ["h1", "h2", "h3", "h4", "h5", "h6"].forEach(function(h) {
    if (page.all(h + ' + ' + h).length > 0) {
      errors([
        "Heading elements must be followed by content. " +
                  "No content follows a " + h + "."
      ]);
    }
  });
}

module.exports = ContentFollowsHeadings;
