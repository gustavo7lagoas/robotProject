*** Settings ***
Library    ComparePrices.py

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
    Select Window    Passagens aéreas nacionais e internacionais em promoção | Submarino Viagens Viagens
    Maximize Browser Window
    Wait Until Element Is Visible    css=div.results

Check Result Prices Against
    [Documentation]     Compares Best prices against a given value
    ...     * Parameters *
    ...     max_price - Trip Origin
    ...
    [Arguments]    ${max_price}
    ...
    @{prices}=    Get Webelements    css=li.best_price
    :FOR    ${price}    IN    @{prices}
    \       ${price}=    Get Text    ${price}
    \       ${is_price_good}=    Compare Prices Against   ${price}    ${MAX_PRICE}
    \       Run Keyword If    ${is_price_good}    Capture Page Screenshot
    ...     ELSE    Log    Did not find any tickets for this search :(
