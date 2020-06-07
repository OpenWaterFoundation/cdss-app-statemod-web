@echo off
rem
rem Run StateMod for the dataset to create complete output.

rem Turn on delayed expansion so that loops work
rem - Seems crazy but see:  https://ss64.com/nt/delayedexpansion.html
rem - Otherwise, for loops and ( ) blocks don't work because variables are not set as expected
rem - Such variables must be surrounded by ! !, rather than % %
setlocal EnableDelayedExpansion

rem Folder where script is run
set currentFolder=%CD%

rem Determine the folder that the script was called in
set scriptFolder=%~dp0
rem Remove trailing \ from scriptFolder
set scriptFolder=%scriptFolder:~0,-1%

rem Set important folders.

rem Get parent 'workflow' folder using Windows 'for' loop approach
for %%w in (%scriptFolder%) do set workflowFolder=%%~dpw
rem Remove trailing \ from workflowFolder
set workflowFolder=%workflowFolder:~0,-1%

rem Get parent '2015' (version date) folder using Windows 'for' loop approach
for %%v in (%workflowFolder%) do set versionFolder=%%~dpv
rem Remove trailing \ from workflowFolder
set versionFolder=%versionFolder:~0,-1%

rem 'StateMod' folder where files exist
set statemodFolder=%versionFolder%\StateMod

rem 'StateMod' executable program
rem - currently this is hard-coded but may make configurable in the future,
rem   for example add to response file to ensure that a proper version is used.
rem - would be better to verify the version and not depend on the filename,
rem   so that statemod -v could be run and compared
set statemodExe=%versionFolder%\bin\StateMod_Model_15.exe

rem Dataset name (e.g., 'cm2015')
rem - TODO smalers 2020-06-05 need to get from, taken from the '*.ctl' file without the extension
set ctlFile=cm2015.ctl
echo Control file: %ctlFile%
set datasetName=cm2015
echo Dataset being run: %datasetName%

rem Parse command line
if "%1%"=="/h" (
  goto printUsage 
  goto exit0
)
if "%1%"=="-h" (
  goto printUsage 
  goto exit0
)
if "%1%"=="/i" (
  rem Run in interactive mode.
  echo Changing to StateMod folder:  %stateModFolder%
  cd %stateModFolder%
  goto runInteractive 
  goto exit0
)
if "%1%"=="-i" (
  rem Run in interactive mode.
  echo Changing to StateMod folder:  %stateModFolder%
  cd %stateModFolder%
  goto runInteractive 
  goto exit0
)

rem If here continue running the default steps in sequence in batch mode

rem Change to the StateMod folder to run the model
echo Changing to StateMod folder:  %stateModFolder%
cd %stateModFolder%

rem Run StateMod in sequence as per instructions for the dataset.
rem - assume that baseflows have already been run since .xbm exists
call :runStateModVersion

call :runStateMod %datasetName%H.rsp -sim
if %ERRORLEVEL% EQU 1 (
  echo Error running H (historical) dataset.  See the log file.
  goto exit1
)

call :runStateMod %datasetName%H2.rsp -sim
if %ERRORLEVEL% EQU 1 (
  echo Error running H2 (historical calibration) dataset.  See the log file.
  goto exit1
)

call :runStateMod %datasetName%B.rsp -sim
if %ERRORLEVEL% EQU 1 (
  echo Error running B (baseline) dataset.  See the log file.
  goto exit1
)

rem Successful runs so exit cleanly.
goto exit0

rem ========================================================================
rem Below here are functions, in aphabetical order
rem ========================================================================

:printUsage
rem Print the program usage.
echo.
echo Usage:  %scriptName% [options]
echo.
echo Run StateMod to create output or web publishing.
echo By default, run StateMod steps needed to fully recreate H and B output.
echo.
echo -h      Help, print this usage.
echo -i      Run interactive mode, which provides an interactive text menu.
echo.

