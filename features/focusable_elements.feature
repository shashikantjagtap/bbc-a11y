Feature: Focusable elements

  It should be possible to use something other than a mouse (e.g. keyboard, switch) to
  navigate around a page.

  Rules:

  - active elements *must* be focusable
  - default active elements are: `a`, `input`, `select` and `textarea`
  - inactive elements (everything else) *must not* be focusable
  - you can specify specific elements that should be active (by CSS selector)
  - you can specify exceptions (by CSS selector)

  Questions:

  - what exactly counts as an active element? What about buttons?

  Scenario: Default active element cannot be focussed because of negative tabindex
    Given a page with this HTML:
      """
      <a href="/news" tabindex="-1">News</a>
      """
    When I run the tool
    Then I see the warnings:
      | Unable to focus on link 'a': negative tabindex |

  Scenario: Anchor without a href
    """
    <a>News</a>
    """
  When I run the tool
  Then I see the warnings:
    | Unable to focus on link 'a': missing href |

  Scenario: Inactive element that's been made active
    Given a page with this HTML:
      """
      <p tabindex="1">News</p>
      """
    When I run the tool
    Then I see the warnings:
      | Should not be able to focus on inactive element 'p' |

  Scenario: Disabled element that would normally be active
    Given a page with this HTML:
      """
      <input type="submit" disabled>Go</input>
      """
    When I run the tool
    Then I see the no warnings

  Scenario: Force explicit check using CSS selector
    Given a page with this HTML:
      """
      <a class="carousel-item" href="/casualty">Casualty</a>
      <span class="carousel-item" onlick="window.location='/strictly'>Strictly Come Dancing</span>
      """
    And I have configured the following active elements for the page:
      | carousel-item |
    When I run the tool
    Then I see the failure "Unable to focus on element 'carousel-item:nth-item(1)'"

  Scenario: Specify an exception
    Given a page with this HTML:
      """
      <div class="legacy">
        <a href="/news" tabindex="-1">News</a>
      </div>
      """
    And I have configured the following exceptions:
      | .legacy * |
    When I run the tool
    Then I see no warnings
