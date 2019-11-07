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