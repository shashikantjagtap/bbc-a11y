function HeadingHierarchy(page) {
  this.page = page;
}

HeadingHierarchy.prototype.call = function(errors) {
  eachCons(this.headingLevels(), 2).forEach(function(pair) {
    if (pair[1] > (pair[0] + 1)) {
      errors(["Headings are not in order: " +
                "h" + pair[0] + " is followed by h" + pair[1] ]);
    }
  })
}

HeadingHierarchy.prototype.headings = function() {
  return this.page.all('h1, h2, h3, h4, h5, h6');
}

HeadingHierarchy.prototype.headingLevels = function() {
  return this.headings().get().map(function(heading) {
    return parseInt(heading.tagName[1]);
  });
}

function eachCons(a, n) {
  var r = []
  for (var i = 0; i < a.length - n + 1; i++) {
    r.push(range(a, i, n))
  }
  return r
}

function range(a, i, n) {
  var r = []
  for (var j = 0; j < n; j++) {
    r.push(a[i + j])
  }
  return r
}

module.exports = HeadingHierarchy
