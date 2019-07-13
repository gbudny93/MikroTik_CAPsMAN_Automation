# RouterOS Script
# Copyright (c) Grzegorz Budny  
# Removes all defined CAPsMAN interfaces. Downloads current list from primary CAPsMAN and import it. 
# Script must be run on any of backup CAPsMANs. 

:local primaryCAPsMAN #primary CAPsMAN IP
:local filePath caps_int.rsc
:local filePath2 int_number.txt
:local userName #Username
:local password #Password

:local capIntCount

:local smtpServer #smtp server IP
:local smtpPort #smtp port 
:local from #sender email 
:local to #recipeints email
:local cc #cc email
:local subject "Interfaces Sync Notification"
:local body "CAPsMAN Interfaces Sync Completed"

:log info "..::CAPsMAN Interfaces Update Script Started::..";
:log info "..::Downloading file from Primary CAPsMAN::..";

tool fetch address=$primaryCAPsMAN src-path=$filePath \
user=$userName mode=ftp password=$password dst-path=$filePath port=21;

tool fetch address=$primaryCAPsMAN src-path=$filePath2 \
user=$userName mode=ftp password=$password dst-path=$filePath2 port=21;

:set $capIntCount [/file get $filePath2 contents]; 

:set $capIntCount ($capIntCount -1);

:log info "..::Files downloaded::..";
:log info "..::waiting 5s:..";

:delay 5;

:log info "::..Removing CAPsMAN interfaces::..";

:for a from=0 to=$capIntCount step=1 do= \
{
    /caps-man interface remove $a;
}

:delay 5;

:log warning "..::CAPsMAN Interfaces removed::..";
:log info "..::Sending notification::..";

tool e-mail send server=$smtpServer port=$smtpPort from=$from to=$to cc=$cc subject=$subject body=$body;

:log info "..::Waiting for reboot::..";

:delay 10;

system reboot 