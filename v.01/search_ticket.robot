*** Setting ***
Documentation       Search tickets v0.1
Variables           ../variables.py
Library             Selenium2Library
Library             String

*** Variables ***
${BASE_URL}             http://www.melhoresdestinos.com.br/
${MAX_PRICE}            550
${SELENIUM_TIMEOUT}     30

*** Test Cases ***
Search Tickets
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Selenium Timeout   ${SELENIUM_TIMEOUT}
    Maximize Browser Window
    ${page_title}=    Get Title
    Should Contain     ${page_title}    Melhores Destinos
    Select Radio Button    tipo_viagem    1
    Wait Until Element Is Visible    origemCP
    Input Text    origemCP    ${FROM}
    Input Text    destinoCP    ${TO}
    Input Text    data-ida    ${FROM_DATE}
    Input Text    data-volta    ${TO_DATE}
    Click Element    css=div.bt-submit-pesquisa input
    Select Window    Passagens Aéreas, Hotéis e Pacotes é no Submarino Viagens
    Maximize Browser Window
    Wait Until Element Is Visible    css=div.results
    Wait Until Element Is Visible    id=body
    @{prices}=    Get Webelements    css=div.carousel-no-style div.cycle-carousel-wrap li.melhores-precos span.price
    :FOR    ${price}    IN    @{prices}
    \       ${price}=    Get Text    ${price}
    \       Continue For Loop If    '${price}'=='-'
    \       ${price}=    Remove String    ${price}    R$\
    \       ${price}=    Convert To Integer    ${price}
    \       Run Keyword If    ${price}<${MAX_PRICE}    Log    Ticket Found!
    [Teardown]    Close Browser
