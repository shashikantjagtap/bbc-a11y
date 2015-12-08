var standards = {
  all: [
    require('./standards/anchor_hrefs'),
    require('./standards/content_follows_headings'),
    require('./standards/exactly_one_main_heading'),
    require('./standards/exactly_one_main_landmark'),
    require('./standards/form_submit_buttons'),
    require('./standards/heading_hierarchy'),
    require('./standards/image_alt'),
    require('./standards/language_attribute'),
  ],

  matching: function(regexp) {
    return standards.all.filter(function(standard) {
      return regexp.test(standard.name);
    });
  }
}

module.exports = standards;
