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
       Open browser          https://opensource-demo.orangehrmlive.com/    chrome
       Set Browser Implicit Wait    10
       Input Text            id=txtUsername    Admin     
       Input Password        id=txtPassword    admin123
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