# Exchange Security Insights Collectors

## On-Premises Collector

### Mandatory Permissions

Organization Management.

  > The collector has to read Active-Directory groups and members, especially "Administrative" groups in 'Microsoft Exchange Security Groups' Organization Units.

  > The collector must be able to contact every Exchange Server in WMI and in Remote PowerShell.

(Normally the Organization Management group allow the above rights excepted if you have brake inheritance in AD or made custom **unsupported** hardening between Exchange Servers.

