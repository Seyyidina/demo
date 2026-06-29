Feature: Le test d API avec Swagger BRAND

Background:
    * url 'https://api.practicesoftwaretesting.com/'
@post2
Scenario: Créer un brand avec POST, MAJ ou Update de BRAND et GET BY ID
    #  #(variable_name)
    * def brand =
      """
        {
            "name": "new brand AD",
            "slug": "new-STPbrand-_AD"
        }
      """
    Given path 'brands'
    And request brand
    When method post
    Then status 201
    # Then response.success == true
    * match brand.name == response.name
    * match brand.slug == response.slug

    #  Update ...
    * def brand_new =
      """
        {
            "name": "new brand AD",
            "slug": "new--brandADSAD"
        }
      """

    * def id_brand = response.id
    Given path 'brands', id_brand
    And request brand_new
    When method put
    Then status 200
    And response.success == true
    # And match brand.name == response.name



