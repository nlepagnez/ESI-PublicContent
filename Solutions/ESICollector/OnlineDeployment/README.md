# Microsoft Exchange Security for Exchange Online - ESI Collector

The ESI Collector is a PowerShell script that collects security-related data from Exchange Online and sends it to a Log Analytics workspace. The script is designed to be run as a scheduled task and can be configured to collect data at different intervals.

> **Note:** You need to update the ESI Collector script to the latest version to get the latest features and bug fixes. The ESI Collector script can be updated manually or using the ESI Collector Updater. Details can be found in the [Update.md](Update.md) file.

## Azure Automation Deployment

The ESI Collector can be deployed to Azure Automation using the provided ARM template. The template will create an Automation account, a Log Analytics workspace, and a runbook that will run the ESI Collector script.

### Deployment Steps

1. Click the "Deploy to Azure" button below to start the deployment process.
2. Fill in the required parameters and click "Review + create".
3. Review the details and click "Create" to start the deployment.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://aka.ms/sentinel-ESI-ExchangeCollector-azuredeploy)

> To manually deploy the ESI Collector, see the Data connector documentation Microsoft Sentinel.

### Permissions

After the deployment is complete, you will need to configure the ESI Collector to collect data from your Exchange Online environment. Multiple permissions are required to collect the data.

The ESI Collector runs in the context of a Managed Identity. The Managed Identity needs to have the following permissions:

1. Exchange Online ManageAsApp permission
2. User.Read.All on Microsoft Graph API
3. Group.Read.All on Microsoft Graph API
4. Global Reader on Entra ID to be able to access to Exchange Online Configuration