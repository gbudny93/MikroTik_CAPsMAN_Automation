# RouterOS Fucntion 
# Copyright (c) Grzegorz Budny 
# Version 1.0 
# Last update: 2/8/2020
# Generates string and updates CAPsMAN profile security config

:global AutoPassChange do={


    :local scriptSource;
    :local newSSIDPass;

    :local systemName [system identity get value name];

    /tool fetch mode=https http-method=get url=$url dst-path=($destinationPath."/".$destinationFileName);
    
    :log info "...:::Script String Generator fetched:::...";

    :set $scriptSource [/file get ($destinationPath."/".$destinationFileName) contents];

    /system script add name=$scriptName source=$scriptSource;

    :set $newSSIDPass $GenerateString; 

    /caps-man security set passphrase=$newSSIDPass where name=$securityProfile;

    /tool e-mail send server=$smtpServer port=$smtpPort from=($systemName.$domain)  \ 
    to=$recipient subject=($systemName." generated new pass for ".$securityProfile) \
    body=("New ."$securityProfile." generated password is: ".$newSSIDPass);

}

$AutoPassChange url="https://raw.githubusercontent.com/gbudny93/RouterOS_Useful_Scripts/master/RouterOS_String_Generator.rsc" \ 
destinationPath="scripts" destinationFileName="RouterOS_String_Generator.rsc" scriptName=scriptName securityProfile=securityProfileName \
smtpServer=smtpServer smtpPort=smtpPort domain=example.com recipient=recipient@example.com; 