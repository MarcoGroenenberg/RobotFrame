*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary


*** Test Cases ***
MyFirstLogin
    Log     hello world...
FirstSeleniumTest
    Open Browser    https://google.com    chrome
    Set Browser Implicit Wait    5
    Input Text        name=q    Synobsys 
    Press keys        name=q    ENTER    
    # Click Button        name=btnK 
    Sleep    2
    Close Browser
    Log    Test Completed
    
Sample_loginTest
    [documentation]          This is a sample login test
       Open browser          ${URL}    chrome
       Set Browser Implicit Wait    10
       Input Text            id=txtUsername    @{CREDENTIALS}[0]    
       Input Password        id=txtPassword    &{LOGINDATA}[password]
       click button          id=btnLogin
       Set Window Size                              1600    900
       sleep                                        5
       click element         id=welcome
       # click link            href=https://opensource-demo.orangehrmlive.com/index.php/dashboard#
       click element         id=aboutDisplayLink
       Capture Page Screenshot
       click element         link=Logout
       Close Browser
       Log                   Test Completed
       Log                    This test was executed by %{username} on %{os}
       
*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/ 
@{CREDENTIALS}    Admin    admin123
&{LOGINDATA}    username=Admin    password=admin123



