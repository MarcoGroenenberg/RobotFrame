*** Settings ***
Documentation     An example resource file
Library           SeleniumLibrary
Library            ../pythonlibs/FileHandling.py

*** variables ***
${env.BASE_URL}    https://arm-dev1.centralisatie.com
${env.BROWSER}    Chrome
${env.WEBGUI_USERNAME}    marcog
${env.WEBGUI_PASSWORD}    123
${env.GENERIS_VERSION}    12
${env.WEBGUI_VERSION}    12

*** Keywords ***
Open Login Page ARM
    [Documentation]                              Opens browser to login page
    Open Browser                                 ${env.BASE_URL}/common/Login.aspx    ${env.BROWSER}   
    Set Window Size                              1600    900
    sleep                                        5
        

Log in ARM
    [Documentation]  Logs into an ARM environment specified in environment settings
    SeleniumLibrary.Set Screenshot Directory     ${EXECDIR}${/}Screenshots        
    Set Selenium Implicit Wait                   10
    Open Login Page ARM
    SeleniumLibrary.Input Text                   xpath=//*[contains(@name, "UserName")]    ${env.WEBGUI_USERNAME} 
    SeleniumLibrary.Input Password               xpath=//*[contains(@name, "Password")]    ${env.WEBGUI_PASSWORD} 
    SeleniumLibrary.Click Button                 xpath=//*[contains(@name, "LoginButton")]
    
Change Domain ARM
    [Documentation]                  Changes the ARM domain to a given domain
    [Arguments]                      ${DOMAIN} 
    Select From List By Label        xpath=//*[@id="DublinTheme_wt15_block_wtHeader_Common_wt4_block_DublinTheme_wt9_block_wtHeader_loginInfo_VerticalAlign_wt28_block_wtContent_wt11_wt3"]  ${DOMAIN}
    Sleep                            5    
    Log                              ${DOMAIN} selected.     

Toon Aansluiting
    [Documentation]     Open een aansluiting (aangeduid door EAN-code) in de browser
    [Arguments]         ${EAN_code}
    ${MP_id}=           Get ID from EAN                                         ${EAN_code}
    Go To               ${env.BASE_URL}/MDP/ViewMeters.aspx?MeteringPointId=${MP_id}&ReturnMenuId=18    
    Log                 Toon EAN ${EAN_code}



Check versions
    [Documentation]                  Check version 
    Log                              Click to show menu  
    #    Click Element                   xpath=//*[@tabindex=2]
    Click Element                    //*[@id="DublinTheme_wt22_block_wtHeader_wt20_DublinTheme_wt9_block_wt3"]
    SeleniumLibrary.Click Element    xpath=//*[contains(@href, "About")]
    #   Check Generis Version:
    SeleniumLibrary.Element Should Contain    xpath=//*[@id="DublinTheme_wt10_block_wtMainContent_WebPatterns_wt2_block_wtColumn2"]/div[2]       ${env.GENERIS_VERSION}
    #   Check WebGUI Version:
    SeleniumLibrary.Element Should Contain    xpath=//*[@id="DublinTheme_wt10_block_wtMainContent_WebPatterns_wt2_block_wtColumn2"]/div[1]/span  ${env.WEBGUI_VERSION}
    Log                                       Versions verified    
     
Finish Test ARM
    [Documentation]  Closes Browser and logs test as completed
    Close Browser
    Log    Test completed
    Log    Test executed by user %{USERNAME} on %{os}    


Click Link Verbruiken Toevoegen
    [Documentation]                 Klik op de hyperlink om verbruiken/max toe tevoegen
    Click Button                    xpath=//*[@testid="AddConsumptionMonthMax_btn"]

Click Tab Verbruiken
    [Documentation]                 Klik op de tab "Verbruiken" in scherm Aansluiting Raadplegen (context: Aansluiting)
    Click Link                      xpath=//*[@id="DublinTheme_wt15_block_wtMainContent_Common_wt2_block_BreezeUI_wtTabladen_block_wtListRecords1_ctl10_wt18"]



