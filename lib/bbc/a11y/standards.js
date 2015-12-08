var standards = {
  all: [
    require('./standards/anchor_hrefs'),
    require('./standards/content_follows_headings'),
    require('./standards/exactly_one_main_heading'),
    require('./standards/form_submit_buttons'),
    require('./standards/heading_hierarchy')
  ],

  matching: function(regexp) {
    return standards.all.filter(function(standard) {
      return regexp.test(standard.name);
    });
  }
}

module.exports = standards;
