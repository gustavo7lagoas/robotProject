*** Setting ***
Documentation       Search tickets v0.1
Variables           ../variables.py
Library             Selenium2Library
Library             String

*** Variables ***
${BASE_URL}             http://www.viajanet.com.br/
${MAX_PRICE}            550
${SELENIUM_TIMEOUT}     30

*** Test Cases ***
Search Tickets
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Selenium Timeout   ${SELENIUM_TIMEOUT}
    Maximize Browser Window
    ${page_title}=    Get Title
    Should Contain     ${page_title}    ViajaNet - Passagens Aéreas com economia garantida!
    Wait Until Element Is Visible    inptorigin
    Input Text    departureDate    ${FROM_DATE}
    Input Text    arrivalDate    ${TO_DATE}
    ${selenium_speed}=    Set Selenium Speed    1 seconds
    Click Element    inptorigin
    Input Text    inptorigin    ${FROM}
    Click Element    css=.suggestion.select:nth-of-type(1)
    Input Text    inptdestination    ${TO}
    Click Element    css=.suggestion.select:nth-of-type(2)
    Select Radio Button    triptype    1
    Set Selenium Speed    ${selenium_speed}
    Click Element    css=.btn-search.btn-search-passagens
    Wait Until Element Is Visible    css=ul.list-best-val
    @{prices}=    Get Webelements    css=div.price h3
    :FOR    ${price}    IN    @{prices}
    \       ${price}=    Get Text    ${price}
    \       ${price}=    Remove String    ${price}    R$\
    \       ${price}=    Replace String    ${price}    ,    .
    \       ${price}=    Strip String    ${price}
    \       Continue For Loop If    '${price}'=='${EMPTY}'
    \       ${price}=    Convert To Number    ${price}
    \       Run Keyword If    ${price}<${MAX_PRICE}    Log    Ticket Found!
    [Teardown]    Close Browser
