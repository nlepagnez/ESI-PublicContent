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


![alt text](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Documentations/Images/Image04.png) ℹ️ Service Account with Organization Management role: The service Account that launch the script as scheduled task needs to be Organization Management to be able to retrieve all the needed security Information.