Feature: Mute errors

  Things like ORB and Barlesque that we don't control will clutter up our pages
  with violations.

  We need a way to ignore the errors generated by these areas of the page so
  we can focus on the problems that we can actually fix.

  Rules:

  - exclude any errors that match the filtering rules

  Scenario: Mute an error with no specific elements in it

    Where the standard (e.g. exactly one main heading standard) applies to the
    whole page, we still report an error even when we have an ignore rule.

    Given a page with no h1s
    And an ignore rule for a region of the page
    When I validate the exactly one main heading standard
    Then it fails with the message:
      """
      A document must have exactly one heading. Found 0 h1 elements.
      """

  Scenario: Mute an error that mentions just one HTML element

  Scenario: Mute an error that mentions one or more elements
    Given a page with the HTML:
      """
      <div id="dodgy-legacy-banner">
        <h1>I am a legacy</h1>
      </div>
      <h1>The real heading</h1>
      """
    When I validate the exactly one main heading standard
    Then it fails with the message:
      """
      A document must have exactly one heading. Found 2 h1 elements:
        /html/body/div/h1
        /html/body/h1
      """
    When I add a configuration with:
      """
        mute: [
          {
            standard: "exactly-one-main-heading",
            css: "#dodgy-legacy-banner h1"
          }
        ]
      """
    And I validate the exactly one main heading standard
    Then it passes

  Scenario: Mute an error about one bad element, but still see other similar problems on the page
    Given a page with the HTML:
      """
      <div id="dodgy-legacy-banner">
        <h1>I am a legacy</h1>
      </div>
      <h1>The real heading</h1>
      <h1>Team, fix me</h1>
      """
    When I validate the exactly one main heading standard
    Then it fails with the message:
      """
      A document must have exactly one heading. Found 3 h1 elements:
        /html/body/div/h1
        /html/body/h1[1]
        /html/body/h1[2]
      """
    When I add a configuration with:
      """
        mute: [
          {
            standard: "exactly-one-main-heading",
            css: "#dodgy-legacy-banner h1"
          }
        ]
      """
    When I validate the exactly one main heading standard
    Then it fails with the message:
      """
      A document must have exactly one heading. Found 2 h1 elements:
        /html/body/h1[1]
        /html/body/h1[2]
      """

  Scenario: Mute an error about one bad element, but still see other similar problems on the page
    Given a page with the HTML:
      """
      <div id="legacy">
        <input type="text" name="txtName"/>
      </div>
      <input type="text" name="name"/>
      """
    When I validate the form labels standards
    Then it fails with the message:
      """
      Field has no label or title attribute:
        /html/body/div/input
        /html/body/input
      """
    When I add a configuration with:
      """
        mute: [
          {
            standard: "form-labels",
            css: "#legacy input"
          }
        ]
      """
    When I validate the form labels standard
    Then it fails with the message:
      """
      Field has no label or title attribute:
        /html/body/input
      """
