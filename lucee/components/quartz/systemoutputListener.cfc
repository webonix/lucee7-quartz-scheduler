component  implementsJava="org.quartz.JobListener" {

    // Properties
    property name="name"    type="string";
    property name="stream"  type="string";
    property name="logFile" type="string";

    public String function init(struct listenerData={}) { 
        variables.name = "systemOutputListener";
        variables.stream = listenerData.stream ?: "err";
        variables.logFile = listenerData.logFile ?: "";

        if ( variables.logFile != "" ) {
            // in case there is a placeholder variable eg "logFile": "{lucee-config}/logs/quartz-cluster.log"
            variables.logFile = expandPath(listenerData.logFile);
        }

        // timing jobs
        variables.stJobs = {};

        // Initialize any resources
        if (len(variables.logFile)) {
            // Ensure log directory exists
            var logDir = getDirectoryFromPath(variables.logFile);
            if (!directoryExists(logDir)) {
                directoryCreate(logDir);
            }
        }

        writeToLog("#variables.name# loaded");
    }
    
    public String function getName() { 
        return variables.name;
    }

    public String function getDescription() { 
        return "Logs all job execution details directly to the systemoutput, providing real-time feedback for monitoring and debugging purposes.";
    }

    public void function jobToBeExecuted( context) {
        // start timer
        var fireInstanceId = getFireInstanceId(arguments.context);
        variables.stJobs[fireInstanceId] = getTickCount();

        var message = "jobToBeExecuted(#fireInstanceId#, #getLabel(arguments.context)#)";
        writeToLog(message);
    }

    public void function jobExecutionVetoed( context) {
        systemOutput("AJM listener jobExecutionVetoed()",1,0); 
        var fireInstanceId = getFireInstanceId(arguments.context);
        var jobDuration = getTickCount() - variables.stJobs[fireInstanceId];
systemOutput("AJM listener jobExecutionVetoed() jobDuration=#jobDuration#",1,0);
            structDelete(variables.stJobs, fireInstanceId);

        var message = "jobExecutionVetoed(#fireInstanceId#, #getLabel(arguments.context)#)) in #jobDuration# ms";
        writeToLog(message);
    }

    public void function jobWasExecuted( context,  jobException) {
        var fireInstanceId = getFireInstanceId(arguments.context);
        var jobDuration = getTickCount() - variables.stJobs[fireInstanceId];
            structDelete(variables.stJobs, fireInstanceId);

        var message = '';
        
        if (isNull(arguments.jobException)) {
            message = "jobWasExecuted(#fireInstanceId#, #getLabel(arguments.context)#) in #jobDuration# ms";
            writeToLog(message);
        } else {
            var erorMessage = arguments.jobException.getMessage();
            var regex = "\[See nested exception: [^:]+: (.*?)\]";
            var matches = reFind(regex, erorMessage, 1, true);

            if (arrayLen(matches.pos) > 1) {
                erorMessage = mid(erorMessage, matches.pos[2], matches.len[2]);
            }

            message = "jobWasExecuted(#fireInstanceId#, #getLabel(arguments.context)#) with exception: #erorMessage#  in #jobDuration# ms";
            writeToLog(message);
        }
    }

    private static function getLabel(context) {
        var job=arguments.context.getJobDetail();
        var dataMap=job.getJobDataMap();

        return dataMap["label"]?:job.getKey().toString();
    }

    private static function getFireInstanceId(context) {
        var fireInstanceId = arguments.context.getFireInstanceId();
            fireInstanceId = left(fireInstanceId, 4) & "..." & right(fireInstanceId, 4);
        return fireInstanceId;
    }


    private static function getRefireCount(context) {
        return arguments.context.getRefireCount();
    }

    private static function getJobId(context) {
        var job=arguments.context.getJobDetail();
        return job.getKey().toString();
    }

    // Helper function to write to log
    private void function writeToLog(required string message) {
        // Write to console
        local.message = "#dateTimeFormat(Now(), 'dd-Mmm-YYYY HH:nn:ss.lll')# QS LISTENER :: #arguments.message#";

        if (variables.stream == "out") {
            systemOutput(local.message, true, true);
        } else {
            systemOutput(local.message, true, false);
        }
        
        // Write to log file if configured
        if (len(variables.logFile)) {
            fileAppend(variables.logFile, message & chr(13) & chr(10));
        }
    }


}