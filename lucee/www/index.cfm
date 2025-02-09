<h1>Quartz Sceduler for Lucee</h1>

<cfoutput>
    <p>Current Lucee version: #server.lucee.version#</p>
    <p>Server Name: #server.system.properties["catalina.base"]#</p>
    <p><strong>Host Name:</strong> #server.system.environment.HOSTNAME#</p>
    <p><strong>Purpose:</strong> #server.system.environment.LUCEE_PURPOSE#</p>
</cfoutput>

<ul>
    <li><a href="http://127.0.0.1:8888/lucee/admin/index.cfm" target="luceeAdmin">Lucee Admin</a></li>
    <li><a href="http://127.0.0.1:8081/" target="RedisCommander">Redis Commander</a></li>
    <li><a href="https://download.lucee.org/" target="luceeDownloads"></a></li>
    <li><a href="https://bulma.io/" target="BulmaCSS">Bulma CSS</a></li>
    <li><a href="https://alpinejs.dev/" target="alpineJS">Alipne JS</a></li>
    <li><a href="" target="_blank"></a></li>
    <li><a href="" target="_blank"></a></li>
    <li><a href="https://github.com/lucee/lucee-docs/tree/master/docs/recipes" target="_blank">https://github.com/lucee/lucee-docs/tree/master/docs/recipes</a></li>
</ul>

<cfscript>
    echo('{lucee-web}=' & expandPath('{lucee-web}') & "<br />"); 
    echo('{lucee-server}=' & expandPath('{lucee-server}') & "<br />"); 
    echo('{lucee-config}=' & expandPath('{lucee-config}') & "<br />"); 
    echo('{temp-directory}=' & expandPath('{temp-directory}') & "<br />"); 
    echo('{home-director}=' & expandPath('{home-directory}') & "<br />"); 
    echo('{system-directory}=' & expandPath('{system-directory}') & "<br />"); 
    echo('{web-root-directory}=' & expandPath('{web-root-directory}') & "<br />"); 
    echo('{web-context-hash}=' & expandPath('{web-context-hash}') & "<br />"); 
    echo('{web-context-label}=' & expandPath('{web-context-label}') & "<br />"); 
    </cfscript>
<cfdump var="#server.lucee#" expand="true" label="ajm server.lucee" abort="false">
<cfdump var="#server.system#" expand="true" label="ajm server.system" abort="false">