Voer Verbruiken Op
    [Documentation]                 GUI Opvoer van verbruiken voor een EAN. Er moet al ingelogd zijn
    [Arguments]                     ${MP_EAN}                               
    # Toon de aansluiting op het scherm:
    Toon Aansluiting                ${MP_EAN}
    Click Tab Verbruiken
    Click Link Verbruiken Toevoegen

    SeleniumLibrary.Select Frame    xpath=/html/body/div[3]/div[2]/iframe
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_BreezeUI_wtStartDateInput_block_wtDateStartInput"]    01-01-2018
    Set Browser Implicit Wait       5
    Set Focus to Element            xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl10_wtConsumptionValueInput"]
    Set Browser Implicit Wait       5
    Mouse Down                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl10_wtConsumptionValueInput"]
    Sleep                           3
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_BreezeUI_wtStopDateInput_block_wtDateStartInput"]     01-02-2018
    Mouse Down                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl10_wtConsumptionValueInput"]
    Set Browser Implicit Wait       5
    Mouse Down                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl10_wtConsumptionValueInput"]
    #   Consumptie:
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl03_wtConsumptionValueInput"]     100
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl04_wtConsumptionValueInput"]     200
    #   Productie:
    
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl05_wtConsumptionValueInput"]     300
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl06_wtConsumptionValueInput"]     500
    #   Max
    Input Text                      xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable_ctl10_wtConsumptionValueInput"]     13

    Click Element                   xpath=//*[@id="WebPatterns_wt5_block_wtText_wtBrzRestMeteringPointConsAddEditGVTable"]/tbody/tr[1]/td[1]/div
    Click Button                    xpath=//*[@id="WebPatterns_wt5_block_wtText_wtEdit_btn"]
    #   Geef het systeem 5 seconden om de verbruiken te verwerken.
    Sleep                           10
    Element Should Contain          xpath=//*[@class="Feedback_Message_Text"]     Verbruik toegevoegd
   
Upload CSV en Controleer
    [Documentation]                 Upload een bestand    
    [Arguments]                     ${BasedOnCSVTemplate}     ${expected_status}
    # Maak de CSV o.b.v. een template en ontvang Message ID:
    ${messageId}=                   Get Generated CSV File          ${EXECDIR}${/}CSV Templates${/}${BasedOnCSVTemplate}  # Dit is een template CSV
    Log To Console                  messageId ${messageId}
    common.Upload MDP Bestand       ${EXECDIR}${/}CSV Upload${/}${messageId}.csv
    # Ga naar Berichten Tab:
    Go To                           ${env.BASE_URL}/MDP/GenericIOArchive.aspx
    # Vul zoekveld BerichtID met messagid
    Input Text                      //*[@id="DublinTheme_wt22_block_wtMainContent_Common_wtGenericIOArchiveMessages_block_WebPatterns_wt33_block_wtText_wtReferenceIdInput"]       ${messageId}
    # Druk op ZOEK knop
    Click Button                    xpath=//*[@value="Zoeken"]
    # Controleer veld {status} na verwerking: Bericht moet Geaccepteerd zijn:
    Element Should Contain          //*[@id="DublinTheme_wt22_block_wtMainContent_Common_wtGenericIOArchiveMessages_block_WebPatterns_wt33_block_wtText_wtBrzRestIOArchiveTable"]/tbody/tr[1]/td[10]/div    ${expected_status}


Upload MDP Bestand
    [Documentation]                 Upload een MDP bestand
    [Arguments]                     ${FileToUpload}
    Go To                           ${env.BASE_URL}/MDP/FileImport.aspx
    Set Selenium Implicit Wait      5
    Choose File                     xpath=//*[@testid="Upload_btn"]      ${FileToUpload}
    Click Button                    xpath=//*[@value="Uploaden"]


    # ###############################################
# Python Library Keywords
# ###############################################

Get Generated CSV File
    [Documentation]                 Generates a file CSV file and returns the message id
    [Arguments]                     ${input_filename}
    ${message_id}=                  FileHandling.Generate_CSV_file     ${input_filename}  ${EXECDIR}${/}CSV Upload${/}
    Log                             ${message_id}
    Return From Keyword             ${message_id}    


# ###############################################
# DB Library Keywords
# ###############################################





