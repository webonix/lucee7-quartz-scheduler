/**
 * Simple Example
 */
component {
    
    public void function execute() {
        var sysEnvPurpose = server.system.environment.LUCEE_PURPOSE?:"unknown";
        // var sysEnvHostname = server.system.environment.HOSTNAME?:"unknown";

   
        if (sysEnvPurpose == 'web') {
            // Veto job execution so another node can pick it up
            throw("Do not run on Lucee Web Node");
 
/*
            // Throw it as a Java exception
            var qsException = createObject(
                "java", 
                "org.quartz.JobExecutionException", 
                "/opt/lucee/server/lucee-server/mvn/org/quartz-scheduler/quartz/2.3.2/quartz-2.3.2.jar"
            ).init("Do not run on Lucee Web Node 1");

            qsException.setRefireImmediately(true); // Tell Quartz to run again striaght away (retry on another node)

            throw(
                type = "org.quartz.JobExecutionException",
                message = qsException.getMessage(),
                object = qsException
            );
*/
        }
    }
}