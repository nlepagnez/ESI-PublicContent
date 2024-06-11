# Deployment Microsoft Exchange Security for Exchange On-Premises

## Install the solution
1.	In Microsoft Sentinel
2.	Select Content Hub
3.	In the search zone, type Microsoft exchange Security
4.	Select Microsoft Exchange Security for Exchange On-Premises
5.	Click Install

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image01.png "Install Solution")

6.	Wait for the end of the installation

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image02.png "Wait")


## Deploy Connector

1.	Go to Data connectors in the configuration section
2.	Select Exchange Security Insights On-Premise Collector
3.	Click on Open connector page

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image03.png "Connector Deployment")

### Prerequisites
To integrate with Exchange Security Insights On-Premise Collector make sure you have:

✅ **Workspace:** read and write permissions are required

✅ **Keys:** read permissions to shared keys for the workspace are required. See the documentation to learn more about workspace keys


 ℹ️ Service Account with Organization Management role: The service Account that launch the script as scheduled task needs to be Organization Management to be able to retrieve all the needed security Information.

### Configuration
Parser deployment **(When using Microsoft Exchange Security Solution, Parsers are automatically deployed)**
NOTE: This data connector depends on a parser based on a Kusto Function to work as expected. Follow the steps for each Parser to create the Kusto Functions alias : ExchangeConfiguration and ExchangeEnvironmentList

*Manual Parsers deployment (to review)*
*Section to complete*

#### Script Deployment
Install the ESI Collector Script on a server with Exchange Admin PowerShell console
This is the script that will collect Exchange Information to push content in Microsoft Sentinel.


**Download the latest version of ESI Collector**
The latest version can be found here : https://aka.ms/ESI-ExchangeCollector-Script.
Choose CollectExchSecIns.zip (This is the latest version of the script)

**On the serveur that will run the collect**
*Remember that the server needs to have Exchange PowerShell Cmdlets*
Remember that the 
1. **Copy and unzip** the file CollectExchSecIns.zip
2. **Unblock** the PS1 Scripts
   1. Click right on each PS1 Script and go to Properties tab.
   2. If the script is marked as blocked, unblock it. You can also use the Cmdlet 'Unblock-File . in the unzipped folder using PowerShell
3. **Configure** **Network Access**
   1. Ensure that the script can contact Azure Analytics (*.ods.opinsights.azure.com).
4. Run the **setup.ps1** to configure the ESI Collector Script
   1. Be sure to be **local administrator** of the server
   2. In **'Run as Administrator'** mode, launch the 'setup.ps1' script to configure the collector
   3. **Fill** the Log Analytics (Microsoft Sentinel) Workspace information
      1. To find the **Workspace ID and the Key**, go the **Log Analytics workspace for your Sentinel**
      2. Select **Agents** in the **Settings** section
      3. Extend the **Log Analytics Agent Instruction**s
      4. Retrieve the** Workspace ID and Primary Key**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image07.png)
   1. Enter the **name** of your environement the Environment name. This name will be displayed in your workbook. You should choose the name of your Exchange organization.  
   2. By default, choose '**Def'** as Default analysis. 
   3. Choose **OP** for On-Premises
   4. If necessary, update the path for the location of **Exchange BIN path**
   5. Enter the **time when you want** the script to run (format : hh:mmAM or hh:mmPM):
   6. Specify the **account** and its password that will be used to run the script in the Scheduled Task (**Remember this account needs to be part of the Organization Management group**)
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image08.png)
Result
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image09.png)


**Schedule the ESI Collector Script**
You need to follow this section only if :
- Not done by the  script because it failed to created to scheduled tasks due to lack of permission 

The script needs to be scheduled to send Exchange configuration to Microsoft Sentinel.
We recommend to schedule the script once a day.
The account used to launch the Script needs to be member of the group **Organization Management**
