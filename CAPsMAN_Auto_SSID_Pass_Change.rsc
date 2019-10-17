# RouterOS Fucntion 
# Copyright (c) Grzegorz Budny 
# Generates string and updates CAPsMAN profile security config

:global AutoPassChange do={


    :local scriptSource;
    :local newSSIDPass;

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