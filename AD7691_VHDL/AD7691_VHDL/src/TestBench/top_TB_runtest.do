SetActiveLib -work
comp -include "$dsn\src\hex2led.vhd" 
comp -include "$dsn\src\bin2bcd.vhd" 
comp -include "$dsn\src\decoder.vhd" 
comp -include "$dsn\src\memory.vhd" 
comp -include "$dsn\src\clk_prescaler.vhd" 
comp -include "$dsn\src\spi_interface.vhd" 
comp -include "$dsn\src\top.bde" 
comp -include "$dsn\src\TestBench\top_TB.vhd" 
asim +access +r TESTBENCH_FOR_top 
wave 
wave -noreg CE
wave -noreg CLK
wave -noreg ENABLE
wave -noreg MISO
wave -noreg RESET
wave -noreg HUNDREDS
wave -noreg LED_BIT0
wave -noreg LED_BIT1
wave -noreg MOSI
wave -noreg ONES
wave -noreg SCK
wave -noreg TENS
wave -noreg THOUSANDS
wave -noreg CEO
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\top_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_top 
