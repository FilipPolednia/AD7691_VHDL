library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity spi_master_tb is
	-- Generic declarations of the tested unit
		generic(
		BUS_SIZE : INTEGER := 18 );
end spi_master_tb;

architecture TB_ARCHITECTURE of spi_master_tb is
	-- Component declaration of the tested unit
	component spi_master
		generic(
		BUS_SIZE : INTEGER := 18 );
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;
		ENABLE : in STD_LOGIC;
		RESET : in STD_LOGIC;
		MISO : in STD_LOGIC;
		MOSI : out STD_LOGIC;
		SCK : out STD_LOGIC;
		DATA_READY : out STD_LOGIC;
		DATA_OUT : out STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal CE : STD_LOGIC;
	signal ENABLE : STD_LOGIC;
	signal RESET : STD_LOGIC;
	signal MISO : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal MOSI : STD_LOGIC;
	signal SCK : STD_LOGIC;
	signal DATA_READY : STD_LOGIC;
	signal DATA_OUT : STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : spi_master
		generic map (
			BUS_SIZE => BUS_SIZE
		)

		port map (
			CLK => CLK,
			CE => CE,
			ENABLE => ENABLE,
			RESET => RESET,
			MISO => MISO,
			MOSI => MOSI,
			SCK => SCK,
			DATA_READY => DATA_READY,
			DATA_OUT => DATA_OUT
		);

	-- Add your stimulus here ...
	STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time>

	RESET <= '1';
    wait for 200 ns; --0 fs --ZMIANA NA ASYNCHR
   	RESET <= '0';
	ENABLE <= '1';   
	wait for 2000 ns;
	
	MISO <= '1';	 --1
	wait for 50 ns;
	MISO <= '0';	 --2
	wait for 50 ns;
	MISO <= '0';	 --3
	wait for 50 ns;
	MISO <= '1';	 --4
	wait for 50 ns;
	MISO <= '0';	 --5
	wait for 50 ns;
	MISO <= '0';	 --6
	wait for 50 ns;
	MISO <= '1';	 --7
	wait for 50 ns;
	MISO <= '0';	 --8
	wait for 50 ns;
	MISO <= '0';	 --9
	wait for 50 ns;
	MISO <= '1';	 --10
	wait for 50 ns;
	MISO <= '0';	 --11
	wait for 50 ns;
	MISO <= '0';	 --12
	wait for 50 ns;
	MISO <= '1';	 --13
	wait for 50 ns;
	MISO <= '0';	 --14
	wait for 50 ns;
	MISO <= '0';	 --15
	wait for 50 ns;
	MISO <= '1';	 --16
	wait for 50 ns;
	MISO <= '0';	 --17
	wait for 50 ns;
	MISO <= '0';	 --18
	wait for 400 ns;	   
	
	
	MISO <= '1';	 --1
	wait for 50 ns;
	MISO <= '1';	 --2
	wait for 50 ns;
	MISO <= '0';	 --3
	wait for 50 ns;
	MISO <= '1';	 --4
	wait for 50 ns;
	MISO <= '1';	 --5
	wait for 50 ns;
	MISO <= '0';	 --6
	wait for 50 ns;
	MISO <= '1';	 --7
	wait for 50 ns;
	MISO <= '1';	 --8
	wait for 50 ns;
	MISO <= '0';	 --9
	wait for 50 ns;
	MISO <= '1';	 --10
	wait for 50 ns;
	MISO <= '1';	 --11
	wait for 50 ns;
	MISO <= '0';	 --12
	wait for 50 ns;
	MISO <= '1';	 --13
	wait for 50 ns;
	MISO <= '1';	 --14
	wait for 50 ns;
	MISO <= '0';	 --15
	wait for 50 ns;
	MISO <= '1';	 --16
	wait for 50 ns;
	MISO <= '0';	 --17
	wait for 50 ns;
	MISO <= '1';	 --18
	wait for 50 ns;
	
	
    wait for 2 us; --200 ns
--	end of stimulus events
	wait;
end process; -- end of stimulus process
	
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_spi_master of spi_master_tb is
	for TB_ARCHITECTURE
		for UUT : spi_master
			use entity work.spi_master(logic);
		end for;
	end for;
end TESTBENCH_FOR_spi_master;

