*** Settings ***
Library   Browser

*** Variables ***
${BROWSER}     chromium
${HEADLESS}    False
${VIEWPORT}    {'width': 1920, 'height': 1080}
${URL}         https://demoblaze.com/

*** Keywords ***
New Chrome Browser
    [Arguments]    ${headless}=${HEADLESS}
    New Browser    browser=${BROWSER}    headless=${headless}

New FHD Context with New Page
    New Context    viewport=${VIEWPORT}
    New Page    ${URL}