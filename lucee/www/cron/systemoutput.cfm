<cfscript>
    try {
        systemoutput("cron/systemoutput.cfm run at #Now()# on #server.system.environment.HOSTNAME# #server.system.environment.LUCEE_PURPOSE#",1,0);
        sleep(34000);
        systemoutput("cron/systemoutput.cfm run at #Now()# on #server.system.environment.HOSTNAME# #server.system.environment.LUCEE_PURPOSE# after 34 second sleep",1,0);
    } catch(any error) {
        systemoutput("cron/systemoutput.cfm ERROR: #error.message#",1,1);
    }
</cfscript>