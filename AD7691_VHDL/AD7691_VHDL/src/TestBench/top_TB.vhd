library ieee;
use ieee.STD_LOGIC_SIGNED.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity top_tb is
end top_tb;

architecture TB_ARCHITECTURE of top_tb is
	-- Component declaration of the tested unit
	component top
	port(
		CE : in STD_LOGIC;
		CLK : in STD_LOGIC;
		ENABLE : in STD_LOGIC;
		MISO : in STD_LOGIC;
		RESET : in STD_LOGIC;
		HUNDREDS : out STD_LOGIC;
		LED_BIT0 : out STD_LOGIC;
		LED_BIT1 : out STD_LOGIC;
		MOSI : out STD_LOGIC;
		ONES : out STD_LOGIC;
		SCK : out STD_LOGIC;
		TENS : out STD_LOGIC;
		THOUSANDS : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CE : STD_LOGIC;
	signal CLK : STD_LOGIC;
	signal ENABLE : STD_LOGIC;
	signal MISO : STD_LOGIC;
	signal RESET : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal HUNDREDS : STD_LOGIC;
	signal LED_BIT0 : STD_LOGIC;
	signal LED_BIT1 : STD_LOGIC;
	signal MOSI : STD_LOGIC;
	signal ONES : STD_LOGIC;
	signal SCK : STD_LOGIC;
	signal TENS : STD_LOGIC;
	signal THOUSANDS : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : top
		port map (
			CE => CE,
			CLK => CLK,
			ENABLE => ENABLE,
			MISO => MISO,
			RESET => RESET,
			HUNDREDS => HUNDREDS,
			LED_BIT0 => LED_BIT0,
			LED_BIT1 => LED_BIT1,
			MOSI => MOSI,
			ONES => ONES,
			SCK => SCK,
			TENS => TENS,
			THOUSANDS => THOUSANDS
		);

	-- Add your stimulus here ...
	STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time>

	RESET <= '1';
	CE <= '1';
    wait for 200 ns; --0 fs --ZMIANA NA ASYNCHR
   	RESET <= '0';
	ENABLE <= '1';   
	wait for 2250 ns;
	
	for i in 0 to 1024 loop 
	
	MISO <= '1';	 --1
	wait for 500 ns;
	MISO <= '0';	 --2
	wait for 500 ns;
	MISO <= '1';	 --3
	wait for 500 ns;
	MISO <= '0';	 --4
	wait for 500 ns;
	MISO <= '1';	 --5
	wait for 500 ns;
	MISO <= '0';	 --6
	wait for 500 ns;
	MISO <= '1';	 --7
	wait for 500 ns;
	MISO <= '0';	 --8
	wait for 500 ns;
	MISO <= '1';	 --9
	wait for 500 ns;
	MISO <= '0';	 --10
	wait for 500 ns;
	MISO <= '1';	 --11
	wait for 500 ns;
	MISO <= '0';	 --12
	wait for 500 ns;
	MISO <= '1';	 --13
	wait for 500 ns;
	MISO <= '0';	 --14
	wait for 500 ns;
	MISO <= '1';	 --15
	wait for 500 ns;
	MISO <= '0';	 --16
	wait for 500 ns;
	MISO <= '1';	 --17
	wait for 500 ns;
	MISO <= '0';	 --18
	wait for 2500 ns;

	end loop;
	
    wait for 2 us; --200 ns
--	end of stimulus events
	wait;
end process; -- end of stimulus process

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_top of top_tb is
	for TB_ARCHITECTURE
		for UUT : top
			use entity work.top(top);
		end for;
	end for;
end TESTBENCH_FOR_top;

