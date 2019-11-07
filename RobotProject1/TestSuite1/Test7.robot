*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary


Default Tags    sanity


*** Test Cases ***
MyFirstTest
    [Tags]    Smoke
    Log     hello world...
    
MySecondTest
    Log     I am inside 2nd test
    Set Tags    regression 1
    
MyThirdTest
    Log     I am inside 3th test
    
MyFourthTest
    Log     I am inside 4th test


# FirstSeleniumTest
    # Open Browser    https://google.com    chrome
    # Set Browser Implicit Wait    5
    # Input Text        name=q    Synobsys 
    # Press keys        name=q    ENTER    
    # # Click Button        name=btnK 
    # Sleep    2
    # Close Browser
    # Log    Test Completed
    
# Sample_loginTest
    # [documentation]          This is a sample login test
       # Open browser          ${URL}    chrome
       # Set Browser Implicit Wait    10
       # LoginKW
       # Set Window Size                              1600    900
       # sleep                                        5
       # click element         id=welcome
       # # click link            href=https://opensource-demo.orangehrmlive.com/index.php/dashboard#
       # click element         id=aboutDisplayLink
       # Capture Page Screenshot
       # click element         link=Logout
       # Close Browser
       # Log                   Test Completed
       # Log                    This test was executed by %{username} on
       
# *** Variables ***
# ${URL}    https://opensource-demo.orangehrmlive.com/ 
# @{CREDENTIALS}    Admin    admin123
# &{LOGINDATA}    username=Admin    password=admin123


# *** Keywords ***
# LoginKW
       # Input Text            id=txtUsername    @{CREDENTIALS}[0]    
       # Input Password        id=txtPassword    &{LOGINDATA}[password]
       # click button          id=btnLogin

