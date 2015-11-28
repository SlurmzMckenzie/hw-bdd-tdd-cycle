Feature: Create and delete movies
 
	As a user
	I want to add and delete movies from the database
	So that I can keep the database up to date
 
Background: movies in database
 
	Given the following movies exist:
	| title        | rating | director     | release_date |
	| Star Wars    | PG     | George Lucas |   1977-05-25 |
	| Blade Runner | PG     | Ridley Scott |   1982-06-25 |
	| Alien        | R      |              |   1979-05-25 |
	| THX-1138     | R      | George Lucas |   1971-03-11 |

	And I am on the RottenPotatoes home page
 
Scenario: Create a new Movie
	When I follow "Add new movie"
	And  I fill in "Title" with "Ted"
	And  I fill in "Director" with "Seth"
	And  I press "Save Changes"
	Then I should see "Ted was successfully created."
 
Scenario: Delete the movie Star Wars from the database
	Given I am on the details page for "Star Wars"
	When  I press "Delete"
	Then  I should see "Movie 'Star Wars' deleted."

 