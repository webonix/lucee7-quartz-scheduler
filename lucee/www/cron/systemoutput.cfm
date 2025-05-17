<cfscript>
//    try {
    sysEnvPurpose = server.system.environment["LUCEE_PURPOSE"]?:"unknown";
    sysEnvHostname = server.system.environment["HOSTNAME"]?:"unknown";
        
        //systemoutput("cron/systemoutput.cfm   run at #timeformat(Now(), 'HH:mm:ss')# on #sysEnvPurpose#(#sysEnvHostname#) started ...",1,0);
        
        if (randrange(1,3) == 3) {
            //systemoutput("cron/systemoutput.cfm   randomally failed at #timeformat(Now(), 'HH:mm:ss')# on #sysEnvPurpose#(#sysEnvHostname#)",1,1);

            // Veto job execution so another node can pick it up
            //qsException = createObject("java", "org.quartz.JobExecutionException").init("randomally failed");
            //qsException.setRefireImmediately(true); // Tell Quartz to retry on another node
            //throw(qsException);
            
            throw("Simulate a fail in /cron/systemoutput.cfm");
            //abort showerror="AJM simulate a fail";
        }
        sleepMS = randRange(120000,140000)
        sleep(sleepMS);
        
        //systemoutput("cron/systemoutput.cfm   run at #timeformat(Now(), 'HH:mm:ss')# on #sysEnvPurpose#(#sysEnvHostname#) after #ceiling(sleepMS/1000)# seconds sleep",1,0);
 //   } catch(any error) {
 //       systemoutput("cron/systemoutput.cfm ERROR: #error.message#",1,1);
 //   }
</cfscript>