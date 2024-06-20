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

**The solution will deploy :**

* Two connectors
  * Exchange Security Insights On-Premise Collector
  * Microsoft Exchange Logs and Events
* 4 Functions also called Parsers
  * ExchangeAdminAuditLogs
  * ExchangeConfiguration
  * ExchangeEnvironmentList
  * MESCheckVIP
* 4 Workbooks template
  * Microsoft Exchange Admin Activity
  * Microsoft Exchange Least Privilege with RBAC
  * Microsoft Exchange Search AdminAuditLog
  * Microsoft Exchange Security Review

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

> We strongly recommended to follow this documentation as the information are more detailed.

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

>NOTE:  To work as expected, this data connector depends on a parser based on a Kusto Function. **(When standard deployement, Parsers are automatically deployed)**
>List of Parsers that will be automatically deployed :

> * ExchangeAdminAuditLogs
> * ExchangeConfiguration
> * ExchangeEnvironmentList
> * MESCheckVIP

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image15.png)

> More detailed information on Parsers can be found in the following documentation
[Parser information](https://github.com/nlepagnez/Azure-Sentinel/blob/master/Solutions/Microsoft%20Exchange%20Security%20-%20Exchange%20On-Premises/Parsers/README.md)

#### Script Deployment

This connector is based on a script that will run on an On-Premises servers (normally an Admin server).

Here the steps to deploy the script on this server.
The script Setup.ps1 will automatically deploy all the required configurations.

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
   5. Enter the **Name** of your environement the Environment name. This name will be displayed in your workbook. You should choose the name of your Exchange organization
      1. **This STEP is Critical**
      2. The name can be String or a combination of String and Number Example :
         1. Contoso
         2. Consoto2024
      3. GUID are not allowed
   6. By default, choose '**Def'** as Default analysis. 
   7. Choose **OP** for On-Premises
   8. If necessary, update the path for the location of **Exchange BIN path**
   9.  Enter the **time when you want** the script to run (format : hh:mmAM or hh:mmPM):
   10. Specify the **account** and its password that will be used to run the script in the Scheduled Task (**Remember this account needs to be part of the Organization Management group**)

**Here the scheduled task, after the script completion**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image09.png)

**Schedule the ESI Collector Script**
You need to follow this section only if the script failed due to lack of permission
Steps :

1. Create a Scheluled task
2. Specify the account

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image17.png)

3. Set the schedule

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image18.png)

4. Set the script

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image19.png)

The account used to launch the Script needs to be member of the group **Organization Management**

##### Find the information configured by the scripts

The script will create the Scheluded tasks and fill a configuration file named **CollectExchSecConfiguration.json** with all the provided information.
This file can be found in the **Config** folder. This folder is located in the folder where you unzip the zip.

## Deploy Optional Connector : Microsoft Exchange Logs and Events

This connector is used to collect additionals logs :

* MS Exchange Management logs from the Event Viewer : Also called Option 1
* Security, Application, System for Exchange Servers : Also called Option 2
* Security for Domain controllers located in the Exchange AD sites : Also called Option 3
* Security for ALL Domain controllers : Also called Option 4
* IIS logs for Exchange servers : Also called Option 5
* Message tracking logs for Exchange Servers : Also called Option 6
* HTTPProxy logs for Exchange servers : Also called Option 7

## Configuration of the optional Data Connector : Microsoft Exchange Logs and Events

For details on how to configure this connector, you have two possibilities

1. Go to the Connector Page and follow the steps
2. Follow this documentation

> We strongly recommended to follow this documentation as the information are more detailed.

If you choose to use the information provide in the Connector page :

1. Go to **Data connectors** in the configuration section
2. Select **Exchange Security Insights On-Premise Collector**
3. Click on **Open connector page**

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image10.png "Connector Deployment")

## Prerequisites

To integrate with Exchange Security Insights On-Premise Collector make sure you have:

✅ **Workspace:** read and write permissions are required

✅ **Keys:** read permissions to shared keys for the workspace are required. See the documentation to learn more about workspace keys

> The connector page is useful to retrieve the Worspace ID and the Key.

## Parser deployment

> Note :  To work as expected, this data connector depends on a parser based on a Kusto Function. **(When standard deployement, Parsers are automatically deployed)**
List of Parsers that will be automatically deployed :
> * ExchangeAdminAuditLogs
> * ExchangeConfiguration
> * ExchangeEnvironmentList
> * MESCheckVIP

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image15.png)

