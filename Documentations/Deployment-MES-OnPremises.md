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
3. Set the script

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

* Use the legacy Agent : This agent will be depreceated in August 2024
* Use Azure Monitor Agent and DCR : Recommanded solution

## Legacy Agent Deployment for Options 1-2-3-4-5-6-7

This section needs to be be executed only once per server.
The agent is used to collect Event log like MSExchange Management, Security logs, IIS log files...
If you plan to collect information: 

* For Options 1-2-5-6-7, the agent needs to be deployed on every Exchange servers
* For Options 3, the agent needs to be deployed on Domains Controllers located in the Exchange AD sites. This option is still in Beta.
* For Options 4, the agent needs to be deployed on ALL Domains Controllers. This option is still in Beta.

### **Download and install the agents needed to collect logs for Microsoft Sentinel**

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

## Azure Monitor Agentand DCR Deployment

### Option 1  -  MS Exchange Management Log collection

Option 1 is necessary for the following Workbooks :

* Microsoft Exchange Admin Activity
* Microsoft Exchange Search AdminAuditLog


All the Exchange Servers with the Agent installed will upload the MSExchange Management log

### Option 2 - Security, Application, System for Exchange Servers



Security logs are only avaialble with the Azure Monitor Agent

### Option 3 - Security for Domain controllers located in the Exchange AD sites


### Option 4 - Security for ALL Domain controllers


### Option 5 - IIS logs for Exchange servers

### Option 6 - Message tracking logs for Exchange Servers

### Option 7 - HTTPProcy logs for Exchange servers

