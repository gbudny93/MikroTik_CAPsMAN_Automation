# MikroTik_CAPsMAN_Automation
> MikroTik CAPsMAN Automation contains RouterOS scripts and function that all together gives you a complex CAPsMAN Automation: simple sync mechanism, reporting, moniroring as well automation of administrative tasks. This repository may use some scripts from :link: [RouterOS_Useful_Scripts](https://github.com/gbudny93/RouterOS_Useful_Scripts).

![](https://img.shields.io/badge/scripting-routeros-important.svg)
![](https://img.shields.io/badge/mikrotik-routerBOARD-yellow)
![](https://img.shields.io/badge/network-automation-informational)
![](https://img.shields.io/badge/mikrotik-capsman-yellow)

## Change log
    
   - 10/17/2019 update code fixes
        - CAPsMAN_Auto_SSID_Pass_Change.rsc
        - CAPsMAN_Package_Auto_Download.rsc

   - 8/4/2019 first release
    -   CAPsMAN General Automation 
        -   CAPsMAN_CAP_Package_Auto_Download.rsc
        -   CAPsMAN_CAP_Package_Auto_Install.rsc
    -   CAPsMAN Automated Sync 
        -   CAPsMAN_Interfaces_Count.rsc
        -   CAPsMAN_Interfaces_Import.rsc
        -   CAPsMAN_Interfaces_Remove.rsc
    -   CAPsMAN Reporting 
        -   CAPsMAN_Status.rsc

## Prerequisites

-  :white_check_mark: RouterOS v6.40 or higher

## How to use

### 1. CAPsMAN General Automation 

#### CAPsMAN_Auto_SSID_Pass_Change.rsc 
> Fetches [RouterOS_String_Generator.rsc](https://github.com/gbudny93/RouterOS_Useful_Scripts/blob/master/RouterOS_String_Generator.rsc) and adds it to scheduler. Generated string is added as new passphrase to pointed SSIDs based on scheduler. 

Example:
```
$AutoPassChange url="https://raw.githubusercontent.com/gbudny93/RouterOS_Useful_Scripts/master/RouterOS_String_Generator.rsc" \ 
destinationPath="scripts" destinationFileName="RouterOS_String_Generator.rsc" scriptName=scriptName securityProfile=securityProfileName \
smtpServer=smtpServer smtpPort=smtpPort domain=example.com recipient=recipient@example.com; 
```

#### CAPsMAN_Package_Auto_Download.rsc 
> Downloads latest RouterOS package if newer version available. Upgrades RouterOS and sends email notification. 

Example:
```
$PackageAutoDownload userName=userName password=password packagePath=path \
smtpServer=ipAddress smtpPort=poty domain=@example.com \
recipient=recipient@example.com capsmanIP=capsmanIP;
```

### 2. CAPsMAN Automated Sync (pseudo HA)
> Performs sync process of CAPsMAN features between primary CAPsMAN and backup controllers. Ensures pseudo HA keeping the same configuration on all systems modifying only primary. 

Supported features:
- [x] Sync CAP interfaces 
- [x] Email notifications
- [ ] Determine primary CAPsMAN based on condition 
- [ ] Sync channels 
- [ ] Sync provisioning 
- [ ] Sync ACL 
- [ ] Sync configurations 
- [ ] Sync custom parameters of RouterOS 
- [ ] Functions based 

Example: 
RouterOS_Interfaces_Count.rsc must be run on primary CAPsMAN
RouterOS_Interfaces_Remove.rsc must be run on backup CAPsMAN
RouterOS_Interfaces_Import.rsc must be run on backup CAPsMAN 

### 3. CAPsMAN Reporting 
> Set of scripts that performs some simple reporting on this what is going on with wireless environment from controller perspective. 

Example: 
pending 

## Authors

  - Grzegorz Budny