> More detailed information on Parsers can be found in the following documentation
[Parser information](https://github.com/nlepagnez/Azure-Sentinel/blob/master/Solutions/Microsoft%20Exchange%20Security%20-%20Exchange%20On-Premises/Parsers/README.md)

## Deployment considerations

To ingest the events logs or log files, you have two options :

* Use Azure Monitor Agent and DCR : Recommanded solution
* Use the legacy Agent : This agent will be depreceated in August 2024

## Azure Arc-enabled servers, Azure Monitor Agent and DCR Deployment

The deployment is in 3 steps :

1. Deployment of Azure Arc-enabled servers
2. Deployment of Azure Monitor Agent
3. DCR configurations : These step will be detailed in each Option sections

### Agents Deployment
The reference document is : [Manage Azure Monitor Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-powershell#virtual-machine-extension-details)

The following steps are just a summaru, please review closely the documentation or your internal document for Azure Arc deployment.

#### Deployment of the Azure Arc-enabled servers

To install the Azure Arc-enabled servers :

* On Azure VM : Follow this article : [Click Here](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-portal&WT.mc_id=Portal-fx)
* On physical servers and virtual machines hosted outside of Azure : 

  * Here an overview of available deployment method [Click Here](https://learn.microsoft.com/en-us/azure/azure-arc/servers/deployment-options)
    * [Preferred Method](https://learn.microsoft.com/en-us/azure/azure-arc/servers/onboard-portal)

After the Deployment, the servers can be found in **Azure Arc/Azure Arc resources/Machines**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image28.png)
These steps needs to be done on all servers.

####  Deployment Azure Monitor Agent
On the server where Azure Arc-enabled servers has been installed:
1. Open a Powershell
2. Enter the following command 
```powershell
   New-AzConnectedMachineExtension -Name AzureMonitorWindowsAgent -ExtensionType AzureMonitorWindowsAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName <resource-group-name> -MachineName <arc-server-name> -Location <arc-server-location> -EnableAutomaticUpgrade
```
After the Deployment, the extension can be view **Azure Arc/Azure Arc resources/Machines**, click on the **Machine Name** and go to **Settings/Extension**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image29.png)

These steps needs to be done on all servers.

### Option 1  -  MS Exchange Management Log collection

Option 1 is necessary for the following Workbooks :

* Microsoft Exchange Admin Activity
* Microsoft Exchange Search AdminAuditLog

#### DCR Creation
All the Exchange Servers with the DCR deployed will upload the MSExchange Management log.
There are 2 methods to deploy the DCR :

1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR
   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 1] MS Exchange Management Log collection / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**
   3. Click on **Deploy to Azure**
   4. Select the preferred **Subscription**, **Resource Group**, **Region**
   5. Enter **Workspace Name**

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image30.png)
   6. Click **Next** and **Create**

2. Method 2 - Manual Deployment of Azure DCR

   1. From the **Azure Portal**, navigate to **Azure Data collection rules**
   2. Click **+ Create** at the top
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image31.png)
   3. In the Basics tab, fill the required fields, Select Windows as platform type and give a name to the DCR
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image32.png)
   4. In the **Resources** tab, click **+ Add Resources** and select  your **Exchange Servers**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image33.png)
   5. In **'Collect and deliver'**, add a Data Source type 'Windows Event logs' and select 'Custom' option, enter '**MS Exchange Management**' as expression and Add it
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image34.png)
   6. Click **Add data source** and click **Next Destination**
   7. In destination Type select **Azure Monitor Logs** and in **Desitnation Details** select the appropriate **Sentinel workspace**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image35.png)
   8. and Click **Review + Create**
   9. Click **Create**

#### Assign DCR to all Exchange servers
1. From the **Azure Portal**, navigate to **Azure Data collection rules**
2. Select the DCR
3. Click **Settings / Resources**
4. Select all Exchange Servers


### Option 2 - Security, Application, System for Exchange Servers

#### Security logs
1. Go the **Microsoft Exchange Logs and Events** data connector Page
2. Extend the section **[Option 2] Security/Application/System logs of Exchange Servers / Security Event Log collection / Data Collection Rules- Security Logs
3. Click Create Data collection Rule
4. In **Basic** tabs, enter a **name** for the DCR

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image36.png)
5. Click **Resources** tab, click **+Add ressource(s)**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image36.png)
6. Add the Exchange Servers
7. Click **Next : Collect**
8. In **Collect** tab, **Common** level is the minimum required. Please select **Common** or **All Security Events**
9. Click **Review + Create**

