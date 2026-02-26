*** Settings ***
Documentation     Tests for sign up functionality on the demo blaze website.

Library           String
Resource          ../../../resources/common.resource

Suite Setup       New Chrome Browser
Test Setup        New FHD Context with New Page
Test Teardown     Close Context
Suite Teardown    Close Browser

*** Variables ***
${VISIBLE_CLOSE_BUTTON}    //div[@class='modal fade show']//button[@class='btn btn-secondary' and text()='Close']
&{USER1}                   username=standard_user    password=secret_sauce

*** Test Cases ***
Create New User
    Click    id=signin2
    Wait For Elements State    ${VISIBLE_CLOSE_BUTTON}    visible
    &{user}=    Genarate Random User
    Fill Text    id=sign-username    ${user.username}
    Fill Text    id=sign-password    ${user.password}
    ${promise}=    Promise To    Wait For Response    matcher=**/signup    timeout=3s
    Click    xpath=//div[@class='modal fade show']//button[@class='btn btn-primary' and text()='Sign up']
    ${body}=    Wait For    ${promise}
    Should Be Equal    ${body.status}    ${200}

Try Create Existing User
    Click    id=signin2
    Wait For Elements State    ${VISIBLE_CLOSE_BUTTON}    visible
    Fill Text    id=sign-username    ${USER1.username}
    Fill Secret    id=sign-password    $USER1.password
    ${promise}=    Promise To    Wait For Response    matcher=**/signup    timeout=3s
    Click    xpath=//div[@class='modal fade show']//button[@class='btn btn-primary' and text()='Sign up']
    ${body}=    Wait For    ${promise}
    Should Not Be Equal    ${body.status}    ${200}

*** Keywords ***
Genarate Random User
    ${random_string}=    Generate Random String    8
    ${username}=    Catenate    user_    ${random_string}
    ${password}=    Catenate    secret_sauce_    ${random_string}
    &{user}=    Create Dictionary    username=${username}    password=${password}
    RETURN    ${user}