:runInteractive
rem Run StateMod interactively, using a simple text menu
echo.
echo Enter a number or command name to run a modeling step.  Only final simulation steps are active.
echo.
echo x NOT ACTIVE for cloud publishing (have already been run to generate StateMod files):
echo x   1.  baseflow    Run the baseflow option using %dataset%.rsp
echo x   2.  msm         Run the Mixed Station Model to estimate missing streamflow
echo x   3.  baseflowx   Run the baseflowx option using %dataset%x.rsp
echo ACTIVE for cloud publishing (to run simulations and generate full output):
echo     4a. simh        Run the simulation for the H (historical) dataset and generate reports.
echo     4b. simh2       Run the simulation for the H2 (historical calibration) dataset and generate reports.
echo     5.  simb        Run the simulation for the B (baseline) dataset and generate reports.
echo.
echo     s   Run all simulation steps (4a, 4b, 5)
echo     q   Quit
echo.
set /P answer="Enter choice:  "
rem List actions in order of menu.
rem - since all are unique, only one function will be called below.
if "%answer%"=="1" call :unsupportedOption %answer%
if "%answer%"=="baseflow" call :unsupportedOption %answer%
if "%answer%"=="2" call :unsupportedOption %answer%
if "%answer%"=="msm" call :unsupportedOption %answer%
if "%answer%"=="3" call :unsupportedOption %answer%
if "%answer%"=="baseflowx" call :unsupportedOption %answer%
if "%answer%"=="4a" call :runStateMod %datasetName%H.rsp -sim
if "%answer%"=="simh" call :runStateMod %datsetName%H.rsp -sim
if "%answer%"=="4b" call :runStateMod %datasetName%H2.rsp -sim
if "%answer%"=="simh2" call :runStateMod %datasetName%H2.rsp -sim
if "%answer%"=="4" call :runStateMod %datasetName%B.rsp -sim
if "%answer%"=="simb" call :runStateMod %datasetName%B.rsp -sim
if "%answer%"=="s" (
  call :runStateMod %dataset%H.rsp -sim
  call :runStateMod %dataset%H2.rsp -sim
  call :runStateMod %dataset%B.rsp -sim
)
if "%answer%" == "q" goto exit0
rem Anything else that was entered is ignored.
rem Go to the top of the loop.
goto runInteractive

:runStateMod
rem Function to run StateMod
rem - first function argument is the simulate option
rem - second function argument is the response file name (file only, no path)
rem - it is assumed the current folder is the StateMod dataset folder
set rspFile=%1%
set runArg=%2%
echo Running StateMod %rspFile% %runArg%
time /t
%statemodExe% %rspFile% %runArg%
set errorLevel2=%ERRORLEVEL%
time /t
echo ...finished running StateMod %rspFile% %runArg%
exit /b %errorLevel2%

:runStateModSimB
rem Function to run StateMod B (baseline)
rem - not currently used but keep around until sure won't be needed
rem - the -sim option generates output reports
rem - it is assumed the current folder is the StateMod dataset folder
echo Running sim for StateMod B (baseline) dataset...
time /t
%statemodExe% %datasetName%B.rsp -sim
set errorLevel2=%ERRORLEVEL%
time /t
echo ...finished running sim for StateMod B (baseline) dataset.
exit /b %errorLevel2%

:runStateModSimH
rem Function to run StateMod H (historical)
rem - not currently used but keep around until sure won't be needed
rem - the -sim option generates output reports
rem - it is assumed the current folder is the StateMod dataset folder
echo Running sim for StateMod H (historical) dataset...
time /t
%statemodExe% %datasetName%H.rsp -sim
set errorLevel2=%ERRORLEVEL%
time /t
echo ...finished running sim for StateMod H (historical) dataset.
exit /b %errorLevel2%

:runStateModSimH2
rem Function to run StateMod H2 (historical calibration)
rem - not currently used but keep around until sure won't be needed
rem - the -sim option generates output reports
rem - it is assumed the current folder is the StateMod dataset folder
echo Running sim for StateMod H2 (historical calibration) dataset...
time /t
%statemodExe% %datasetName%H2.rsp -sim
set errorLevel2=%ERRORLEVEL%
time /t
echo ...finished running sim for StateMod H2 (historical calibration) dataset.
exit /b %errorLevel2%

:runStateModVersion
rem Function to run StateMod and print the version.
rem - it is assumed the current folder is the StateMod dataset folder
%statemodExe% -v
exit /b 0

:unsupportedOption
rem Print a warning about unsupported menu option
rem - first function argument is menu item that was entered
set menuItem=%1%
echo.
echo Menu item '%menuItem%' is not active.
echo.
exit /b 0

:exit1
rem Change back to original folder
echo Changing back to starting folder:  %currentFolder%
cd %currentFolder%
rem Exit with success code
echo Exiting with status 1
exit /b 1

:exit0
rem Change back to original folder
echo Changing back to starting folder:  %currentFolder%
cd %currentFolder%
rem Exit with success code
echo Exiting with status 0
exit /b 0
