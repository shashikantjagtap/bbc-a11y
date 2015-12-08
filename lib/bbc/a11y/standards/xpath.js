function xpathForCheerioElement(node) {
  var xpath = '/' + node.name;
  if (node.parent) {
    xpath = xpathForCheerioElement(node.parent) + xpath;
    var sameTags = node.parent.children.filter(function(child) {
      return child.name == node.name;
    });
    if (sameTags.length > 1) {
      xpath += '[' + (sameTags.indexOf(node) + 1) + ']';
    }
  }
  return xpath;
}

module.exports = {
  forElement: function(element) {
    return xpathForCheerioElement(element);
  }
}
