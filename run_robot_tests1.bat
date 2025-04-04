bat
@echo off
setlocal enabledelayedexpansion

:: ไปที่โฟลเดอร์ที่ .bat อยู่
cd /d D:\Project\Robot_lab

:: วันที่วันนี้ในรูปแบบ YYYYMMDD
for /f %%i in ('powershell -command "Get-Date -Format yyyyMMdd"') do set TODAY=%%i
:: วันที่+เวลา สำหรับใช้ในชื่อโฟลเดอร์
for /f %%i in ('powershell -command "Get-Date -Format yyyyMMdd_HHmmss"') do set DATETIME=%%i

:: ตั้งชื่อโฟลเดอร์รายงานและ backup
set Test_DIR=Test
set RESULT_DIR=!Test_DIR!\Result_!DATETIME!
set BACKUP_DIR=!Test_DIR!\Backup_!DATETIME!

:: สร้างโฟลเดอร์ผลลัพธ์
mkdir "!RESULT_DIR!"

:: รัน Robot Framework และเก็บผลลัพธ์ในโฟลเดอร์ที่สร้างขึ้น
robot --outputdir !RESULT_DIR!\1_Results_demo1 --RunEmptySuite Test\demo1.robot
robot --outputdir !RESULT_DIR!\1_Results_demo2 --RunEmptySuite Test\demo2.robot

:: สร้างโฟลเดอร์ backup ภายใน Test
mkdir "!BACKUP_DIR!"

:: คัดลอกผลลัพธ์ทั้งหมดไปยังโฟลเดอร์ backup
for /D %%f in (!RESULT_DIR!\*_Results_*) do (
    xcopy /E /I /Y "%%f" "!BACKUP_DIR!\%%~nxf"
)

:: ลบโฟลเดอร์ผลลัพธ์หลังจาก backup
rmdir /S /Q "!RESULT_DIR!"

echo Backup Completed !BACKUP_DIR!
pause