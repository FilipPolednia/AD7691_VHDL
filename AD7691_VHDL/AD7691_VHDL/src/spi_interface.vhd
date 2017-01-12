LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity spi_master is

  port(
    
	CLK : IN STD_LOGIC; -- spi clock 50kHz  
	ENABLE : IN STD_LOGIC; -- enable reading from adc
	RESET : IN STD_LOGIC; -- reset //asynchronous
	
	MISO : IN STD_LOGIC; -- data input from ADC
	MOSI : OUT STD_LOGIC; -- signal to ADC (to start sending data)

	DATA_OUT : OUT STD_LOGIC_VECTOR(17 downto 0) -- data output
	);
end spi_master;




architecture logic of spi_master is
	type machine is(ready, execute);
	signal state : machite;
	signal DATA : STD_LOGIC_VECTOR(17 downto 0); -- data vector
	signal MOSI_INT : STD_LOGIC;
begin

	process (CLK, RESET)
	begin 
		if RESET = '1' then
			DATA <= (others =>'0');
			MOSI_INT <= '0';
			state <= ready;
		elsif clock'event and clock = '1' then
			when ready =>
				
			
			
			
		end if;
		
	end process; 
	
	DATA_OUT <= DATA;
	MOSI <= MOSI_INT;


end logic;