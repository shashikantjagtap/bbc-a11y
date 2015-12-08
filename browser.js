var Linter = require('./lib/bbc/a11y/linter');
var HtmlPage = require('./lib/bbc/a11y/html_page');

window.a11y = function() {
  var page = new HtmlPage(document.documentElement.outerHTML);
  var linter = new Linter(page);
  linter.run(function(lintResult) {
    console.log("a11y lint result:");
    lintResult.errors.map(function(e) {
      var elements = xpathElementsIn(e);
      if (elements.length == 0) {
        console.error(e);
      } else {
        console.error(e, elements[0]);
      }
    });
  });
}

function xpathElementsIn(str) {
  if (!$x) return [];
  var parts = str.split(' ');
  var elements = [];
  for (var i = 0; i < parts.length; i++) {
    var part = parts[i];
    if (part.match(/(\/+[a-z\[\]\d]+)+/g)) {
      elements.push($x(part)[0]);
    }
  }
  return elements;
}
