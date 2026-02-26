*** Settings ***
Documentation     Tests for cart functionality on the demo blaze website without logged in user.

Library           Collections
Library           String
Resource          ../../../resources/common.resource

Suite Setup       New Chrome Browser
Test Setup        New FHD Context with New Page
Test Teardown     Close Context
Suite Teardown    Close Browser

*** Variables ***
${VISIBLE_CLOSE_BUTTON}     //div[@class='modal fade show']//button[@class='btn btn-secondary' and text()='Close']
${COOKIE_VALUE}             4dfae549-2174-3749-f8fa-5e38dd47314f

*** Test Cases ***
Add Product To Cart
    Setup Cookie
    Click    //a[@class='hrefch' and text()='Samsung galaxy s6']
    ${promise}=    Promise To    Wait For Response    matcher=**/addtocart    timeout=3s
    Click    //a[@class='btn btn-success btn-lg' and text()='Add to cart']
    ${body}=    Wait For    ${promise}
    Should Be Equal    ${body.status}    ${200}
    Click    //a[@class='nav-link' and text()='Cart']
    ${cart_item}=    Get Text    //tr[@class='success'][1]/td[2]
    Should Be Equal    ${cart_item}    Samsung galaxy s6

Delete Product From Cart
    Setup Cookie
    Click    //a[@class='nav-link' and text()='Cart']
    ${promise}=    Promise To    Wait For Response    matcher=**/deleteitem    timeout=3s
    Click    //tr[@class='success'][1]//a[text()='Delete']
    ${body}=    Wait For    ${promise}
    Should Be Equal    ${body.status}    ${200}

Add Product To Cart And Place Order
    Setup Cookie
    Click    //a[@class='hrefch' and text()='Nokia lumia 1520']
    ${promise}=    Promise To    Wait For Response    matcher=**/addtocart    timeout=3s
    Click    //a[@class='btn btn-success btn-lg' and text()='Add to cart']
    ${body}=    Wait For    ${promise}
    Should Be Equal    ${body.status}    ${200}
    ${promise}=    Promise To    Wait For Response    matcher=**/viewcart    timeout=3s
    Click    //a[@class='nav-link' and text()='Cart']
    ${body}=    Wait For    ${promise}
    ${count}=    Get Length    ${body.body.Items}
    Should Be Equal As Integers    ${count}    1
    Click    //button[@class='btn btn-success' and text()='Place Order']
    Fill User Details And Place Order
    ...    Test User    
    ...    Test Country
    ...    Test City
    ...    1234 5678 9012 3456
    ...    12
    ...    2025
    Click    //button[text()='OK']
    Get Text    id=nava    contains    PRODUCT STORE
    ${promise}=    Promise To    Wait For Response    matcher=**/viewcart    timeout=3s
    Click    //a[@class='nav-link' and text()='Cart']
    ${body}=    Wait For    ${promise}
    ${count}=    Get Length    ${body.body.Items}
    Should Be Equal As Integers    ${count}    0

*** Keywords ***
Setup Cookie
    Add Cookie    user    ${COOKIE_VALUE}    domain=demoblaze.com    path=/

Fill User Details And Place Order
    [Arguments]    ${name}    ${country}    ${city}    ${card}    ${month}    ${year}
    Fill Text    id=name    ${name}
    Fill Text    id=country    ${country}
    Fill Text    id=city    ${city}
    Fill Text    id=card    ${card}
    Fill Text    id=month    ${month}
    Fill Text    id=year    ${year}
    Click    //button[@class='btn btn-primary' and text()='Purchase']