@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM ----------------------------------------------------------------------------
@REM Apache Maven Wrapper startup batch script, version 3.2.0
@REM ----------------------------------------------------------------------------

@echo off

setlocal

set MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
IF NOT "%MAVEN_PROJECTBASEDIR%"=="" goto endDetectBaseDir

set EXEC_DIR=%CD%
set WDIR=%EXEC_DIR%
:findBaseDir
IF EXIST "%WDIR%\.mvn" goto baseDirFound
cd ..
IF "%WDIR%"=="%CD%" goto baseDirNotFound
set WDIR=%CD%
goto findBaseDir

:baseDirFound
set MAVEN_PROJECTBASEDIR=%WDIR%
cd "%EXEC_DIR%"
goto endDetectBaseDir

:baseDirNotFound
set MAVEN_PROJECTBASEDIR=%EXEC_DIR%
cd "%EXEC_DIR%"

:endDetectBaseDir

IF NOT EXIST "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar" (
  goto wrapperJarNotFound
)

:downloadWrapperJar
@REM Download maven-wrapper.jar if not present
set WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
for /F "tokens=2 delims==" %%a in ('findstr /R "^wrapperUrl=" "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties"') do set WRAPPER_URL=%%a

if not exist %WRAPPER_JAR% (
  echo Downloading Maven Wrapper...
  powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile %WRAPPER_JAR%}"
  if errorlevel 1 goto error
)

:wrapperJarNotFound
IF NOT EXIST "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar" (
  @REM Fallback: use a bundled approach
  echo Maven Wrapper jar not found. Please ensure .mvn/wrapper/maven-wrapper.jar exists.
  exit /b 1
)

set MAVEN_WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"

:runMaven
set WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

set MAVEN_OPTS=%MAVEN_OPTS% -Dmaven.multiModuleProjectDirectory="%MAVEN_PROJECTBASEDIR%"

if "%1"=="" goto runCommand

:runCommand
java %MAVEN_OPTS% -classpath %MAVEN_WRAPPER_JAR% %WRAPPER_LAUNCHER% %*

:end
if errorlevel 1 goto error
exit /b 0

:error
echo Error occurred during Maven Wrapper execution.
exit /b 1
