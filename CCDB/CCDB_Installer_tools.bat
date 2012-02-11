@ECHO OFF
TITLE Catacrunch DB Project DB Installer Tool
COLOR 0b
SET Pbuild_ver= G5 12-13-11
SET Sbuild_ver= 12-31-11
SET SRbuild_ver= 02-11-12
SET updatetime= Feb 11,2012 18:47pm
SET dbrev= CCDB R19
SET release_ver= PUBLIC
:TOP

echo. 
echo                 *******     *******    *******    *******    
echo               /** ////**  /** ////**  /**////**  /**////** 
echo              /**         /**          /**    /** /**   /** 
echo              /**         /**          /**    /** /*******  
echo              /**         /**          /**    /** /**////**
echo               /**    /**  /**    /**  /**    /** /**   /**
echo                /*******    /*******   /********  /******* 
echo                 //////      //////    ///////    ///////   
echo. 
echo               The Catacrunch Database Development Project
ECHO                                2011-2012 
echo                        http://www.ccdb-home.org
ECHO         DB Version:%dbrev% : Updated on%updatetime% 
ECHO.
ECHO                           CCDB%release_ver% RELEASE
ECHO     ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO     บ                   CCDB Installation Tool                    บ
ECHO     บ                            for                              บ
ECHO     บ PDSU%Pbuild_ver%, Skyfire%Sbuild_ver%, Skyfire REBASE%SRbuild_ver% บ
ECHO     ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO Members: Catacrunch : Lorac   : Nomad   : Zamara  : Sulbutx : John2308
ECHO        : Prydev     : Tiburan : Raydeon : Rochet2 : Nooblet :
ECHO.
PAUSE
CLS
COLOR 0C
ECHO    Please enter your MySQL Info...
ECHO.
SET /p host= First enter MySQL Server Address [usually localhost] :
if %host%. == . set host=localhost
ECHO.
ECHO -------------------------------------------------------------------
ECHO.
SET /p user= Now your MySQL Username [usually root] : 
if %user%. == . set user=root
ECHO.
SET /p pass= and MySQL Password: 
ECHO.
SET /p port= Enter your MySQL port [usually 3306] : 
if %port%. == . set port=3306
ECHO.
ECHO -------------------------------------------------------------------
ECHO.
SET /p world_db= Ok now enter your World Database:
ECHO.
SET /P char_db= and finally your Character Database:
SET cdumppath=.\db_backups\character_dump\
SET wdumppath=.\db_backups\world_dump\
SET rcdumppath=.\db_backups\rebase_character_dump\
SET rwdumppath=.\db_backups\rebase_world_dump\
SET mysqlpath=.\database\dep\mysql\
SET devcsql=.\database\main_db\character\
SET devsql=.\database\main_db\world\
SET procsql=.\database\main_db\procs\
SET orig_update=.\database\development\orig_update
SET reba_update=.\database\development\reba_update
SET local_sp=.\database\development\locals\spanish\
SET local_gr=.\database\development\locals\german\
SET local_ru=.\database\development\locals\russian\
SET local_it=.\database\development\locals\italian\
SET rebchar=.\database\main_db\character_rebase\
SET rebworl=.\database\main_db\world_rebase\

:Begin
CLS
SET upstat= Rev19-A
Set lstat=Under Development
COLOR 0b
SET v=""
ECHO.
ECHO          ษออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO          บ                                                บ
ECHO          บ        Please Choose an option                 บ
ECHO          บ                                                บ
ECHO          บ  C. Goto Original CCDB Installation Options    บ
ECHO          บ                                                บ
ECHO          บ  S. Goto Skyfire CCDB Installation Options     บ
ECHO          บ                                                บ
ECHO          บ  X  Exit Install tool                          บ
ECHO          บ                                                บ
ECHO          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO.
SET /p v= 		Enter a char: 
IF %v%==c GOTO CCDBORI
IF %v%==C GOTO CCDBORI
IF %v%==s GOTO SKYREBASE
IF %v%==S GOTO SKYREBASE
IF %v%==d GOTO CCDBDEV
IF %v%==D GOTO CCDBDEV
IF %v%==x GOTO exit
IF %v%==X GOTO exit
IF %v%=="" GOTO exit
GOTO error
:CCDBORI
CLS
ECHO.
ECHO          ษออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO          บ                                                บ
ECHO          บ      Please Choose an option for your DB       บ
ECHO          บ                                                บ
ECHO          บ  1. Install DB Note: This will wipe old DB!    บ
ECHO          บ  2. Install empty Char DB                      บ
ECHO          บ                                                บ
ECHO          บ  3. Backup World DB                            บ
ECHO          บ  4. Backup Character DB                        บ
ECHO          บ                                                บ
ECHO          บ  5. Apply Updates             %upstat%         บ
ECHO          บ  6. Apply Locals            %lstat%  บ
ECHO          บ  7. Change Settings                            บ
ECHO          บ                                                บ
ECHO          บ  M. Return back to Main DB Selection           บ
ECHO          บ                                                บ
ECHO          บ  X  Exit Install tool                          บ
ECHO          บ                                                บ
ECHO          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO.
SET /p v= 		Enter a char: 
IF %v%==* GOTO error
IF %v%==1 GOTO import_world
IF %v%==2 GOTO import_char
IF %v%==3 GOTO dump_world
IF %v%==4 GOTO dump_char
IF %v%==5 GOTO updates
IF %v%==6 GOTO locals
IF %v%==M GOTO begin
IF %v%==m GOTO begin
IF %v%==7 GOTO top
IF %v%==x GOTO exit
IF %v%==X GOTO exit
IF %v%=="" GOTO exit
GOTO error

:SKYREBASE
CLS
ECHO.
ECHO          ษออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO          บ                                                บ
ECHO          บ      Please Choose an option for your DB       บ
ECHO          บ                                                บ
ECHO          บ  1. Install REBASE DB                          บ
ECHO          บ     Note: This will wipe old DB!               บ
ECHO          บ  2. Install clean REBASE Char DB               บ
ECHO          บ                                                บ
ECHO          บ  3. Backup REBASE WORLD DB                     บ
ECHO          บ  4. Backup REBASE Character DB                 บ
ECHO          บ                                                บ
ECHO          บ  5. Apply Updates             %upstat%         บ
ECHO          บ                                                บ
ECHO          บ  7. Change Settings                            บ
ECHO          บ                                                บ
ECHO          บ  M. Return back to Main DB Selection           บ
ECHO          บ                                                บ
ECHO          บ  X  Exit Install tool                          บ
ECHO          บ                                                บ
ECHO          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO.

SET /p v= 		Enter a char: 
IF %v%==1 GOTO import_rworld
IF %v%==2 GOTO import_rchar
IF %v%==M GOTO begin
IF %v%==m GOTO begin
IF %v%==7 GOTO top

IF %v%==3 GOTO dump_rworld
IF %v%==4 GOTO dump_rchar
IF %v%==5 GOTO updates


IF %v%==x GOTO exit
IF %v%==X GOTO exit
IF %v%=="" GOTO exit
GOTO error

:import_world
CLS
ECHO First Lets Create database (or overwrite old) !!
ECHO.
ECHO DROP database IF EXISTS `%world_db%`; > %devsql%\databaseclean.sql
ECHO CREATE database IF NOT EXISTS `%world_db%`; >> %devsql%\databaseclean.sql
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %devsql%\databaseclean.sql
@DEL %devsql%\databaseclean.sql

ECHO Lets make a clean database.
ECHO Importing new DB Data now...
ECHO.
ECHO. Adding Stored Procedures
for %%C in (%procsql%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Stored Procedures imported sucesfully!
ECHO.
ECHO Installing World Data
FOR %%C IN (%devsql%\*.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Successfully imported %%~nxC
)
ECHO.
ECHO import: Critical Updates
for %%C in (%changsql%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Updates imported sucesfully!
ECHO.
ECHO Your Installation is complete, your current db is CCDB version %dbrev% 
ECHO.
ECHO Thank you for using CCDB, Enjoy
ECHO.
ECHO.
PAUSE
GOTO Begin



:import_char
CLS
ECHO First Lets Create database (or overwrite old) !!
ECHO.
ECHO DROP database IF EXISTS `%char_db%`; > %devcsql%\databaseclean.sql
ECHO CREATE database IF NOT EXISTS `%char_db%`; >> %devcsql%\databaseclean.sql
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %devcsql%\databaseclean.sql
@DEL %devcsql%\databaseclean.sql

ECHO Lets make a clean database.
ECHO Importing Data now...
ECHO.
ECHO.
ECHO Installing Character Data
FOR %%C IN (%devcsql%\*.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %char_db% < "%%~fC"
	ECHO Successfully imported %%~nxC
)
ECHO.
ECHO    You now have a clean character db
ECHO.
ECHO.
ECHO.
ECHO.
PAUSE
GOTO Begin

:dump_world
CLS
IF NOT EXIST "%dumppath%" MKDIR %wdumppath%
ECHO %world_db% Database Export started...

FOR %%a IN ("%devsql%\*.sql") DO SET /A Count+=1
setlocal enabledelayedexpansion
FOR %%C IN (%devsql%\*.sql) DO (
	SET /A Count2+=1
	ECHO Dumping [!Count2!/%Count%] %%~nC
	%mysqlpath%\mysqldump --host=%host% --user=%user% --password=%pass% --port=%port% --skip-comments %world_db% %%~nC > %wdumppath%\%%~nxC
)
endlocal 

ECHO  Finished ... %world_db% exported to %wdumppath% folder...
PAUSE
GOTO begin

:dump_char
CLS
IF NOT EXIST "%cdumppath%" MKDIR %cdumppath%
ECHO %char_db% Database Export started...

FOR %%a IN ("%devcsql%\*.sql") DO SET /A Count+=1
setlocal enabledelayedexpansion
FOR %%C IN (%devcsql%\*.sql) DO (
	SET /A Count2+=1
	ECHO Dumping [!Count2!/%Count%] %%~nC
	%mysqlpath%\mysqldump --host=%host% --user=%user% --password=%pass% --port=%port% --skip-comments %char_db% %%~nC > %cdumppath%\%%~nxC
)
endlocal 

ECHO  Finished ... %char_db% exported to %cdumppath% folder...
PAUSE
GOTO begin

:locals
CLS
ECHO          ษออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO          บ                                                บ
ECHO          บ      Please select your language               บ
ECHO          บ                                                บ
ECHO          บ     S.          Spanish   "Some Data Applied"  บ
ECHO          บ                                                บ
ECHO          บ     G.          German    "No Data Yet"        บ
ECHO          บ                                                บ
ECHO          บ     R.          Russian   "No Data Yet"        บ
ECHO          บ                                                บ
ECHO          บ     I.          Italian   "Some Data Applied"  บ
ECHO          บ                                                บ
ECHO          บ     F.          French    "Some Data Applied"  บ
ECHO          บ                                                บ
ECHO          บ     B.          Main Menu                      บ
ECHO          บ                                                บ
ECHO          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO.
set /p ch=      Letter: 
ECHO.
IF %ch%==s GOTO install_sp
IF %ch%==S GOTO install_sp
IF %ch%==g GOTO install_gr
IF %ch%==G GOTO install_gr
IF %ch%==r GOTO install_ru
IF %ch%==R GOTO install_ru
IF %ch%==i GOTO install_it
IF %ch%==I GOTO install_it
IF %ch%==f GOTO install_fr
IF %ch%==F GOTO install_fr
IF %ch%==b GOTO begin
IF %ch%==B GOTO begin
IF %ch%=="" GOTO locals
GOTO error

:install_sp
ECHO Importing Spanish Data now...
ECHO.
FOR %%C IN (%local_sp%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Spanish Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_gr
ECHO Importing German Data now...
ECHO.
FOR %%C IN (%local_sp%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO German Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_ru
ECHO Importing Russian Data now...
ECHO.
FOR %%C IN (%local_sp%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Russian Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_it
ECHO Importing Italian Data now...
ECHO.
FOR %%C IN (%local_it%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Italian Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:install_fr
ECHO Importing French Data now...
ECHO.
FOR %%C IN (%local_fr%\*.sql) DO (
	ECHO Importing: %%~nxC1
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO French Locals Successfully imported %%~nxC1
)
ECHO Done.
GOTO Begin

:dumpchar
CLS
SET sqlname=char-%DATE:~0,3% - %DATE:~4,2%-%DATE:~7,2%-%DATE:~10,4%--%TIME:~0,2%-%TIME:~3,2%
SET /p chardb=   Enter name of your character DB:
ECHO.
IF NOT EXIST "%dumppath%" MKDIR %dumppath%
ECHO Dumping %sqlname%.sql to %dumppath%
%mysqlpath%\mysqldump -u%user% -p%pass% --routines --skip-comments --result-file="%dumppath%\%sqlname%.sql" %chardb%
ECHO Done.
PAUSE
GOTO begin

:updates
CLS
ECHO.
ECHO.   
ECHO.
ECHO          ษออออออออออออออออออออออออออออออออออออออออออออออออป
ECHO          บ                                                บ
ECHO          บ                CCDB UPDATES                    บ
ECHO          บ                                                บ
ECHO          บ      Please select your Choice                 บ
ECHO          บ                                                บ
ECHO          บ     1.          CCDB Original Updates          บ
ECHO          บ                                                บ
ECHO          บ     2.          CCDB Rebase Updates            บ
ECHO          บ                                                บ
ECHO          บ     5.          Main Menu                      บ
ECHO          บ                                                บ
ECHO          ศออออออออออออออออออออออออออออออออออออออออออออออออผ
ECHO.
ECHO.
set /p ch=      Number: 
ECHO.
IF %ch%==1 GOTO orig_update
IF %ch%==2 GOTO reba_update
IF %ch%==5 GOTO begin
IF %ch%=="" GOTO Updates
GOTO error


:orig_update
CLS
ECHO.
ECHO import: CCDB Original DB updates... 
for %%C in (%orig_update%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Your CCDB Original DB has been updated...
ECHO.
PAUSE   
GOTO begin

:reba_update
CLS
ECHO.
ECHO import: CCDB Rebase DB updates...
for %%C in (%reba_update%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Your CCDB Rebase DB has been updated...
ECHO.
PAUSE   
GOTO begin

:error
ECHO	Please enter a correct character.
ECHO.
PAUSE
GOTO begin

:error2
ECHO	Changeset with this number not found.
ECHO.
PAUSE
GOTO begin

:import_rworld
CLS
ECHO First Lets Create database (or overwrite old) !!
ECHO.
ECHO DROP database IF EXISTS `%world_db%`; > %rebworl%\databaseclean.sql
ECHO CREATE database IF NOT EXISTS `%world_db%`; >> %rebworl%\databaseclean.sql
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %rebworl%\databaseclean.sql
@DEL %rebworl%\databaseclean.sql

ECHO Lets make a clean database.
ECHO Importing new DB Data now...
ECHO.
ECHO. Adding Stored Procedures
for %%C in (%procsql%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Stored Procedures imported sucesfully!
ECHO.
ECHO Installing World Data
FOR %%C IN (%rebworl%\*.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
	ECHO Successfully imported %%~nxC
)
ECHO.
ECHO import: Critical Updates
for %%C in (%changsql%\*.sql) do (
	ECHO import: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Updates imported sucesfully!
ECHO.
ECHO Your Installation is complete, your current db is CCDB version %dbrev% 
ECHO.
ECHO Thank you for using CCDB, Enjoy
ECHO.
ECHO.
PAUSE
GOTO Begin



:import_rchar
CLS
ECHO First Lets Create database (or overwrite old) !!
ECHO.
ECHO DROP database IF EXISTS `%char_db%`; > %rebchar%\databaseclean.sql
ECHO CREATE database IF NOT EXISTS `%char_db%`; >> %rebchar%\databaseclean.sql
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% < %rebchar%\databaseclean.sql
@DEL %rebchar%\databaseclean.sql

ECHO Lets make a clean database.
ECHO Importing Data now...
ECHO.
ECHO.
ECHO Installing Character Data
FOR %%C IN (%rebchar%\*.sql) DO (
	ECHO Importing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %char_db% < "%%~fC"
	ECHO Successfully imported %%~nxC
)
ECHO.
ECHO    You now have a clean REBASE Character DB
ECHO.
ECHO.
ECHO.
ECHO.
PAUSE
GOTO Begin

:dump_rworld
CLS
IF NOT EXIST "%rwdumppath%" MKDIR %rwdumppath%
ECHO %world_db% Database Export started...

FOR %%a IN ("%rebworl%\*.sql") DO SET /A Count+=1
setlocal enabledelayedexpansion
FOR %%C IN (%rebworl%\*.sql) DO (
	SET /A Count2+=1
	ECHO Dumping [!Count2!/%Count%] %%~nC
	%mysqlpath%\mysqldump --host=%host% --user=%user% --password=%pass% --port=%port% --skip-comments %world_db% %%~nC > %rwdumppath%\%%~nxC
)
endlocal 

ECHO  Finished ... %world_db% exported to %wdumppath% folder...
PAUSE
GOTO begin

:dump_rchar
CLS
IF NOT EXIST "%rcdumppath%" MKDIR %rcdumppath%
ECHO %char_db% Database Export started...

FOR %%a IN ("%rebchar%\*.sql") DO SET /A Count+=1
setlocal enabledelayedexpansion
FOR %%C IN (%rebchar%\*.sql) DO (
	SET /A Count2+=1
	ECHO Dumping [!Count2!/%Count%] %%~nC
	%mysqlpath%\mysqldump --host=%host% --user=%user% --password=%pass% --port=%port% --skip-comments %char_db% %%~nC > %rcdumppath%\%%~nxC
)
endlocal 

ECHO  Finished ... %char_db% exported to %cdumppath% folder...
PAUSE
GOTO begin


:exit