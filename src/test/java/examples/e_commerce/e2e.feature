Feature:

Background:
    # Pour l'url ...
    * url 'https://api.efi-academy.com/user-api/public/'

    # Pour les valeurs aléatoires avec FAKER...
    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def random_name = faker.name().fullName()
    * def random_email = faker.internet().emailAddress()
    * def random_password = faker.internet().password(8, 20, true, true, true)
    * def nb_role = faker.number().numberBetween(0, 100)
    * def random_role = nb_role > 40 ? 'admin' : 'user'

    # Pour le code status
    * def code_auth = random_role == 'user' ? 403 : 201

    # Pour la crétion de PRODUCT
    * def random_name_prd = faker.commerce().productName() 
    * def random_desc_prd = faker.lorem().words(10) 
    * def random_price_prd = faker.commerce().price(200, 1000)
    * def random_stock_prd = faker.number().numberBetween(10, 50)
    * def random_image_prd = faker.avatar().image()


######### CREATION UTILISATEUR USER OU ADMIN #########
@tags1
Scenario:
    #  #(variable_name)
    * def utilisateur =
      """
        {
            "name": #(random_name),
            "email": #(random_email),
            "password": #(random_password),
            "role": #(random_role)
        }
      """
    Given path 'register'
    And request utilisateur
    When method post
    Then status 201
######### LOGIN USER OU ADMIN #########

    * def utilisateur_login =
    """
        {
            "email": #(random_email),
            "password": #(random_password)
        }
    """
    Given path 'login'
    And request utilisateur_login
    When method post
    Then status 200
    And match response.success == true
    * def token = response.token

######### CREATION DE PRODUCT #########
    * def product =
    """
        {
            "name": #(random_name_prd),
            "description": #(random_desc_prd),
            "price": #(random_price_prd),
            "stock": #(random_stock_prd),
            "image_url": #(random_image_prd)
        }
    """
    
    Given path 'products'
    And header Authorization = 'Bearer ' + token
    And request product
    When method post
    Then match responseStatus == code_auth



