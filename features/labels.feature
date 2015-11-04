Feature: Form Labels
All form controls MUST have a label

Questions:
- what counts as a label.  Title, Value and label element. 
- Aria-label and Placeholder failed. Aria-label requires a title.


Background:
A HTML page with text input area’s, radio buttons and buttons


Scenario: Text input

Given a page with HTML

<label for="name">Name:</label>
<input id="name" type="text" name="textfield">
 
When I run the tool
Then I will see no warnings.


Scenario: input with a value

Given a page with HTML
"""
<input id="overnight" type="radio" name="shipping" value="overnight”>
"""
When I run the tool
Then I see no warnings


Scenario: input with no value
Given a page with HTML
  """
  <input id="blank-value" type="text" name="reset" value="">
  <input id="missing-value" type="button" name="reset">
  """

When I run the tool
Then I see a failure - not able to access the button
| The element "input#blank-value" does not have a value or label   |
| The element "input#missing-value" does not have a value or label |
