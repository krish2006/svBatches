@echo off
setlocal

:: --- 1. SET YOUR OSS CAD SUITE PATH HERE ---
:: Example: set OSS_CAD_PATH=C:\Users\YourName\Downloads\oss-cad-suite
set OSS_CAD_PATH=C:\path\to\your\oss-cad-suite

:: --- 2. Input Validation ---
if "%~3"=="" (
    echo Error: Not enough arguments.
    echo Usage: run_sv.bat ^<top_module^> ^<design.sv^> ^<testbench.sv^>
    echo Example: run_sv.bat nrca rca.sv tb_nrca.sv
    exit /b 1
)

set TOP_MODULE=%1
shift
set SV_FILES=%1 %2

:: --- 3. Initialize OSS CAD Suite Environment ---
echo ========================================
echo  Initializing OSS CAD Suite...
echo ========================================
call "%OSS_CAD_PATH%\environment.bat"

:: --- 4. Phase 1: Compile ---
echo ========================================
echo  Phase 1: Compiling Icarus Verilog
echo ========================================
iverilog -g2012 -o sim.vvp %SV_FILES%
if %errorlevel% neq 0 (
    echo Compilation failed!
    exit /b %errorlevel%
)

:: --- 5. Phase 2: Simulate ---
echo ========================================
echo  Phase 2: Running Simulation
echo ========================================
vvp sim.vvp
if %errorlevel% neq 0 (
    echo Simulation failed!
    exit /b %errorlevel%
)

:: --- 6. Phase 3: Yosys Synthesis ---
echo ========================================
echo  Phase 3: Yosys Synthesis
echo ========================================
:: Create the temporary Yosys build script
echo read_verilog -sv %SV_FILES% > build.ys
echo prep -top %TOP_MODULE% >> build.ys
echo show -format svg -prefix %TOP_MODULE%_schematic >> build.ys

yosys -q build.ys
del build.ys
echo Schematic saved to: %TOP_MODULE%_schematic.svg

:: --- 7. Phase 4: GTKWave ---
echo ========================================
echo  Phase 4: Opening GTKWave
echo ========================================
if exist "dump.vcd" (
    start gtkwave dump.vcd
) else (
    echo Warning: dump.vcd not found.
)

echo All Done!
endlocal