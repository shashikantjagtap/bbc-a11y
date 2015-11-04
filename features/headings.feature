Feature: Headings 

 It should be possible to navigate the page via the heading structure 


Rules : 

 -- When supported by the platform there should be headings 
 -- Headings should be in a logical and hierarchical structure 

Scenario: Web page with no headings 

  Given a page with HTML :
  """
	<html>
	<head>
	</head>
    <body>
    </body>
	</html>
 """	
  When I run the tool 
  Then I should get fail 

  """
   Your webpage has no headings 
  """

Scenario: Mobile Page
  	Given a page with objective C
  	"""
    
  	"""
  	 When I run the tool 
  Then I should get fail 

  """
   Your webpage has no headings 
  """


Scenario: Webpage with incorrect heading structure 
  
  Given a page with HTML :
  """
	<html>
	<head>
	</head>
    <body>
    <h2>BBC Nav</h2>
    <h1>BBC News</h1>
    </body>
	</html>
 """	
  When I run the tool 
  Then I should get fail 

  """
   Your webpage headings are in wrong order
  """





