# Deployment Microsoft Exchange Security for Exchange On-Premises

## Install the solution

1. In Microsoft Sentinel
2. Select Content Hub
3. In the search zone, type Microsoft exchange Security
4. Select Microsoft Exchange Security for Exchange On-Premises
5. Click Install
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image01.png "Install Solution")
6. Wait for the end of the installation

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image02.png "Wait")

## Options deployment

Remember, this solution is based on one mandadoty data connector and one optionnal.
All the steps in the section Exchange Security Insights On-Premise Collector are mandatoty.

For the step in the section Microsoft Exchange Logs and Events, you will have to choose which logs you want to ingest.
As we do not want to force you to deploy all the capabilities provided with this solution, we choose to divide them in something we decided to call Options.
After the solution installation, you will be able to choose which data will be ingest in Microsoft Sentinel.
Indeed as some options can generate a very high volume of data, we let you choose which logs will be ingest.
The choice depend on what :

* You want to collect
* What workbook you want to used
* Analytics Rules, Hunting capabilities you want to be able to use
* Hunting capacities you want

Each options are independant for one from the other.

For more information, for other options please refer to the blog or to the readme located here :
<https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/help-protect-your-exchange-environment-with-microsoft-sentinel/ba-p/3872527>
<https://github.com/nlepagnez/ESI-PublicContent/tree/main>

## Configuration of the Mandatory data Connector : Exchange Security Insights On-Premise Collector

The configurations associated with this connector are mandatory and will be used by the following workbooks :

* Microsoft Exchange Security Review
* Microsoft Exchange Least Privilege with RBAC

For details on how to configure this connector, you have two possibilities

1. Go to the Connector Page and follow the steps
2. Follow this documentation

> We strongly recommended to follow this documentation as the information are more often updated and more detailed.

If you choose to use the information provide in the Connector page :

1. Go to Data connectors in the configuration section
2. Select Exchange Security Insights On-Premise Collector
3. Click on Open connector page

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image03.png "Connector Deployment")

### Prerequisites

To integrate with Exchange Security Insights On-Premise Collector make sure you have:

✅ **Workspace:** read and write permissions are required

✅ **Keys:** read permissions to shared keys for the workspace are required. See the documentation to learn more about workspace keys

> The connector page is useful to retrieve the Worspace ID and the Key.

 ℹ️ Service Account with Organization Management role: The service Account that launch the script as scheduled task needs to be Organization Management to be able to retrieve all the needed security Information.

### Configuration

#### Parser deployment

NOTE:  To work as expected, this data connector depends on a parser based on a Kusto Function. **(When standard deployement, Parsers are automatically deployed)**
List of Parsers that will be automatically deployed :

* ExchangeAdminAuditLogs
* ExchangeConfiguration
* ExchangeEnvironmentList
* MESCheckVIP
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image15.png)

> More detailed information on Parsers can be found in the following documentation
[Parser information](/Documentations/ParserInformation.md)

#### Script Deployment

This connector is based on a script that will run on an On-Premises servers (normally an Admin server).

Here the steps to deploy the script on this server.
The script Steip.ps1 will automatically deploy all the required configurations.

##### Download the latest version of ESI Collector

* The latest version can be found here : <https://aka.ms/ESI-ExchangeCollector-Script>
* Choose CollectExchSecIns.zip (This is the latest version of the script)
* This is the script that will collect Exchange Information to push content in Microsoft Sentinel.
* Install the ESI Collector Script on a server with Exchange Admin PowerShell console

##### On the serveur that will run the collect

> *Remember that the server needs to have Exchange PowerShell Cmdlets*

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
      4. Retrieve the **Workspace ID and Primary Key**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image07.png)
   4. Fill all the required information required by the script
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image08.png)
   5. Enter the **name** of your environement the Environment name. This name will be displayed in your workbook. You should choose the name of your Exchange organization.  
   6. By default, choose '**Def'** as Default analysis. 
   7. Choose **OP** for On-Premises
   8. If necessary, update the path for the location of **Exchange BIN path**
   9. Enter the **time when you want** the script to run (format : hh:mmAM or hh:mmPM):
   10. Specify the **account** and its password that will be used to run the script in the Scheduled Task (**Remember this account needs to be part of the Organization Management group**)

Result
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image09.png)


**Schedule the ESI Collector Script**
You need to follow this section only if :
- Not done by the  script because it failed to created to scheduled tasks due to lack of permission 

The script needs to be scheduled to send Exchange configuration to Microsoft Sentinel.
We recommend to schedule the script once a day.
The account used to launch the Script needs to be member of the group **Organization Management**

## Deploy Optional Connector : Microsoft Exchange Logs and Events

## Deploy Connector for Option 1 - 2 - 3 - 4 - 5 

1.	Go to Data connectors in the configuration section
2.	Select Microsoft Exchange Logs and Events
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

##### **Download and install the agents needed to collect logs for Microsoft Sentinel**. **Deploy Monitor Agents**
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

##### Deploy log injestion for Option 1  -  MS Exchange Management Log collection
Select how to stream MS Exchange Admin Audit event logs
###### *Data Collection Rules - When Azure Monitor Agent is used**
Microsoft Exchange Admin Audit Events logs are collected only from Windows agents.
Two options : 
    Option 1 - Azure Resource Manager (ARM) Template
    1. Click the [Deploy to Azure button below](https://portal.azure.com/#create/Microsoft.Template)
    2. Select the preferred Subscription, Resource Group and Location.
    3. Enter the Workspace Name 'and/or Other required fields'.
        1. Mark the checkbox labeled I agree to the terms and conditions stated above.
    4. Click Purchase to deploy
    Option 2 - Manual Deployment of Azure Automation
    Use the following step-by-step instructions to deploy manually a Data Collection Rule
    1. From the Azure Portal, navigate to Azure Data collection rules.
    2. Click + Create at the top.
    3. In the Basics tab, fill the required fields, Select Windows as platform type and give a name to the DCR.
    4. In the Resources tab, enter you Exchange Servers.
    5. In 'Collect and deliver', add a Data Source type 'Windows Event logs' and select 'Custom' option, enter 'MS Exchange Management' as expression and Add it.
    6. 'Make other preferable configuration changes', if needed, then click Create.

**Assign the DCR to all Exchange Servers**
1. Add all your Exchange Servers to the DCR


###### Data Collection Rules - When the legacy Azure Log Analytics Agent is used
Configure the logs to be collected - Configure the Events you want to collect and their severities.
1. Go the **Log Analytics workspace for your Sentinel**
2. Click **Legacy agents management**
3. Select **Windows Event logs**
4. Click **Add Windows event log**
5. Enter **MS Exchange Managemen**t as log name
6. Collect **Error**, **Warning** and **Information** types
7. Click **Apply**
   ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image14.png)

#### Exchange Admin Audits also refer as Option 1
Option 1 is necessary for the Workbook : 
- Microsoft Exchange Admin Activity
- Microsoft Exchange Search AdminAuditLog

This option will upload the log "MSExchange Management" for each Exchange Server in Sentinel.
There are two to deploy this option :
- Using the Legacy Agent :[Agent](https://go.microsoft.com/fwlink/?LinkId=828603. Remember that the Log Analytics agent is on a deprecation path and won't be supported after August 31, 2024)
- Using Azure Monitor Agent using AzureArc.[azure-monitor-agent-migration](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration)