Scenario:  Missing Alternative Text

Given I focus on an item 
And "alt" attribute is missing 
When I run the tool
Then I see the failure as " Missing Alternative text "


Scenario: Blank Alternative Text 

Given I focus on an item which has decorative image
And the alt="  "
Then a warning is displayed as " No Alternative text"

Scenario: Minimum Characters for Alternative text 

Given the alternative text min length is alt="Min.length is 20"
And I focus on a content item with alt="text with 10 characters"
When I run the tool
Then a warning is displayed " Is Alternative text provided descriptive enough"

Scenario: Maximum Characters for Alternative text 

Given the alternative text max length is alt="Max.length is 50"
And I focus on a content item with alt="text with 60 characters"
When I run the tool
Then a warning is displayed " Alternative text provided is too long"
