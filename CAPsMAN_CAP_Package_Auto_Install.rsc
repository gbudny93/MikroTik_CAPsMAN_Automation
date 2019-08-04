# RouterOS Fucntion 
# Copyright (c) Grzegorz Budny 
# Upgrades all CAPs attached to CAPsMAN. Log actions in system log and in the file. Sends email notification upon completion 

:global CapAutoUpgrade do={

    :local capIdentity; 
    :local capVersion; 

    :local today [/system clock get date]; 
    :local time [/system clock get time]; 
    :local systemName [/system identity get value-name=name];
    :local capsNumber [/caps-man remote-cap print count-only];
    :local packagePath [/caps-man manager get package-path];

    :local fileName ($today."_".$systemName."_CAP_Upgrade.log");

    :if ([:len [/file find name=$fileName]] <= 0) do={
        
        :log warning"...:::Log file not found, creating file:::...";
        /file print file=$fileName;
    
    }

    :if ([:len [/file find name=$fileName]] > 0) do={
        
        :log info "...:::Log file found:::...";
        
    }

    :if ($packagePath != "") do={

        :log info "...:::Package path defined. Starting CAPs upgrade:::..."

        /file set $fileName contents=([get $fileName contents].("New upgrade task started ".$today." at ".$time);

        :for $i from=0 to=($capsNumber - 1) step=1 do={

            :set $capIdentity [/ caps-man remote-cap get value-name=identity number=$i];
            /caps-man remote-cap upgrade numbers=$i;
            :log info ("Upgrading ".$capIdentity."...");
            /file set $fileName contents=([get $fileName contents].($i.") Upgraded ".$capIdentity."\n"));
        
            :set $capIdentity; 

        }

        /tool e-mail send server=$smtpServer port=$smtpPort from=($systemName.$domain) \ 
        to=$recipient subject=("Remote CAPs upgrade run on ".$systemName) \ 
        body=($systemName." upgraded remote CAPs. \n Attached upgrade log file.") file=$fileName; 

    }\
    else={

        :log warning "...:::Upgrade path not specified. Firmware image is missing!:::..."

    }
}

$CapAutoUpgrade smtpServer=smtpIP port=smtpPort recipient=recipients@example.com domain=@example.com 