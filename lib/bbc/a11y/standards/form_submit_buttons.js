var xpath = require('./xpath');

function FormSubmitButtons(page) {
  this.page = page;
}

FormSubmitButtons.prototype.call = function(errors) {
  var page = this.page;

  page.all("form").each(function(index, form) {
    var submits = page.dom(form).find("input[type=submit]");
    if (submits.length == 0) {
      errors(["Form has no submit button: " + xpath.forElement(form)])
    }
  });
}

module.exports = FormSubmitButtons;
