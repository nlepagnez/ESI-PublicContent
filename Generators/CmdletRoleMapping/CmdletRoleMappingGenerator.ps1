
function New-RoleMappingEntry
{
    Param(
        $RoleCmdletObject,
        $RoleName
    )

    $TheObject2 = new-Object PSCustomObject
    $TheObject2 | Add-Member -MemberType NoteProperty -Name "Role" -Value $RoleName
    $TheObject2 | Add-Member -MemberType NoteProperty -Name "RoleCMDLet" -Value $RoleCmdletObject.Name
    $TheObject2 | Add-Member -MemberType NoteProperty -Name "Parameters" -Value ($RoleCmdletObject.Parameters -Join ';')

    return $TheObject2
}

$MgmtRoleList = Get-ManagementRole | where {$_.IsRootRole -eq $true}

$RoleCmdletList = @()

foreach($MgmtRole in $MgmtRoleList)
{
    foreach ($RoleEntry in $MgmtRole.RoleEntries)
    {
        $RoleCmdletList += New-RoleMappingEntry -RoleCmdletObject $RoleEntry -RoleName $MgmtRole.Name
    }
}

$OrgVersion = Get-OrganizationConfig | Select-Object RBACConfigurationVersion, AdminDisplayVersion

$RoleCmdletListFilename = "RoleCmdletList-" + $OrgVersion.RBACConfigurationVersion.ExchangeBuild.ToString() + ".csv"

$RoleCmdletList | Export-Csv -Path $RoleCmdletListFilename -NoTypeInformation -Encoding "utf8"

# To be compatible with Watchlist
$CsvFileContent = Get-Content $RoleCmdletListFilename
$CsvFileContent[0] = "Role,RoleCMDLet,Parameters"
$CsvFileContent | Set-Content $RoleCmdletListFilename