#### Application and System Event logs
1. Go the **Microsoft Exchange Logs and Events** data connector Page
2. Extend the section **[Option 2] Security/Application/System logs of Exchange Servers / Security Event Log collection / Data Collection Rules- Security Logs

There are 2 methods to deploy the DCR :

1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR
   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 2] Security/Application/System logs of Exchange Servers / Application and System Event log collection / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**
   3. Click on Deploy to Azure
   4. Select the preferred **Subscription**, **Resource Group**, **Region**
   5. Enter **Workspace Name**

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image30.png)
   6. Click **Next** and **Create**

2. Method 2 - Manual Deployment of Azure DCR

   1. From the **Azure Portal**, navigate to **Azure Data collection rules**
   2. Click **+ Create** at the top
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image31.png)
   3. In the Basics tab, fill the required fields, Select Windows as platform type and give a name to the DCR
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image32.png)
   4. In the **Resources** tab, click **+ Add Resources** and select  your **Exchange Servers**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image33.png)
   5. In **'Collect and deliver'**, add a Data Source type '**Windows Event logs**' and select **Basic** option
   6. For **Application**, select **Critical**, **Error** and **Warning**. For **System**, select **Critical/Error/Warning/Information**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image40.png)
   1. Click **Add data source** and click **Next Destination**
   2. In destination Type select **Azure Monitor Logs** and in **Desitnation Details** select the appropriate **Sentinel workspace**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image35.png)
   1. and Click **Review + Create**
   2. Click **Create**

#### Assign DCR to all Exchange servers
1. From the **Azure Portal**, navigate to **Azure Data collection rules**
2. Select the DCR
3. Click **Settings / Resources**
4. Select all Exchange Servers

### Option 3 - Security for Domain controllers located in the Exchange AD sites


### Option 4 - Security for ALL Domain controllers


### Option 5 - IIS logs for Exchange servers
#### DCE Creation
This option required a DCE (Data connection Endpoint).
**This step needs do be only one time, for other DCR, you'll select this DCE.**
There are 2 methods to deploy the DCE :


1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR

   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 5] IIS logs of Exchange Servers / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**/**Create DCE (If not already created for Exchange Servers)**
   3. Click on **Deploy to Azure**
   4. Select the preferred **Subscription**, **Resource Group**, **Region**

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image31.png)
   1. Click **Next** and **Create**

1. Method 2 - Manual Deployment of Azure DCR

   1. From the **Azure Portal**, navigate to **Azure Data collection Endpoint**
   2. Click **+ Create** at the top
   3. In the Basics tab, fill the required fields, Select Windows as platform type and give a name to the DCR
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image42.png)
   1. and Click **Review + Create**
   2. Click **Create**

#### DCR Creation
1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR
   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 5] IIS logs of Exchange Servers / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**/**Create DCR (If not already created for Exchange Servers)**
   3. Click on **Deploy to Azure**
   4. Select the preferred **Subscription**, **Resource Group**, **Region**
   5. Enter **Workspace Name**
   6. Enter the **DCE Name** created in the previous steps

2. Method 2 - Manual Deployment of Azure DCR

   1. From the **Azure Portal**, navigate to **Azure Data collection rules**
   2. Click **+ Create** at the top
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image43.png)
   1. In the Basics tab, fill the required fields, Select Windows as platform type and give a name to the DCR
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image32.png)
   1. In the **Resources** tab, click **+ Add Resources** and select  your **Exchange Servers**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image33.png)
   1. In **'Collect and deliver'**, add a Data Source select IIS logs
   2. If IIS logs are not located in their default location, change the path
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image44.png)
   1. Click **Add data source** and click **Next Destination**
   2. In destination Type select **Azure Monitor Logs** and in **Desitnation Details** select the appropriate **Sentinel workspace**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image35.png)
   1. and Click **Review + Create**
   2. Click **Create**

#### Assign DCR to all Exchange servers
1. From the **Azure Portal**, navigate to **Azure Data collection rules**
2. Select the DCR
3. Click **Settings / Resources**
4. Select all Exchange Servers


### Option 6 - Message tracking logs for Exchange Servers

#### DCE Creation
This option required a DCE (Data connection Endpoint).
**This step needs do be only one time, for other DCR, you'll select this DCE.**
There are 2 methods to deploy the DCE :


