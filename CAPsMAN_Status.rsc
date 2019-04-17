#Global variables defined with values assigned

:global intCount [/caps-man remote-cap print count-only];
:global remoteCapCount [/caps-man remote-cap print count-only];
:global regTableCount [/caps-man registration-table print count-only];
:global inactiveIntCount [/caps-man interface print count-only where inactive];
:global masterIntCount [/caps-man interface print count-only where master];
:global disabledIntCount [/caps-man interface print count-only where disabled];
:global boundIntCount [/caps-man interface print count-only where bound];
:global channelCount [/caps-man channel print count-only];
:global aclCount [/caps-man access-list print count-only];
:global radiusCount [/radius print count-only];

#Global Variables
:global pingInterval 1;
:global pingCount 8;

#Local variables
:local $backupCAPsMANIp #X.X.X.X;



#system resource cpu print
#system resource print


#Count Radius Servers and check
:for value from=0 to=($radiusCount -1 ) step=1 do={

    :local ($npsServer.$value) [/radius get value-name=address number=$value] 

    :if ([/ping $npsServer.$value interval=1 count=8] > 0) do={:put ($npsServer.$value "is responding to ICMP packets")} else={:put ($npsServer.$value "is NOT responding to ICMP packets")}

}
 


#Check backup CAPs and check NPSs 
:if ([/ping 1.1.1.1 interval=1 count=8] > 0) do={:put "backup ok"} else={:put "ups lipa"}




