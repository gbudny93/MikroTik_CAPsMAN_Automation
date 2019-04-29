#Global variables with values assigned
:global packageCurrent [/system package update get current-version];
:global packageLatest [/system package update get latest-version];

#Local variables with variables to be defined
:local packagePath #;
:local isDownload false;
:local isReboot true;




:if($isDownload){
   

        :if($packageCurrent != $packageLatest){

        }

}
:else{

        :if($packageCurrent != $packageLatest){

            system package update download file=$packagePath
            :log info "...:::Found new package, downloading:::..."

        }
        :else{

            :log warning "...:::No updates available:::..."

        }

}


