call C:\Programs\Xilinx\Vivado\2019.2\settings64.bat
rd /s /q vivado_project
vivado -mode=batch -nojournal -nolog -source vivado_project.tcl