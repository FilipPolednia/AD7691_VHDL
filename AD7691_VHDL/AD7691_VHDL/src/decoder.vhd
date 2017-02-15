LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity decoder is
	generic (
		BUS_SIZE : integer := 18); 				-- size of data bus
	port(
		CLK : IN STD_LOGIC; 					-- clock 100MHz
		READY : IN STD_LOGIC; 					-- memory data ready signal
		RESET : IN STD_LOGIC; 					-- reset //asynchronous
		DATA_IN : IN STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0); 	-- data input
		
		TOTAL_PART : OUT STD_LOGIC_VECTOR(11 downto 0);		-- total data part
		FRACTION_PART0 : OUT STD_LOGIC;				-- fraction part bit0
		FRACTION_PART1 : OUT STD_LOGIC				-- fraction part bit1
		);							-- possible combinations: 00	X,00
end decoder;								--			  01	X,25
									--			  10	X,50
									--			  11	X,75
architecture logic of decoder is
	signal TOTAL_PART_INT : STD_LOGIC_VECTOR(11 downto 0);		-- internal temp signals
	signal FRACTION_PART_INT0 : STD_LOGIC;
	signal FRACTION_PART_INT1 : STD_LOGIC;
begin	
	process (READY, RESET)	
	begin 
		if RESET = '1' then					-- reset
			TOTAL_PART <= (others =>'0');
			FRACTION_PART0 <= '0';
			FRACTION_PART1 <= '0';
		elsif READY'event and READY = '1' then			-- clocking with memory READY signal
			FRACTION_PART_INT1 <= DATA_IN(6);		-- (*)
			FRACTION_PART_INT0 <= DATA_IN(5);		-- (*)
		 	TOTAL_PART_INT <= '0' & DATA_IN(17 downto 7);	-- (*)

	-- (*) every one meter height is 64LSB -> we can read the height change directly from bits 7 to 17, as total part. 
	-- We also use bits 5 and 6 to increase output resolution to 0.25m

		end if;		
	end process; 
	
	-- write to outputs
	TOTAL_PART <= TOTAL_PART_INT;
	FRACTION_PART1 <= FRACTION_PART_INT1;
	FRACTION_PART0 <= FRACTION_PART_INT0;
	
end logic;
