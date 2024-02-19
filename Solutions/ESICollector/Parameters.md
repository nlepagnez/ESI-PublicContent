# ExchSecIns Configuration

Actual Parameter version : 2.5

## Table of Contents

- [ExchSecIns Configuration](#exchsecins-configuration)
  - [Table of Contents](#table-of-contents)
  - [Parameters](#parameters)
    - [Global](#global)
    - [Output](#output)
    - [Advanced](#advanced)
    - [LogCollection](#logcollection)
    - [MGGraphAPIConnection](#mggraphapiconnection)
    - [InstanceConfiguration](#instanceconfiguration)
    - [AuditFunctionsFiles](#auditfunctionsfiles)
    - [AuditFunctionProtectedArea](#auditfunctionprotectedarea)
    - [AuditFunctions](#auditfunctions)
  - [Description](#description)

## Parameters

### Global

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| ParallelTimeoutMinutes | Int | Maximum time in minutes to wait for a parallel job to finish | 5 | False |
| MaxParallelRunningJobs | Int | Maximum number of parallel jobs running at the same time | 8 | False |
| GlobalParallelProcessing | Boolean | Activate the global parallel processing | true | False |
| PerServerParallelProcessing | Boolean | Activate the parallel processing per server | true | False |
| DefaultDurationTracking | Int | Default duration tracking in days | 30 | False |
| ESIProcessingType | String | Type of processing, online or offline | Online | False |
| EnvironmentIdentification | String | Identification of the environment | MyOwnEnvironment | False |

### Output

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| DefaultOutputFile | String | Default output file | C:\ExchSecIns\data\ExchSecIns.csv | False |
| ExportDomainsInformation | Boolean | Export Domain Information in Sentinel Table | True | False |

### Advanced

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| ParralelWaitRunning | Int | Time in seconds to wait for parallel processing | 10 | False |
| ParralelPingWaitRunning | Int | Time in seconds to wait for parallel ping processing | 10 | False |
| OnlyExplicitActivation | Boolean | Only the explicit activation of the functions | false | False |
| ExchangeServerBinPath | String | Path of the Exchange Server Binaries | c:\Program Files\Microsoft\Exchange Server\V15\bin | False |
| BypassServerAvailabilityTest | Boolean | Bypass the server availability test | false | False |
| ExplicitExchangeServerList | Array | List of explicit Exchange servers | [] | False |
| FunctionsListInline | Boolean | Functions list inline | false | False |
| FunctionsListWithoutInternet | Boolean | Functions list without internet | false | False |
| Beta | Boolean | Beta feature | false | False |
| Useproxy | Boolean | Use Proxy | false | False |
| ProxyUrl | String | Proxy URL | http://proxy.dom.net:8080 | False |
| MaximalSentinelPacketSizeMb | Int | Max Packet size for Sentinel in Mb |
| PaginationErrorThreshold | Int | Pagination Error Threshold | 5 | False |
| UpdateVersionCheckingDeactivated | Boolean | Deactivate the version checking | false | False |
| DeactivateUDSLogs | Boolean | Deactivate the log summary | false | False |
| LogVerboseActivated | Boolean | Log Verbose Activated | true | False |
| UDSLogProcessor | Array | UDS Log Processor | [{Activated:true, StorageType:Output}] | False |

### LogCollection

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| ActivateLogUpdloadToSentinel | Boolean | Activate the log upload to Sentinel | true | False |
| WorkspaceId | String | Workspace Id | e15121b8-fc25-4ec2-8d21-44532bfd219a | False |
| WorkspaceKey | String | Workspace Key | WKey | False |
| LogTypeName | String | Log Type Name | ESIExchangeConfig | False |
| TogetherMode | Boolean | Together Mode | false | False |

### MGGraphAPIConnection

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| MGGraphAzureRMCertificate | String | MGGraph Azure RM Certificate | | False |
| MGGraphAzureRMAppId | String | MGGraph Azure RM App Id | | False |

### InstanceConfiguration

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| Default | Object | Default configuration | {All:true, Capabilities:OP\|OL\|MGGRAPH\|ADINFOS} | False |
| IIS-IoCs | Object | IIS IoCs configuration | {All:true, Category:IIS-IoCs, Capabilities:IIS, OutputName:ESIIISIoCs} | False |
| ExchangeOnlineMessageTracking | Object | Exchange Online Message Tracking configuration | {All:true, Category:OnlineMessageTracking, Capabilities:OL, OutputName:ExchangeOnlineMessageTracking} | False |
| InstanceExample | Object | Instance Example configuration | {SelectedAddons:[Filename1, Filename2], FileteredAddons:[Filename1, Filename2]} | False |

### AuditFunctionsFiles

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| Filename | String | Filename | FiletoIgnore | False |
| Deactivated | Boolean | Deactivated | false | False |

### AuditFunctionProtectedArea

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |
| ContentCheckSum | String | Content CheckSum | | False |

### AuditFunctions

| Parameter | Type | Description | Default | Required |
| --- | --- | --- | --- | --- |

## Description

This configuration file is used to configure the CollectExchSecIns script. It contains all the parameters needed to run the script.