1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR

   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 6] Message Tracking of Exchange Servers / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**/**Create DCE (If not already created for Exchange Servers)**
   3. Click on **Deploy to Azure**
   4. Select the preferred **Subscription**, **Resource Group**, **Region**

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image31.png)
   1. Click **Next** and **Create**

1. Method 2 - Manual Deployment of Azure DCE

   1. From the **Azure Portal**, navigate to **Azure Data collection Endpoint**
   2. Click **+ Create** at the top
   3. In the Basics tab, fill the required fields, Select Windows as platform type and give a name to the DCR
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image42.png)
   1. and Click **Review + Create**
   2. Click **Create**


#### DCR Creation
1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR
   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 6] Message Tracking of Exchange Servers / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**/**Create DCR (If not already created for Exchange Servers)**
   3. Click on **Deploy to Azure**
   4. Select the preferred **Subscription**, **Resource Group**, **Region**
   5. Enter **Workspace Name**
   6. Enter the **DCE Name** created in the previous steps

2. Method 2 - Manual Deployment of Azure DCR

   1. Download the Example file from [Microsoft Sentinel GitHub](https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Sample%20Data/Custom/ESI-MessageTrackingLogs.json)
   2. From the Azure Portal, navigate to Workspace Analytics and select your target Workspace
   3. Click in **Tables**, click **+ Create** at the top and select New **Custom log (DCR-Based)**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image46.png)
   4. In the Basics tab, enter **MessageTrackingLog** on the Table name
   5. Click **Create new data collection** rule and Enter the name of the rule **DCR-Option6-MessageTrackingLogs**
   6. In the Schema and Transformation tab, choose the downloaded sample file
   7. Upload the file that was download in step 1 
   8. Click on **Transformation Editor**
   9. In the **transformation field**, enter the following KQL request : 
```powershell
source | extend TimeGenerated = todatetime(['date-time']) | extend clientHostname = ['client-hostname'], clientIP = ['client-ip'], connectorId = ['connector-id'], customData = ['custom-data'], eventId = ['event-id'], internalMessageId = ['internal-message-id'], logId = ['log-id'], messageId = ['message-id'], messageInfo = ['message-info'], messageSubject = ['message-subject'], networkMessageId = ['network-message-id'], originalClientIp = ['original-client-ip'], originalServerIp = ['original-server-ip'], recipientAddress= ['recipient-address'], recipientCount= ['recipient-count'], recipientStatus= ['recipient-status'], relatedRecipientAddress= ['related-recipient-address'], returnPath= ['return-path'], senderAddress= ['sender-address'], senderHostname= ['server-hostname'], serverIp= ['server-ip'], sourceContext= ['source-context'], schemaVersion=['schema-version'], messageTrackingTenantId = ['tenant-id'], totalBytes = ['total-bytes'], transportTrafficType = ['transport-traffic-type'] | project-away ['client-ip'], ['client-hostname'], ['connector-id'], ['custom-data'], ['date-time'], ['event-id'], ['internal-message-id'], ['log-id'], ['message-id'], ['message-info'], ['message-subject'], ['network-message-id'], ['original-client-ip'], ['original-server-ip'], ['recipient-address'], ['recipient-count'], ['recipient-status'], ['related-recipient-address'], ['return-path'], ['sender-address'], ['server-hostname'], ['server-ip'], ['source-context'], ['schema-version'], ['tenant-id'], ['total-bytes'], ['transport-traffic-type']
```
   1. Click **Run** and after **Apply**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image47.png)
