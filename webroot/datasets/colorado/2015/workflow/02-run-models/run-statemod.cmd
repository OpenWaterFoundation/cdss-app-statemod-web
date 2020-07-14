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
rem - the workflow to create web products downloads StateMod into 'bin' folder,
rem   but dataset may have StateMod executable in the StateMod folder if a
rem   newer dataset installer is used
rem - currently this is hard-coded but may make configurable in the future,
rem   for example add to response file to ensure that a proper version is used.
rem - would be better to verify the version and not depend on the filename,
rem   so that statemod -v could be run and compared
rem - TODO smalers 2020-06-19 need to evaluate how to handle finding
rem   StateMod executables other than those known below,
rem   or stick with a specific known working version
set statemodExe=unknown
if exist "%versionFolder%\StateMod\StateMod_Model_15.exe" (
  set statemodExe=%versionFolder%\StateMod\StateMod_Model_15.exe
) else (
  if exist "%versionFolder%\bin\StateMod_Model_15.exe" (
    rem Default
    set statemodExe=%versionFolder%\bin\StateMod_Model_15.exe
  )
)

rem Make sure that StateMod executable exists
if "%stateModExe%"=="unknown" (
  echo Unable to find StateMod executable to run.
  goto exit1
) else (
  if not exist "%stateModExe%" (
    rem Test again just in case
    echo StateMod executable does not exist:  %stateModExe%
    goto exit1
  )
)

rem Dataset name (e.g., 'cm2015')
rem - TODO smalers 2020-06-05 need to get from, taken from the '*.ctl' file without the extension
set ctlFile=cm2015.ctl
echo Control file: %ctlFile%
set datasetName=cm2015
echo Dataset being run: %datasetName%

rem Parse command line
if "%1%"=="/h" (
  call :printUsage 
  goto exit0
)
if "%1%"=="-h" (
  call :printUsage 
  goto exit0
)
if "%1%"=="/b" (
  rem Run in batch mode.
  echo Changing to StateMod folder:  %stateModFolder%
  cd %stateModFolder%
  call :runBatch 
  exit /b %ERRORLEVEL%
)
if "%1%"=="-b" (
  rem Run in batch mode.
  echo Changing to StateMod folder:  %stateModFolder%
  cd %stateModFolder%
  call :runBatch 
  exit /b %ERRORLEVEL%
)

rem If here the default is to run interactive
call :runInteractive 
rem Exit with the return status from runInteractive
exit /b %ERRORLEVEL%

rem ========================================================================
rem Below here are functions, in aphabetical order
rem ========================================================================

:printUsage
rem Print the program usage.
echo.
echo Usage:  %scriptName% [options]
echo.
echo Run StateMod to create output for web published datasets.
echo The default is to run in interactive mode, with menu for each major step.
echo.
echo -b      Run all StateMod simulation steps in batch mode.
echo -h      Help, print this usage.
echo.
exit /b 0
rem End of :printUsage

:runBatch
rem Run StateMod in batch mode.
rem Change to the StateMod folder to run the model
echo Changing to StateMod folder:  %stateModFolder%
cd %stateModFolder%

rem Run StateMod in sequence as per instructions for the dataset.
rem - assume that baseflows have already been run since .xbm exists
rem First print the version
call :runStateModVersion

rem Next run H.rsp
call :runStateMod %datasetName%H.rsp -sim
if %ERRORLEVEL% EQU 1 (
  echo Error running H (historical) dataset.  See the log file.
  goto exit1
)

rem Next run H2.rsp
call :runStateMod %datasetName%H2.rsp -sim
if %ERRORLEVEL% EQU 1 (
  echo Error running H2 (historical calibration) dataset.  See the log file.
  goto exit1
)

rem Next run B.rsp
call :runStateMod %datasetName%B.rsp -sim
if %ERRORLEVEL% EQU 1 (
  echo Error running B (baseline) dataset.  See the log file.
  goto exit1
)
exit /b %errorLevel2%
rem End of :runBatch


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
echo     4a. simh        Run the simulation for the H (historical) dataset and generate standard reports.
echo     4b. simh2       Run the simulation for the H2 (historical calibration) dataset and generate standard reports.
echo     5.  simb        Run the simulation for the B (baseline) dataset and generate standard reports.
echo.
echo         repwbh2     Run the water balance report for the H2 dataset.
echo         repwbb      Run the water balance report for the B dataset.
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
if "%answer%"=="repwbh2" call :runStateMod %datasetName%H2.rsp -report -xwb
if "%answer%"=="repwbb" call :runStateMod %datasetName%B.rsp -report -xwb
if "%answer%"=="s" call :runBatch
if "%answer%"=="q" goto exit0
rem Anything else that was entered is ignored.
rem Go to the top of the loop.
goto runInteractive
rem Put return here for consistency but 'q' will have exited.
exit /b 0
rem End of :runInteractive

:runStateMod
rem Function to run StateMod
rem - first function argument is the simulate option
rem - second function argument is the response file name (file only, no path)
rem - it is assumed the current folder is the StateMod dataset folder
set rspFile=%1%
set runArg=%2%
set runArg2=%3%
rem Change to StateMod folder
cd %stateModFolder%
echo Running StateMod %rspFile% %runArg% %runArg2%
time /t
%statemodExe% %rspFile% %runArg% %runArg2%
set errorLevel2=%ERRORLEVEL%
time /t
echo ...finished running StateMod %rspFile% %runArg% %runArg2%
exit /b %errorLevel2%
rem End of :runStateMod

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
rem End of :runStateModSimB

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
rem End of :runStateModSimH

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
rem End of :runStateModSimH2

:runStateModVersion
rem Function to run StateMod and print the version.
rem - it is assumed the current folder is the StateMod dataset folder
%statemodExe% -v
exit /b 0
rem End of :runStateModVersion

:unsupportedOption
rem Print a warning about unsupported menu option
rem - first function argument is menu item that was entered
set menuItem=%1%
echo.
echo Menu item '%menuItem%' is not active.
echo.
exit /b 0
rem End of :unsupportedOption

:exit1
rem Exit the program with status 1.
rem This is not a function.  Do not "call".  Use goto.  It will exit the program.
rem Change back to original folder
echo Changing back to starting folder:  %currentFolder%
cd %currentFolder%
rem Exit with success code
echo Exiting with status 1
exit /b 1

:exit0
rem Exit the program with status 0.
rem This is not a function.  Do not "call".  Use goto.  It will exit the program.
rem Change back to original folder
echo Changing back to starting folder:  %currentFolder%
cd %currentFolder%
rem Exit with success code
echo Exiting with status 0
exit /b 0
