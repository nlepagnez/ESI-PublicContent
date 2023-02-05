# Microsoft Exchange Security - Public Contents and Microsoft Sentinel Solution Readme page

**Exchange Servers** have recently been the target of many attacks. The cases and escalations opened with the ProxyLogon vulnerability published earlier this year have revealed poorly managed environments. Exchange Server security assessments regularly discover many unsecured configurations putting the messaging system at risk of being compromised without much effort. However Exchange Servers are rarely monitored sufficiently from a security perspective and traces and logs often can’t be collected on time when investigations need to be performed.

Introducing **M**icrosoft **E**xchange **S**ecurity Solution

The solution collects and detects sensitive security operations happening on on-premises Exchange Servers using Microsoft Sentinel. This allows service owners and SOC teams to detect attacks targeting Exchange Servers, alert on sensitive administrative operations and report on incorrect RBAC configurations putting the environment at risk. The solution also allows hunters to search a very diverse set of data to find abnormal behaviors. 

## DATA Collection

We build the solution to give you the possibility to collect multiple logs and configurations reports following your needs and the quantity of logs you want to upload to Microsoft Sentinel.

To do that, we create the concept of "Option" with a mandatory root part that give you a visibility of what can be usefull for you.

### Root part - Security Configuration

This part rely on the Exchange Security Insights On-Premises Collector for *On-Premises environments* and Exchange Security Insights Online Collector for *Online environments*.

This root part collects Security configuration, RBAC Information and Mailbox Audit information to create the Security and RBAC Insights in Workbooks.

[Exchange Security Insights On-Premise/Online Collector](ESICollector.md)

### Option 1 - Exchange Admin Audits

This option collects MS Exchange logs (retrieved from the Event Viewer) for every Exchange servers using Azure Monitor Agent or Azure Log Analytics agent on each Exchange Server. This content is used to analyze Admin activities on your On-Premises Exchange environment(s)

