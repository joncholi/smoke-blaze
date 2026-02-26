*** Settings ***
Documentation     Tests for product navigation on the home page.

Library           Collections
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

Category Phones
    ${list}=    Click Category And Return Response    Phones
    Test List Contains Only    ${list}    phone

Category Laptops
    ${list}=    Click Category And Return Response    Laptops
    Test List Contains Only    ${list}    notebook

Category Monitors
    ${list}=    Click Category And Return Response    Monitors
    Test List Contains Only    ${list}    monitor

Click Through Carousel 3times
    [Documentation]    Click through the carousel 3 times forward and 3 times backward.
    ...                This bit flaky still, because errors occur if the carousel is
    ...                still animating when the next click happens.
    FOR    ${i}    IN RANGE    3
        Click    id=carouselExampleIndicators >> .carousel-control-next-icon
        Sleep    500ms
    END
    FOR    ${i}    IN RANGE    3
        Click    id=carouselExampleIndicators >> .carousel-control-prev-icon
        Sleep    500ms
    END

Click Next Category Page
    [Documentation]    Needs more planning how to test these.
	[Tags]	NOTREADY
    ${promise}=    Promise To    Wait For Response    matcher=**/pagination    timeout=3s
    Click    //button[@id='next2' and text()='Next']
    ${body}=    Wait For    ${promise}
    Should Be Equal    ${body.status}    ${200}

Click Prev Category Page
    [Documentation]    Needs more planning how to test these.
    [Tags]	NOTREADY
    ${promise}=    Promise To    Wait For Response    matcher=**/pagination    timeout=3s
    Click    //button[@id='prev2' and text()='Previous']
    ${body}=    Wait For    ${promise}
    Should Be Equal    ${body.status}    ${200}

*** Keywords ***
Click Category And Return Response
    [Arguments]    ${category}
    ${promise}=    Promise To    Wait For Response    matcher=**/bycat    timeout=3s
    Click    //a[@class='list-group-item' and text()='${category}']
    ${body}=    Wait For    ${promise}
    ${items}=    Convert To List    ${body.body.Items}
    RETURN    ${items}

Test List Contains Only
    [Arguments]    ${list}
    ...            ${category}
    FOR    ${item}    IN    @{list}
        ${cat}=    Get From Dictionary    ${item}    cat
        Should Be Equal    ${cat}    ${category}
    END