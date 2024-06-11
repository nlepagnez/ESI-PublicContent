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

#### Options deployment
Remember, this solution is based on options. This allows you to choose which data will be ingest as some options can generate a very high volume of data. Depending on what you want to collect, track in your Workbooks, Analytics Rules, Hunting capabilities you will choose the option(s) you will deploy. 
Each options are independant for one from the other. To learn more about each option: 'Microsoft Exchange Security' wiki
As we do not want to force you to deploy all the capabilities provided with this solution, we choose to divide them in something we decided to call Options.
All Options are **optional** except for the Option 0.
The Option 0 refer to the script that collect Security information in your Exchange Organization and download the Result in Sentinel.
For more information, for other options please refer to the blog or to the readme located here :
https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/help-protect-your-exchange-environment-with-microsoft-sentinel/ba-p/3872527
https://github.com/nlepagnez/ESI-PublicContent/tree/main


## Deploy Connector for Option 0

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
#### Parser deployment 
**(When using Microsoft Exchange Security Solution, Parsers are automatically deployed)**
NOTE: This data connector depends on a parser based on a Kusto Function to work as expected. Follow the steps for each Parser to create the Kusto Functions alias : ExchangeConfiguration and ExchangeEnvironmentList

*Manual Parsers deployment (to review)*
*Section to complete*


#### Script Deployment
Option 0 is necessary for the Workbook : 
- Microsoft Exchange Security Review
- Microsoft Exchange Least Privilege with RBAC


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
      3. Extend the **Log Analytics Agent Instructions**
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

#### Exchange Admin Audits also refer as Option 1
Option 1 is necessary for the Workbook : 
- Microsoft Exchange Admin Activity
- Microsoft Exchange Search AdminAuditLog

This option will upload the log "MSExchange Management" for each Exchange Server in Sentinel.
There are two to deploy this option :
- Using the Legacy Agent :[Agent](https://go.microsoft.com/fwlink/?LinkId=828603. Remember that the Log Analytics agent is on a deprecation path and won't be supported after August 31, 2024)
- Using Azure Monitor Agent using AzureArc.[azure-monitor-agent-migration](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration)

## Deploy Connector for Option 1 - 2 - 3 - 4 - 5 - 

1.	Go to Data connectors in the configuration section
2.	Select Exchange Security Insights On-Premise Collector
3.	Click on Open connector page
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image10.png "Connector Deployment")

### Prerequisites
To integrate with Exchange Security Insights On-Premise Collector make sure you have:

✅ **Workspace:** read and write permissions are required

✅ **Keys:** read permissions to shared keys for the workspace are required. See the documentation to learn more about workspace keys


 ℹ️ Service Account with Organization Management role: The service Account that launch the script as scheduled task needs to be Organization Management to be able to retrieve all the needed security Information.

### Configuration

#### Parser deployment 
**(When using Microsoft Exchange Security Solution, Parsers are automatically deployed)**
NOTE: This data connector depends on a parser based on a Kusto Function to work as expected. Follow the steps for each Parser to create the Kusto Functions alias : ExchangeAdminAuditLogs and ExchangeEnvironmentList

*Manual Parsers deployment (to review)*
*Section to complete*


#### Agent Deployment
This section needs to be be executed only once per server.
The agent is used to collect Event log like MSExchange Management, Security logs...
If you plan to collect information 
- Only on Exchange servers for Options 1-2-5-6-7, the agent needs to be deployed on Exchange servers
- For Options 3-4, the agent needs to be deployed on Exchange servers. These options are still on Beta.

1. **Download and install the agents needed to collect logs for Microsoft Sentinel**. **Deploy Monitor Agents**
   1. This step is required only if it's the first time you onboard your Exchange Servers/Domain Controllers
   2. Select which agent you want to install in your servers to collect logs:
        1.[Prefered] Azure Monitor Agent via Azure Arc. Deploy the Azure Arc Agent
           [Manage Azure Monitor Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-portal&WT.mc_id=Portal-fx)
        2. Install Azure Log Analytics Agent (Deprecated on 31/08/2024)
           [Download the Azure Log Analytics Agent and choose the deployment method in the below link](https://go.microsoft.com/fwlink/?LinkId=828603)
           1. Or go the **Log Analytics workspace for your Sentinel**
           2. Select **Agents** in the **Settings** section
           3. Extend the **Log Analytics Agent Instructions**
           4. Clickclick on Download Windows Agent (64 bit)
            ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image11.png)