1.  Click **Next**, then click **Create**
2.  From the Azure Portal, navigate to **Azure Data collection rules**.
3.  Select the previously created DCR, like **DCR-Option6-MessageTrackingLogs**.
4.  In the **Resources** tab, enter you **Exchange Servers**.
5.  In **Data Sources,** add a Data Source type **Custom Text logs** and enter **'C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\Logs\MessageTracking*.log'** in file pattern, **'MessageTrackingLog_CL'** in Table Name. 
6.  In Transform field, enter the following KQL request : 
```powershell
source | extend TimeGenerated = todatetime(['date-time']) | extend clientHostname = ['client-hostname'], clientIP = ['client-ip'], connectorId = ['connector-id'], customData = ['custom-data'], eventId = ['event-id'], internalMessageId = ['internal-message-id'], logId = ['log-id'], messageId = ['message-id'], messageInfo = ['message-info'], messageSubject = ['message-subject'], networkMessageId = ['network-message-id'], originalClientIp = ['original-client-ip'], originalServerIp = ['original-server-ip'], recipientAddress= ['recipient-address'], recipientCount= ['recipient-count'], recipientStatus= ['recipient-status'], relatedRecipientAddress= ['related-recipient-address'], returnPath= ['return-path'], senderAddress= ['sender-address'], senderHostname= ['server-hostname'], serverIp= ['server-ip'], sourceContext= ['source-context'], schemaVersion=['schema-version'], messageTrackingTenantId = ['tenant-id'], totalBytes = ['total-bytes'], transportTrafficType = ['transport-traffic-type'] | project-away ['client-ip'], ['client-hostname'], ['connector-id'], ['custom-data'], ['date-time'], ['event-id'], ['internal-message-id'], ['log-id'], ['message-id'], ['message-info'], ['message-subject'], ['network-message-id'], ['original-client-ip'], ['original-server-ip'], ['recipient-address'], ['recipient-count'], ['recipient-status'], ['related-recipient-address'], ['return-path'], ['sender-address'], ['server-hostname'], ['server-ip'], ['source-context'], ['schema-version'], ['tenant-id'], ['total-bytes'], ['transport-traffic-type']
```
7. Click on **Add data source**.

#### Assign DCR to all Exchange servers
1. From the **Azure Portal**, navigate to **Azure Data collection rules**
2. Select the DCR
3. Click **Settings / Resources**
4. Select all Exchange Servers

