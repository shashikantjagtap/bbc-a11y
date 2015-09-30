Feature: Focusable elements

  It should be possible to use something other than a mouse (e.g. keyboard, switch) to
  navigate around a page.

  Rules:

  - active elements must be focusable
  - inactive elements must not be focusable

  What counts as an "active element" is configurable per page, but will always include `a`,
  `button`, `input`, `select` and `textarea` elements by default.

  Questions:

  - do we allow for configuring exceptions to keep the noise down?
  - what's the point of the "no checks fail" scenario?

  Scenario: Bad tabindex on an active element
    Given a page with this HTML:
      """
      <a href="/dave" tabindex="-1">Dave</a>
      """
    When I run the tool
    Then I see the warnings:
      | Unable to focus on link 'a': negative tabindex |

  Scenario: Anchor without a href
    """
    <a>Dave</a>
    """
  When I run the tool
  Then I see the warnings:
    | Unable to focus on link 'a': missing href |

  Scenario: Inactive element that's been made active
    Given a page with this HTML:
      """
      <p tabindex="1">Dave</p>
      """
    When I run the tool
    Then I see the warnings:
      | Should not be able to focus on inactive element 'p' |

  Scenario: Disabled element that would normally be activate
    Given a page with this HTML:
      """
      <button disabled>Dave</button>
      """
    When I run the tool
    Then I see the no warnings

  Scenario: Try to make an explicit check for a disabled elements
    Given a page with this HTML:
      """
      <button class="go" disabled>Go</button>
      """
    And I have configured the following active elements for the page:
      | .go |
    When I run the tool
    Then I see the failure "Unable to focus on element 'button.go'"

  Scenario: Using a javascript onlick event on a normally inactive element
    Given a page with this HTML:
      """
      <a class="plr-carousel-item" href="/casualty">Casualty</a>
      <span class="plr-carousel-item" onlick="window.location='/strictly'>Strictly Come Dancing</span>
      """
    And I have configured the following active elements for the page:
      | plr-carousel-item |
    When I run the tool
    Then I see the failure "Unable to focus on element 'plr-carousel-item:nth-item(1)'"

  Scenario: Exclude some areas of the page with known issues

    TODO: We might want to use this more broadly for all the checks

    Given a page with this HTML:
      """
      <div class="legacy">
        <a href="/dave" tabindex="-1">Dave</a>
      </div>
      """
    And I have configured the following exceptions:
      | .legacy |
    When I run the tool
    Then I see no warnings
