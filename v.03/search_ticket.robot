*** Setting ***
Documentation       Search tickets v0.3
Variables           ../variables.py
Test Teardown       Close Browser
Library             Selenium2Library
Library             String
Resource            search_ticket_keywords.robot

*** Variables ***
${BASE_URL}                     http://www.viajanet.com.br/
${MAX_PRICE}                    550
${SELENIUM_TIMEOUT}             30
${REMOTE_URL}                   http://127.0.0.1:4444/wd/hub
${FF_DESIRED_CAPABILITIES}      marionette:True,binary:wires

*** Test Cases ***
Search Tickets
    Visit Tickets Search
    Fill Search Fields    from=${FROM}    to=${TO}    from_date=${FROM_DATE}
    ...     to_date=${TO_DATE}    trip_type=ida e volta
    Check Result Prices Against    ${MAX_PRICE}
