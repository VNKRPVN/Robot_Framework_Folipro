*** Settings ***
Library    RequestsLibrary
Library    BuiltIn

*** Variables ***
${BASE_URL}          http://www.cbr.ru/dataservice
${PATH}              /data
${Y1}                2021
${Y2}                2021
${DATASET_ID}        29
${PUBLICATION_ID}    14
${EXPECTED_STATUS}   200 

*** Test Cases ***
Test Response Status Code
    [Documentation]    Тест проверки возвращаемого кода ответа от API ЦБ РФ
    Create Session    cbrf    ${BASE_URL}
    ${response}=      Send API Request
    Check Response Status    ${response}

Test Response Time
    [Documentation]    Тест проверки, что время ответа API ЦБ РФ меньше 2 секунд
    Create Session    cbrf    ${BASE_URL}
    ${start_time}=    Get Time    epoch
    ${response}=      Send API Request
    ${end_time}=      Get Time    epoch
    ${elapsed}=       Evaluate    float(${end_time}) - float(${start_time})
    Should Be True    ${elapsed} < 2    Время ответа должно быть меньше 2 секунд
    Log               Время ответа: ${elapsed} секунд

*** Keywords ***
Send API Request
    [Documentation]    Отправляет запрос к API с параметрами и возвращает ответ
    ${url}=            Set Variable    ${PATH}?y1=${Y1}&y2=${Y2}&datasetId=${DATASET_ID}&publicationId=${PUBLICATION_ID}
    ${response}=       GET On Session    cbrf    ${url}
    RETURN             ${response}

Check Response Status
    [Arguments]        ${response}
    [Documentation]    Проверяет, что код статуса ответа равен ожидаемому
    Should Be Equal As Integers    ${response.status_code}    ${EXPECTED_STATUS}
