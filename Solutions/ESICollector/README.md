# **Exchange Security Insight Collector Download**

## Actual Version : 7.3.2

## Upgrade paths

### From 7.3.2 to 7.4.2

#### **Configuration File**

Parameters added in Advanced Section

#### **ESI Collector Script**

Replace the old script version with the new one. nothing to modifiy in the script.
Attention, now ManagedIdentity is used for Exchange Online instead of RunAs Account.
Assign rights to Managed Identity following Standard Procedure : [EXO for ManagedIdentity](https://learn.microsoft.com/en-us/powershell/exchange/connect-exo-powershell-managed-identity?view=exchange-ps#step-4-grant-the-exchangemanageasapp-api-permission-for-the-managed-identity-to-call-exchange-online)

### From 7.3.1 to 7.3.2

#### **Configuration File**

Parameters added in Advanced Section

#### **ESI Collector Script**

Replace the old script version with the new one. nothing to modifiy in the script.


### From 7.3.0 to 7.3.1

#### **Configuration File**

No changes in Configuration file

#### **ESI Collector Script**

Replace the old script version with the new one. nothing to modifiy in the script.

### From 7.2.0 to 7.3.0

#### **Configuration File**

The only change on the configuration file is adding a "Beta" Property in "Advanced" part. By default "Beta" is "False". If you decide to use Beta off Add-On files, you can switch this parameter to true. Attention, bugs can be present in Beta mode.

#### **ESI Collector Script**

Replace the old script version with the new one. nothing to modifiy in the script.

## Download availability/Rules

Only 2 major versions are kept on the public repository.
The zip file without versioning correspond to the latest version of the Collector.
