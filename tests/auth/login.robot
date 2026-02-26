*** Settings ***
Documentation     Tests for login functionality on the demo blaze website.

Resource          ../../../resources/common.resource

Suite Setup       New Chrome Browser
Test Setup        New FHD Context with New Page
Test Teardown     Close Context
Suite Teardown    Close Browser

*** Variables ***
${VISIBLE_CLOSE_BUTTON}    //div[@class='modal fade show']//button[@class='btn btn-secondary' and text()='Close']
&{USER1}                   username=standard_user    password=secret_sauce

*** Test Cases ***
Login User1
    Click    //a[@class='nav-link' and text()='Log in']
    Get Text    id=logInModalLabel    contains    Log in
    Fill Text    id=loginusername    ${USER1.username}
    Fill Secret    id=loginpassword    $USER1.password
    Click    id=logInModal >> .btn-primary
    Get Text    id=nameofuser    contains    standard_user

Login User1 And Logout
    Click    //a[@class='nav-link' and text()='Log in']
    Get Text    id=logInModalLabel    contains    Log in
    Fill Text    id=loginusername    ${USER1.username}
    Fill Secret    id=loginpassword    $USER1.password
    Click    id=logInModal >> .btn-primary
    Get Text    id=nameofuser    contains    standard_user
    Click    //a[@class='nav-link' and text()='Log out']
    Get Element States    id=nameofuser    contains    hidden

Login Bad Password
    Click    //a[@class='nav-link' and text()='Log in']
    Get Text    id=logInModalLabel    contains    Log in
    Fill Text    id=loginusername    ${USER1.username}
    Fill Text    id=loginpassword    bad_password
    Click    id=logInModal >> .btn-primary
    Get Text    id=logInModalLabel    contains    Log in

Login Bad Username
    Click    //a[@class='nav-link' and text()='Log in']
    Get Text    id=logInModalLabel    contains    Log in
    Fill Text    id=loginusername    bad_username
    Fill Secret    id=loginpassword    $USER1.password
    Click    id=logInModal >> .btn-primary
    Get Text    id=logInModalLabel    contains    Log in
