Feature: Indicating language

    The language of the page must be specified so that screen readers know what language to speak

    Rules:

    - Page must have a language defined

    Questions:

    Would this work for Native Apps?

    Scenario: No language attribute on html tag
        Given a page with this HTML:
            """
            <html></html>
            """
        When I run the tool
        Then I see the failures:
            | No language attribute on html tag |

    Scenario: Empty language attribute on html tag
        Given a page with this HTML:
            """
            <html lang=""></html>
            """
        When I run the tool
        Then I see the failures:
            | Empty language attribute on html tag |

    Scenario: Invalid language attribute on html tag
        Given a page with this HTML:
            """
            <html lang="spanish"></html>
            """
        When I run the tool
        Then I see the failures:
            | Invalid language attribute on html tag |
