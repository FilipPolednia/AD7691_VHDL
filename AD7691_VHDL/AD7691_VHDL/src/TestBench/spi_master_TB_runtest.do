SetActiveLib -work
comp -include "$dsn\src\spi_interface.vhd" 
comp -include "$dsn\src\TestBench\spi_master_TB.vhd" 
asim +access +r TESTBENCH_FOR_spi_master 
wave 
wave -noreg CLK
wave -noreg CE
wave -noreg ENABLE
wave -noreg RESET
wave -noreg MISO
wave -noreg MOSI
wave -noreg SCK
wave -noreg DATA_READY
wave -noreg DATA_OUT
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\spi_master_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_spi_master 
