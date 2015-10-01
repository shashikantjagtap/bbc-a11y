Feature: Target touch size (#11)

  > Touch targets must be large enough to touch accurately.

  http://www.bbc.co.uk/guidelines/futuremedia/accessibility/mobile/design/touch-target-size

  Content must be large enough to read as well as have a large enough target area to tap comfortably
  with one finger. For example on an A-Z listing the letters should be placed in a container that is
  linked rather than just have the letter linked.

  The recommended range of touch targets is 7 – 10mm (see the Android Design Guidelines for details).
  This range is essentially no smaller than the smallest average finger. For users with disabilities
  or people who are older this size requirement becomes even more important as it may not be possible
  to touch elements accurately.

  Elements can be set at a minimum of 5mm with an exclusion zone of 7mm preserved around it or elements
  should be at least 7mm deep. All users benefit from larger touch targets however so a recommendation
  is to provide bigger ones where possible.

  Tip
  ---

  If there are elements that are related consider grouping them in one touch target as this increases
  the touch area. For example group a heading, image and synopsis for a news item into one block rather
  than a single link on the text or two separate links on the image and headline See Group Related
  Content for details.

  Questions
  ---------

  - Why is there an upper limit?
  - Do we need to have specific scenarios about different devices?
  - CAN SOMEONE PLEASE EXPLAIN HOW WE MAKE PIXELS MM AND DIPS TALK TO EACH OTHER PLEASE
  - "elements should be at least 7mm deep" please explain "deep" in this context?
  - diagrams

  Scenario: Tappable area that's too small
    Given a button that's 4mm wide, 7mm high
    Then FAIL

  Scenario: Tappable area has insufficient exclusion zone
    Given I view a button that's 5mm wide, 5mm high
    And another button 1mm to the left of it
    Then FAIL

  Scenario: Tappable area too small but with sufficent exclusion zone
    Given I view a button that's 5mm, 5mm high
    And another button 3mm to the left of it
    Then PASS

  Scenario: Tappable area that's OK on low-density devices but too small on high-density devices
    Given a touch taget that's only just big enough on an Archos 22-inch TV
    When I test the app on a Kindle Fire HD
    Then it FAIL

  Scenario: Tappable area is big enough
