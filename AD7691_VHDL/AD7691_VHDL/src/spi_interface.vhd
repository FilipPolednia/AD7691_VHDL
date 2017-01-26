LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity spi_master is
	generic (
		BUS_SIZE : integer := 18);
	port(
	
		CLK : IN STD_LOGIC; -- clock 100MHz
		CE : IN STD_LOGIC; -- prescaler clock enable
		ENABLE : IN STD_LOGIC; -- enable reading from adc
		RESET : IN STD_LOGIC; -- reset //asynchronous
		
		MISO : IN STD_LOGIC; -- data input from ADC
		MOSI : OUT STD_LOGIC; -- signal to ADC (to start sending data)
		SCK	: OUT STD_LOGIC; -- adc clock
		DATA_READY : OUT STD_LOGIC; --ready signal for memory
		
		DATA_OUT : OUT STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0) -- data output
		);
end spi_master;


architecture logic of spi_master is
	type machine is(ready, execute);
	signal state : machine;
	signal DATA : STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0); -- data vector
	signal MOSI_INT : STD_LOGIC;
	signal DATA_COUNTER_VEC : STD_LOGIC_VECTOR(5 downto 0);
	signal SCK_INTERNAL : STD_LOGIC;
	signal READY_INTERNAL : STD_LOGIC;
	constant convert_time : integer := 100; -- clk ticks
begin	
	process (CLK, RESET)
		variable cpu_counter : integer := 0;
		variable data_counter : integer := 0;
	begin 
		if RESET = '1' then
			DATA <= (others =>'0');
			MOSI_INT <= '0';
			state <= ready;
		elsif CLK'event and CLK = '1' then
			cpu_counter := cpu_counter + 1;
			case state is
				when ready =>
					READY_INTERNAL <= '0';
					if cpu_counter > convert_time then
						MOSI <= '0';
						cpu_counter := 0;
						state <= execute;
					else
						MOSI <= '1';
					end if;
				when execute =>
					if CE = '1' then
						if data_counter < (2*(BUS_SIZE)-1) then
							data_counter := data_counter + 1;
							DATA_COUNTER_VEC <= DATA_COUNTER_VEC + 1;
							SCK_INTERNAL <= not SCK_INTERNAL;
						end if;
						if DATA_COUNTER_VEC(0) = '1' then
							DATA <= DATA(BUS_SIZE-2 downto 0) & MISO;
						end if;
						READY_INTERNAL <= '1';
					end if;
			end case;			
		end if;		
	end process; 
	DATA_READY <= READY_INTERNAL;
	DATA_OUT <= DATA;
	MOSI <= MOSI_INT;
	SCK <= SCK_INTERNAL;
	
end logic;