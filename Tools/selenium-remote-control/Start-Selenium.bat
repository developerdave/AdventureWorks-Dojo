echo off

java -jar %cd%\selenium-server-1.0.3\selenium-server.jar -port 5555 -firefoxProfileTemplate "selenium-server-1.0.1\test-profile"

pause
echo Done
