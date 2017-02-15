LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity spi_master is
	generic (
		BUS_SIZE : integer := 18);	-- size of data bus
	port(
	
		CLK : IN STD_LOGIC; 		-- clock 100MHz
		CE : IN STD_LOGIC; 		-- prescaler clock enable
		ENABLE : IN STD_LOGIC; 		-- enable reading from adc
		RESET : IN STD_LOGIC;		-- reset //asynchronous
		
		MISO : IN STD_LOGIC; 		-- data input from ADC
		MOSI : OUT STD_LOGIC; 		-- signal to ADC (to start sending data)
		SCK	: OUT STD_LOGIC; 	-- adc clock
		DATA_READY : OUT STD_LOGIC; 	-- ready signal for memory
		
		DATA_OUT : OUT STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0) -- data output
		);
end spi_master;


architecture logic of spi_master is					
	
	-- internal signals and constants
	type machine is(ready, execute);				-- state machine
	signal state : machine;
	signal DATA : STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0); 		-- data vector
	signal DATA_COUNTER_VEC : STD_LOGIC_VECTOR(5 downto 0);		-- to count data bits received from slave
	signal MOSI_INTERNAL : STD_LOGIC;				-- internal signals for process	
	signal SCK_INTERNAL : STD_LOGIC;
	signal READY_INTERNAL : STD_LOGIC;
	constant convert_time : integer := 100;				-- number of clock ticks (convert signal length)
begin	
	process (CLK, RESET)
		variable cpu_counter : integer := 0;			-- variables to check completeness of received data
		variable data_counter : integer := 0;
	begin 
		if RESET = '1' then					-- asynchronous reset
			DATA <= (others =>'0');				-- clear all data
			MOSI_INTERNAL <= '0';
			cpu_counter := 0;
			data_counter := 0;
			DATA_COUNTER_VEC <= 0;
			SCK_INTERNAL <= 0;
			state <= ready;					-- go to ready state
		elsif CLK'event and CLK = '1' then			-- CLK rising edge trigger
			cpu_counter := cpu_counter + 1;			-- counts every clk tick (to compute lenght of convert signal)
			case state is					
				when ready => 					-- state sending convert (data request) signal to adc
					READY_INTERNAL <= '0';
					if cpu_counter > convert_time then	
						MOSI <= '0';			-- end convert signal
						cpu_counter := 0;		-- clear variable
						state <= execute;		-- go to collecting data state
					else
						MOSI <= '1';			-- else keep sending convert signal
					end if;
				when execute =>					-- state collecting data from slave
					if CE = '1' then			-- clocking with prescaler
						if data_counter < (2*(BUS_SIZE)-1) then			-- check number of received bits
							data_counter := data_counter + 1;		-- up counting data bits
							DATA_COUNTER_VEC <= DATA_COUNTER_VEC + 1;	-- increment counter vector (*)
							SCK_INTERNAL <= not SCK_INTERNAL;		-- generate spi clock
						
						-- (*) this loop is clocked with 2 times greater frequency than spi clock bus
						-- using parity bit of DATA_COUNTER_VEC to trigger fifo module to synchronize 
						-- moment of spi clock triggering and read-out of data from slave and generate
						-- final spi clock signal

						end if;
						if DATA_COUNTER_VEC(0) = '1' then			-- check parity bit of data counter
							DATA <= DATA(BUS_SIZE-2 downto 0) & MISO;	-- fifo register - shift left all
						end if;							-- 	     data and add new bit
						if data_counter = (2*(BUS_SIZE)-1) then			-- all data received
							READY_INTERNAL <= '1';				-- send data ready signal	
							data_counter := 0;				-- clear all temp
							DATA_COUNTER_VEC <= 0;
							SCK_INTERNAL <= '0';
							state <= ready;					-- go to ready state
					end if;
			end case;			
		end if;		
	end process; 
	
	-- write internal signals to output ports
	DATA_READY <= READY_INTERNAL; 			
	DATA_OUT <= DATA;
	MOSI <= MOSI_INTERNAL;
	SCK <= SCK_INTERNAL;
	
end logic;
