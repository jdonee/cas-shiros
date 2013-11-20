@echo off
echo [Pre-Requirement] Makesure install JDK 6.0+ and set the JAVA_HOME.
echo [Pre-Requirement] Makesure install Maven 3.0.5+ and set the PATH.

set MVN=mvn
set MAVEN_OPTS=%MAVEN_OPTS% -XX:MaxPermSize=256m

echo [Step 1] Install the cas-shiro-server module to ready test.
cd cas-shiros-server
call %MVN% clean install -Dmaven.test.skip=true
if errorlevel 1 goto error

echo [Step 2] Initialize schema and data for all example projects.

cd ..\cas-shiros-db 
call %MVN% clean test -Pcreate-db
call %MVN% clean test -Pinit-db
if errorlevel 1 goto error 

echo [Step 3] Start cas-client projects.
cd ..\cas-shiros-app
start "cas-client1" %MVN% clean jetty:run -Djetty.port=8080
if errorlevel 1 goto error
cd ..\cas-shiros-app-admin
start "cas-client2" %MVN% clean jetty:run -Djetty.port=8082
if errorlevel 1 goto error

echo [INFO] Please wait a moment. When you see "[INFO] Started Jetty Server" in both 2 popup consoles, you can access below demo sites:
echo [INFO] http://localhost:8080/app
echo [INFO] http://localhost:8082/app-admin

goto end
:error
echo Error Happen!!
:end
pause