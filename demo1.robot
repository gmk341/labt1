*** Settings ***
Library  SeleniumLibrary
*** Test Cases ***
Test grade
  ${score}   Set Variable  80
  ${grade}=  Set Variable  F
  IF  ${score} >= 90
    ${grade}  Set Variable  A
    Log To Console  ${score} = ${grade}
  ELSE IF  ${score} >= 80
    ${grade}  Set Variable  BB
    Log To Console  ${score} = ${grade}
  ELSE IF  ${score} >= 70
    ${grade}  Set Variable  C
    Log To Console  ${score} = ${grade}
  ELSE IF  ${score} >= 60
    ${grade}  Set Variable  D
    Log To Console  ${score} = ${grade}
  ELSE
    ${grade}  Set Variable  F
    Log To Console  ${score} = ${grade}
  END
# robot -d report_demo3    demo3.robot
