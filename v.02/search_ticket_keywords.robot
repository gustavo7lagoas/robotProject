*** Keywords ***
Visit Tickets Search
    [Documentation]     Opens browser in the base url and prepares it to
    ...     execution
    ...
    Run Keyword If    '${BROWSER}'=='firefox'    Open Browser    ${BASE_URL}
    ...     ${BROWSER}    remote_url=${REMOTE_URL}    desired_capabilities=${FF_DESIRED_CAPABILITIES}
    ...     ELSE    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Selenium Timeout   ${SELENIUM_TIMEOUT}
    Maximize Browser Window
    ${page_title}=    Get Title
    Should Contain     ${page_title}    ViajaNet - Passagens Aéreas com economia garantida!

Fill Search Fields
    [Documentation]     Fills all fields from search
    ...     * Parameters *
    ...     from - Trip Origin
    ...     to - Trip Destination
    ...     from_date - Trip start date
    ...     to_date - Trip end date
    ...     trip_type - Trip start date
    ...
    [Arguments]     ${from}=    ${to}=    ${from_date}=    ${to_date}=
    ...     ${trip_type}=
    ...
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

Check Result Prices Against
    [Documentation]     Compares Best prices against a given value
    ...     * Parameters *
    ...     max_price - Trip Origin
    ...
    [Arguments]    ${max_price}
    ...
    @{prices}=    Get Webelements    css=div.price h3
    :FOR    ${price}    IN    @{prices}
    \       ${price}=    Get Text    ${price}
    \       ${price}=    Remove String    ${price}    R$\
    \       ${price}=    Replace String    ${price}    ,    .
    \       ${price}=    Strip String    ${price}
    \       Continue For Loop If    '${price}'=='${EMPTY}'
    \       Run Keyword If    ${price}<${MAX_PRICE}    Capture Page Screenshot
    ...     ELSE    Log    Did not find any tickets for this search :(
