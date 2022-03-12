# Custom Code Calculator
The Custom Code Calculator application calculates the increased custom code (percentage, difference) in your sandbox as compared to production org.

## Why do you need this application?
The maximum amount of code used by all Apex code in an org is 6 MB ( 6,000,000 characters) and Salesforce recommends not using too much code in an org. So companies/customers follow recommendation seriously and whenever a developer propose/implement the solution using apex code, the review team wants to know how much custom code percentage is going to increase due to this implementation and based on that they accept or reject the solution.

Let's check how the developer calculates the custom code percentage?

### Following are the steps :
* First, go to developer sandbox and search for the apex class or trigger in which the developer added the code.
* Copy the “Size Without Comments” column value from there and make a note of that value.
* Now, go to production org and search for the same apex class or trigger.
* Copy the “Size Without Comments” column value from production and take a note of that value.
* Use calculator software, to calculate length difference and custom code percentage increased or decreased.

### ⚠️ Problems in the above steps:
* The above steps/process is a little time-consuming.
* We don’t have a quick search to find apex class or trigger. 
* Need to navigate through long pagination for some cases to find the apex class/trigger "Size Without Comments" value.
* Calculations need to be done manually on calculator software.
* Chance of error in the calculations.

All the above problems you can solve using this application.

## :high_brightness: Features
* Quickly search Apex class or trigger right inside your sandbox org.
* This app tells you the apex class/trigger length in the developer sandbox.
* Get Apex Class/Trigger lenght from production org.
* This calculates the length difference and custom code percentage increased /decreased in just a single click.
* If you have created a new class or trigger, then also it will calculate the custom code percentage for you.
* We can only search for the classes that you have created; it excludes the managed package classes in the search.
* Nice and easy interface developed with a lighting web component.

## :outbox_tray: Deployment
:package: [Click Here](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5j000000giuh) to install the package in the Sandbox instance.

or use the below URL:

:link: https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5j000000giuh

## :hammer_and_wrench: Setup & Configurations
* Create a connected app in your Production org.
* Create an Auth. provider in sandbox instance.
 ![](https://github.com/arun12209/Custom-Code-Calculator/blob/main/Images/Auth_Provider.png)
* Create a Named Credential in sandbox instance.
 ![](https://github.com/arun12209/Custom-Code-Calculator/blob/main/Images/NamedCredentials_setting.png)

## :tv: Demo
![](https://github.com/arun12209/Custom-Code-Calculator/blob/main/Images/CustomCodeCalculatorDemo.png)
![](https://github.com/arun12209/Custom-Code-Calculator/blob/main/Images/ApexClassCalculation.png)
![](https://github.com/arun12209/Custom-Code-Calculator/blob/main/Images/ApexTriggerCalculation.png)

## ✍️ Blog post
:link: https://sfdclesson.com/2022/03/12/apex-custom-code-calculator/

## Authors
* Arun Kumar -[@ArunKur94](https://twitter.com/ArunKur94)


