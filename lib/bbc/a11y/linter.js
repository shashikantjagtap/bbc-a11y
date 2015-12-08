var Standards = require('./standards');

function LintResult(errors) {
  this.errors = errors;
}

LintResult.prototype.passed = function() {
  return this.errors.length == 0;
}

LintResult.prototype.failed = function() {
  return this.passed() == false;
}

LintResult.prototype.toString = function() {
  return this.errors.map(function(error) {
    return error.toString();
  }).join("\n");
}

function Linter(page, standards) {
  this.page = page;
  this.standards = standards || Standards.all;
}

Linter.prototype.run = function(callback) {
  var errors = [];
  for (var i = 0; i < this.standards.length; ++i) {
    var Standard = this.standards[i];
    new Standard(this.page).call(function(standardErrors) {
      errors = errors.concat(standardErrors);
    });
  }
  callback(new LintResult(errors));
}

module.exports = Linter;
