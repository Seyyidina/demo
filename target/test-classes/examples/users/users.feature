Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200

  @post1
  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201
    * def elt = response
    * match elt.name == response.name
    * match elt.username == response.username
    * match elt.email == response.email
    * match elt.address.street == response.address.street
    * match elt.address.suite == response.address.suite
    * match elt.address.city == response.address.city
    * match elt.address.zipcode == response.address.zipcode

    * def id = response.id
    * print 'created id is: ', id

    Given path id
    When method get
    Then status 200
    # And match response contains user
  