### Option 7 - HTTPProxy logs for Exchange servers
#### DCE Creation
This option required a DCE (Data connection Endpoint).
**This step needs do be only one time, for other DCR, you'll select this DCE.**
There are 2 methods to deploy the DCE :
1. Method 1 - Azure Resource Manager (ARM) Template. Use this method for automated deployment of the DCR

   1. Go the **Microsoft Exchange Logs and Events** data connector Page
   2. Extend the section **[Option 7] HTTP Proxy of Exchange Servers / Data Collection Rules - When Azure Monitor Agent is used / Option 1 - Azure Resource Manager (ARM) Template**/**Create DCE (If not already created for Exchange Servers)**
   3. Click on **Deploy to Azure**
   4. Select the preferred **Subscription**, **Resource Group**, **Region**

![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image31.png)
   1. Click **Next** and **Create**

2. Method 2 - Manual Deployment of Azure DCR

   1. Download the Example file from [Microsoft Sentinel GitHub](https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Sample%20Data/Custom/ESI-MessageTrackingLogs.json)
   2. From the Azure Portal, navigate to Workspace Analytics and select your target Workspace
   3. Click in **Tables**, click **+ Create** at the top and select New **Custom log (DCR-Based)**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image46.png)
   4. In the Basics tab, enter **ExchangeHttpProxy ** on the Table name
   5. Click **Create new data collection** rule and Enter the name of the rule **DCR-Option6-MessageTrackingLogs**
   6. Click **Create new data collection** rule and Enter the name **ExchangeHttpProxy** of the rule **DCR-Option7-HTTPProxyLogss**
   5. In the Schema and Transformation tab, choose the downloaded sample file
   6. Upload the file that was download in step 1 
   7. Click on **Transformation Editor**
   8. In the **transformation field**, enter the following KQL request : 
```powershell
source | extend TimeGenerated = todatetime(DateTime) | project-away DateTime
```
   9. Click **Run** and after **Apply**
![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image47.png)
10. Click **Next**, then click **Create**
11. From the Azure Portal, navigate to **Azure Data collection rules**.
12. Select the previously created DCR, like **DCR-Option7-HTTPProxyLogs**.
13. In the **Resources** tab, enter you **Exchange Servers**.
14. In **Data Sources,** add a Data Source type **Custom Text logs** and enter **C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Autodiscover*.log** in file pattern, **ExchangeHttpProxy_CL** in Table Name. 
15. In Transform field, enter the following KQL request : 
```powershell
source | extend TimeGenerated = todatetime(DateTime) | project-away DateTime
```


#### Assign DCR to all Exchange servers
1. From the **Azure Portal**, navigate to **Azure Data collection rules**
2. Select the DCR
3. Click **Settings / Resources**
4. Select all Exchange Servers

--------------------------------

## Legacy Agent Deployment for Options 1-2-3-4-5-6-7

The agent is used to collect Event log like MSExchange Management, Security logs, IIS log files...
If you plan to collect information: 

* For Options 1-2-5-6-7, the agent needs to be deployed on every Exchange servers
* For Options 3, the agent needs to be deployed on Domains Controllers located in the Exchange AD sites. This option is still in Beta.
* For Options 4, the agent needs to be deployed on ALL Domains Controllers. This option is still in Beta.

### **Download and install the agents needed to collect logs for Microsoft Sentinel**

This section needs to be be executed only once per server.

1. This step is required only if it's the first time you onboard your Exchange Servers/Domain Controllers
2. Install Azure Log Analytics Agent (Deprecated on 31/08/2024)
    [Download the Azure Log Analytics Agent and choose the deployment method in the below link](https://go.microsoft.com/fwlink/?LinkId=828603)
   1. Or go the **Log Analytics workspace for your Sentinel**
   2. Select **Agents** in the **Settings** section
   3. Extend the **Log Analytics Agent Instructions**
   4. Click on **Download Windows Agent (64 bit)**
   ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image11.png)

### Option 1  -  MS Exchange Management Log collection

Option 1 is necessary for the following Workbooks :

* Microsoft Exchange Admin Activity
* Microsoft Exchange Search AdminAuditLog

Configure the logs to be collected - Configure the Events you want to collect and their severities.

1. Go the **Log Analytics workspace for your Sentinel**
2. Click **Legacy agents management**
3. Select **Windows Event logs**
4. Click **Add Windows event log**
5. Enter **MS Exchange Management** as log name
6. Collect **Error**, **Warning** and **Information** types
7. Click **Apply**
   ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image14.png)

All the Exchange Servers with the Agent installed will upload the MSExchange Management log

### Option 2 - Security, Application, System for Exchange Servers

Configure the logs to be collected - Configure the Events you want to collect and their severities.

1. Go the **Log Analytics workspace for your Sentinel**
2. Click **Legacy agents management**
3. Select **Windows Event logs**
4. Click **Add Windows event log**
5. Enter **System** as log name
6. Collect **Error**, **Warning** and **Information** types
7. Enter **Application** as log name
8. Collect **Error**and  **Warning** types
9. Click **Apply**

Security logs are only avaialble with the Azure Monitor Agent

### Option 3 - Security for Domain controllers located in the Exchange AD sites

Only avaialble with the Azure Monitor Agent

### Option 4 - Security for ALL Domain controllers

Only avaialble with the Azure Monitor Agent

### Option 5 - IIS logs for Exchange servers

1. Go the **Log Analytics workspace for your Sentinel**
2. Click **Legacy agents management**
3. Select **IIS logs**
4. Ckeck **Collect W3C format IIS log files**

> Remember that depending on the number of Exchange servers and their activities, this configuration can lead to the ingestion of a huge amount af data

### Option 6 - Message tracking logs for Exchange Servers

1. Go the **Log Analytics workspace for your Sentinel**
2. Select **Tables**, click **+ Create** and click on **New custom log (MMA-Based)**
  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image21.png)

3. Go to the folder enter the path **C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\Logs\MessageTracking**. Select **any Message Tracking log file**, click **Open** and click **Next**
  
  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image22.png)
4. In **Record Delimeter**, ensure that **New line** is selected and click **Next**
5. Select type **Windows** and enter the path **C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\Logs\MessageTracking\*.log**. Click **Next**
 
  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image23.png)
1. Enter **MessageTrackingLog** In **Custom log name** and click **Next**.

  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image23.png)
1. Click **Create**

### Option 7 - HTTPProxy logs for Exchange servers

1. Go the **Log Analytics workspace for your Sentinel**
2. Select **Tables**, click **+ Create** and click on **New custom log (MMA-Based)**
  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image21.png)

3. To provide a sample, go to the folder enter the path **C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Mapi**. Select **any log file**, click **Open** and click **Next**
  
  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image25.png)
4. In **Record Delimeter**, ensure that **New line** is selected and click **Next**
5. Select type **Windows** and enter the following path and Click **Next**

   1. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Autodiscover*.log
   2. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Eas*.log
   3. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Ecp*.log
   4. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Ews*.log
   5. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Mapi*.log
   6. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Oab*.log
   7. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Owa*.log
   8. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\OwaCalendar*.log
   9. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\PowerShell*.log
   10. C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\RpcHttp*.log
 
  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image26.png)
1. Enter **ExchangeHttpProxy** In **Custom log name** and click **Next**.

  ![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image27.png)
1. Click **Create**