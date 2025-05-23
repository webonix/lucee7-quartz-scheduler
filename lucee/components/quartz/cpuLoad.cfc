/**
 * Put a load on lucee nodes and veto if too busy
 */
component {
/**
 * {
 * "duration":5,
 * "schedule":"interval",
 * "component":"quartz.cpuLoad",
 * "load":20,
 * "log":"scheduler",
 * "interval":5,
 * "label":"put a load on the cpu every 5 seconds",
 * "pause":false
 * }
 *

 */

    public void function init(
        required string label,
        numeric duration=10,
        numeric load=50
    ) hint="pass in configuration" {
        variables.label = arguments.label;

        variables.duration = arguments.duration;
        variables.load     = arguments.load;

        //systemoutput("quartz/cpuLoad.cfc init(#arguments.duration#, #arguments.load#)",1,0);
    }

    public void function execute(
    ) localmode=true {
        //systemoutput("quartz/cpuLoad.cfc execute()",1,0);

        sysEnvPurpose = server.system.environment["LUCEE_PURPOSE"]?:"unknown";
        sysEnvHostname = server.system.environment["HOSTNAME"]?:"unknown";
        
        //systemoutput("quartz/cpuLoad(#variables.duration#, #variables.load#) run at #timeformat(Now(), 'HH:mm:ss')# on #sysEnvPurpose#(#sysEnvHostname#) started ...",1,0);

        if (sysEnvPurpose == 'web') {
            //systemoutput("quartz/cpuLoad(#variables.duration#, #variables.load#)",1,1);
            throw("AJM Do not run cpuLoad.cfc on Lucee Web Node");
        }

        // check CPU Load
        cpuLoad = getCPULoad();
        systemoutput("#dateTimeFormat(Now(), 'dd-Mmm-YYYY HH:nn:ss.lll')# quartz/cpuLoad(#variables.duration#, #variables.load#) cpuLoad=#cpuLoad#%",1,0);
        if (cpuLoad> 70) {

            throw("AJM CPU Load #cpuLoad# is over 70%");
        }

        // put some load on the CPU
        generateCPULoad(variables.duration, variables.load);

        //systemoutput("quartz/cpuLoad(#variables.duration#, #variables.load#) finnised at #timeformat(Now(), 'HH:mm:ss')# on #sysEnvPurpose#(#sysEnvHostname#)",1,0);
    }



    private numeric function getCPULoad() localmode=true {
        sysLoad = GetCPUUsage(500); // check cpu for 500 ms * 10 (CPUs/cores??)
        return isNumeric(sysLoad) ? Round(sysLoad*10) : 100; // Return 100% if unable to determine
    }

    private void function generateCPULoad(
        required numeric durationSeconds = 5    hint="How long to run the load test (1-30 seconds)",
        required numeric cpuLoadPercentage = 50 hint="Desired CPU load (20-80%)"
    ) localmode=true {
        // Ensure parameters are within valid ranges
        arguments.durationSeconds = max(1, min(30, arguments.durationSeconds));
        arguments.cpuLoadPercentage = max(20, min(80, arguments.cpuLoadPercentage));

        startTime = getTickCount();
        endTime = startTime + (arguments.durationSeconds * 1000);
        cycleTimeMs = 100; // Each cycle is 100ms
        busyTimeMs = cycleTimeMs * (arguments.cpuLoadPercentage / 100);
        idleTimeMs = cycleTimeMs - busyTimeMs;

        while (getTickCount() < endTime) {
            cycleStart = getTickCount();

            // Busy-wait loop for the 'busy' portion of the cycle
            while (getTickCount() - cycleStart < busyTimeMs) {
                // Just loop to keep CPU busy
                sleep(1); // Yield CPU slightly
                //var x = rand(); // bit of load
                var aNames = [0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9];
                    aNames.each(
                        function(element) {
                            var x = hash(repeatString("abcdef123456", 1000), "SHA-256"); // bit of a load
                        }
                    );
                
            }

            // Sleep for the 'idle' portion of the cycle
            sleep(idleTimeMs);
        }

    }
}
