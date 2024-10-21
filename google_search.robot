*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SEARCH_URL}    https://www.google.com
${BROWSER}       chrome
${SEARCH_QUERY}  Robot Framework
${RF_SITE}       https://robotframework.org
${DOSC_SITE}     https://docs.robotframework.org/docs

*** Test Cases ***
Test Google Search And Navigate To Guides
    Open Google And Search
    Open First Result For RobotFramework
    Open Docs Menu And Click Guides

*** Keywords ***
Open Google And Search
    Open Browser    ${SEARCH_URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    name=q    ${SEARCH_QUERY}
    Sleep    1s
    Press Enter To Submit Search

Press Enter To Submit Search
    Press Key    name=q    \\13

Open First Result For RobotFramework
    Wait Until Element Is Visible    xpath=//h3[contains(text(), 'Robot Framework')]
    Click Element    xpath=//h3[contains(text(), 'Robot Framework')]
    Wait Until Location Contains    ${RF_SITE}

Open Docs Menu And Click Guides
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'Docs')]
    Click Element    xpath=//div[contains(text(), 'Docs')]
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'Guides')]
    Click Element    xpath=//a[contains(text(), 'Guides')]
    Wait Until Location Contains    ${DOSC_SITE}
