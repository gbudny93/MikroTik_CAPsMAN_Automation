# RouterOS Script
# Copyright (c) Grzegorz Budny 
# Makes a full copy to file all defined CAPsMAN interfaces.
# Script must be run on primary CAPsMAN in your environment.

:global capIntCount;

:local fileName "int_number.txt";
:local intFileName caps_int.rsc;

:local smtpServer #smtp server IP
:local smtpPort #smtp port
:local from #sender email  
:local to #recipients email
:local cc #cc email
:local subject "Interfaces Sync Notification"
:local body "CAPsMAN Ready for Interfaces Sync Process"

:log info "..::Interfaces count and export started::..";

:set capIntCount [/caps-man interface print count-only];

:if ([:len [/file find name=$fileName]] <= 0) do={
    :log info "File not found, creating file";
    file print file=$fileName;
}

:if ([:len [/file find name=$fileName]] > 0) do={
    :log info "File found";
    file set $fileName contents=$capIntCount;
}

:log info "..::Exporting Interfaces";

caps-man interface export file=$intFileName;

:log info "..::Interfaces count and export finished::..";

tool e-mail send server=$smtpServer port=$smtpPort from=$from to=$to cc=$cc subject=$subject body=$body;
