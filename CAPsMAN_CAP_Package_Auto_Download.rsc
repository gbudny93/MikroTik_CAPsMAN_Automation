# RouterOS Fucntion 
# Copyright (c) Grzegorz Budny 
# Checks if latest package is available. Downloads it to specified location and send email notification

:global PackageAutoDownload do={

    /system package update check-for-updates;

    :local packageCurrent [/system package update get installed-version];
    :local packageLatest [/system package update get latest-version];
    :local packageName [/system package get value-name=name number=0];
    :local systemName [/system identity get value-name=name]; 

    :if ($packageCurrent != $packageLatest) do={

        :log info ("...:::New cAP package available - ".$packageLatest." Downloading:::...");
        
        /system package update download;
        
        :log info ("...:::".$packageName." ".$packageLatest." downloaded. Moving to specified container:::...");
        :delay 2;
        
        /tool fetch address=$capsmanIP src-path=($packageName."-".$packageLatest.".npk") user=$userName password=$password dst-path=($packagePath."/".($packageName."-".$packageLatest.".npk")) mode=ftp port=21;
        
        :log info ("...:::Package moved to ".$capsmanIP."\n Ready to deploy:::..."); 

        /tool e-mail send server=$smtpServer port=$smtpPort from=($systemName.$domain) \ 
        to=$recipient subject=("cAP update available on ".$systemName) \ 
        body=($systemName." downloaded latest package ".$packageLatest.". \
        \nPackage ready to deploy.");

        /file remove ($packageName."-".$packageLatest.".npk");

    }\
    else={

        :log info ("...:::No cAP updates found. ".$packageCurrent." is the latest version...:::");

        /tool e-mail send server=$smtpServer port=$smtpPort from=($systemName.$domain) \ 
        to=$recipient subject=("No cAP update available on ".$systemName) \ 
        body=($systemName." cAPs have installed the latest package ".$packageLatest);

    }
}

$PackageAutoDownload userName=userName password=password packagePath=path \
smtpServer=ipAddress smtpPort=poty domain=@example.com \
recipient=recipient@example.com capsmanIP=capsmanIP;