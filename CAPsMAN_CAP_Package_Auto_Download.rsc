#Global variables with values assigned
:global packageCurrent [/system package update get current-version];
:global packageLatest [/system package update get latest-version];

:global userName;
:global password;

:global tempFileName;

#Local variables with variables to be defined
:local packagePath #;
:local isNotification false;
:local isDownload false;
:local isReboot true;


:set $tempFileName [/file get value-name=name [/file find where name~$packageLatest]];



:if($isDownload){
   
   :if($isNotification){

       
        :if($packageCurrent != $packageLatest){

            system package update download;
            :delay 5;
            tool fetch address=127.0.0.1 src-path=$tempFileName user=$userName password=$password dst-path=($packagePath."/".$tempFileName) mode=ftp port=21;
        }

    }
    :else{

        :if($packageCurrent != $packageLatest){

            :log info "...:::Found new package available, ready to download:::..."

        }
        :else{

            :log warning "...:::No updates available:::..."

        }

    }


}
   :else{

   }


