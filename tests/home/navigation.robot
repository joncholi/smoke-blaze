*** Settings ***
Documentation     Tests for navigation on the home page.

Resource          ../../../resources/common.resource

Suite Setup       New Chrome Browser
Test Setup        New FHD Context with New Page
Test Teardown     Close Context
Suite Teardown    Close Browser

*** Variables ***
${VISIBLE_CLOSE_BUTTON}    //div[@class='modal fade show']//button[@class='btn btn-secondary' and text()='Close']

*** Test Cases ***
Home Page
    Get Text    id=nava    contains    PRODUCT STORE

Open Contact Modal
    Click    //a[@class='nav-link' and text()='Contact']
    Get Text    id=exampleModalLabel    contains    New message
    Test Element Visible And Hidden    id=recipient-email

Open About Us Modal
    Click    //a[@class='nav-link' and text()='About us']
    Get Text    id=videoModalLabel    contains    About us
    Test Element Visible And Hidden    id=example-video

Open Cart Page
    Click    //a[@class='nav-link' and text()='Cart']
    Get Text    id=page-wrapper    contains    Products

Open Login Modal
    Click    //a[@class='nav-link' and text()='Log in']
    Get Text    id=logInModalLabel    contains    Log in
    Test Element Visible And Hidden    id=loginusername

Open Sign Up Modal
    Click    //a[@class='nav-link' and text()='Sign up']
    Get Text    id=signInModalLabel    contains    Sign up
    Test Element Visible And Hidden    id=sign-username

*** Keywords ***
Test Element Visible And Hidden
    [Arguments]    ${attribute}
    ${element}=    Get Element    ${attribute}
    Get Element States    ${element}    contains    visible
    Click    ${VISIBLE_CLOSE_BUTTON}
    Get Element States    ${element}    contains    hidden