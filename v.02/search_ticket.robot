*** Setting ***
Documentation       Search tickets v0.2
Variables           ../variables.py
Library             Selenium2Library
Test Teardown       Close Browser
Library             String

*** Variables ***
${BROWSER}              firefox
${BASE_URL}             http://www.melhoresdestinos.com.br/
${MAX_PRICE}            550
${SELENIUM_TIMEOUT}     30

*** Test Cases ***
Search Tickets
    Visit Tickets Search
    Fill Search Fields    from=${FROM}    to=${TO}    from_date=${FROM_DATE}
    ...     to_date=${TO_DATE}    trip_type=ida e volta
    Check Result Prices Against    ${MAX_PRICE}

*** Keywords ***
Visit Tickets Search
    [Documentation]     Opens browser in the base url and prepares it to
    ...     execution
    ...
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Selenium Timeout   ${SELENIUM_TIMEOUT}
    Maximize Browser Window
    ${page_title}=    Get Title
    Should Contain     ${page_title}    Melhores Destinos

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
    Wait Until Element Is Visible    origemCP
    Select Radio Button    tipo_viagem    1
    Input Text    origemCP    ${FROM}
    Input Text    destinoCP    ${TO}
    Input Text    data-ida    ${FROM_DATE}
    Input Text    data-volta    ${TO_DATE}
    Click Element    css=div.bt-submit-pesquisa input
    Select Window    Passagens Aéreas, Hotéis e Pacotes é no Submarino Viagens
    Maximize Browser Window
    Wait Until Element Is Visible    css=div.results

Check Result Prices Against
    [Documentation]     Compares Best prices against a given value
    ...     * Parameters *
    ...     max_price - Trip Origin
    ...
    [Arguments]    ${max_price}
    ...
    @{prices}=    Get Webelements    css=div.carousel-no-style div.cycle-carousel-wrap li.melhores-precos span.price
    :FOR    ${price}    IN    @{prices}
    \       ${price}=    Get Text    ${price}
    \       Continue For Loop If    '${price}'=='-'
    \       ${price}=    Remove String    ${price}    R$\
    \       ${price}=    Convert To Integer    ${price}
    \       Run Keyword If    ${price}<${MAX_PRICE}    Log    Ticket Found!
