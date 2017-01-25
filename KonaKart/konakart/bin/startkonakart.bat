
rem ================
rem  Start KonaKart
rem ================

set KK_TOMCAT_BIN=%~dp0

set CATALINA_HOME=%KK_TOMCAT_BIN%/..
set CATALINA_BASE=%KK_TOMCAT_BIN%/..

set CATALINA_OPTS=-XX:PermSize=256m -XX:MaxPermSize=256m -Xmx1400m -server -Dsolr.solr.home="%CATALINA_HOME%/solr" -Djava.awt.headless=true -Dactivemq.store.dir="%CATALINA_HOME%/mq" 

rem SSL Protocols TLS 1.2
rem If using Java 7 and using a Payment Gateway that requires TLS 1.2 you will probably need to add these to CATALIAN_OPTS or JAVA_OPTS:
rem -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2"  -Dhttps.protocols="TLSv1,TLSv1.1,TLSv1.2"

rem Logging debug options:
rem (Default is debug=false)
rem for debugging log4j   add:  -Dlog4j.debug=true
rem for debugging kklog4j add:  -Dkk.log4j.debug=true

rem Logging java.net traffic
rem -Djavax.net.debug=all

rem Logging JAXWS processing:
rem -Dcom.sun.xml.ws.transport.http.client.HttpTransportPipe.dump=true -Dcom.sun.metro.soap.dump=true

rem To allow changes to logging without restarting:
rem (Default is WatchTimeSecs=120)
rem to disable the watch thread on log files set  -Dkk.log4j.WatchTimeSecs=-1
rem to enable  the watch thread on log files set  -Dkk.log4j.WatchTimeSecs=60   to check for changes every 60 seconds

call "%KK_TOMCAT_BIN%/setJavaHome.bat"

if not exist "%CATALINA_HOME%/temp" mkdir %CATALINA_HOME%/temp

rem These JAVA_OPTS (or similar) can used when running the Java Message Queue Web Console 
rem set JAVA_OPTS=-Dwebconsole.type=properties -Dwebconsole.jms.url=tcp://localhost:8791 -Dwebconsole.jmx.url=service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi -Dwebconsole.jmx.user= -Dwebconsole.jmx.password=

rem Start Solr
echo Start Solr
cmd /c "%CATALINA_HOME%/solr/bin/solr.cmd" start -p 8983
echo. 

rem Start Tomcat
echo Start KonaKart
call "%KK_TOMCAT_BIN%/startup.bat"
