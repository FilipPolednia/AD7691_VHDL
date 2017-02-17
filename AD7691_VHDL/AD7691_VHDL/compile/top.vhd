-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : AD7691_VHDL
-- Author      : KE
-- Company     : AGH
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\MKFP\projekt\AD7691_VHDL\AD7691_VHDL\compile\top.vhd
-- Generated   : Fri Feb 17 12:16:10 2017
-- From        : C:\My_Designs\MKFP\projekt\AD7691_VHDL\AD7691_VHDL\src\top.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;


entity top is
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
       THOUSANDS : out STD_LOGIC
  );
end top;

architecture top of top is

---- Component declarations -----

component bcd2led
  port (
       bcd : in STD_LOGIC_VECTOR(3 downto 0);
       clk : in STD_LOGIC;
       segment7 : out STD_LOGIC_VECTOR(6 downto 0)
  );
end component;
component bin2bcd_12bit
  port (
       binIN : in STD_LOGIC_VECTOR(11 downto 0);
       hundreds : out STD_LOGIC_VECTOR(3 downto 0);
       ones : out STD_LOGIC_VECTOR(3 downto 0);
       tens : out STD_LOGIC_VECTOR(3 downto 0);
       thousands : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component decoder
  generic(
       BUS_SIZE : INTEGER := 18
  );
  port (
       DATA_IN : in STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0);
       READY : in STD_LOGIC;
       RESET : in STD_LOGIC;
       FRACTION_PART0 : out STD_LOGIC;
       FRACTION_PART1 : out STD_LOGIC;
       TOTAL_PART : out STD_LOGIC_VECTOR(11 downto 0)
  );
end component;
component memory
  port (
       clk : in STD_LOGIC;
       data_in : in STD_LOGIC_VECTOR(17 downto 0);
       new_data : in STD_LOGIC;
       reset : in STD_LOGIC;
       data_out : out STD_LOGIC_VECTOR(17 downto 0);
       ready : out STD_LOGIC
  );
end component;
component Prescaler
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       CLR : in STD_LOGIC;
       CEO : out STD_LOGIC
  );
end component;
component spi_master
  generic(
       BUS_SIZE : INTEGER := 18
  );
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       ENABLE : in STD_LOGIC;
       MISO : in STD_LOGIC;
       RESET : in STD_LOGIC;
       DATA_OUT : out STD_LOGIC_VECTOR(BUS_SIZE-1 downto 0);
       DATA_READY : out STD_LOGIC;
       MOSI : out STD_LOGIC;
       SCK : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal NET416 : STD_LOGIC;
signal NET434 : STD_LOGIC;
signal NET51 : STD_LOGIC;
signal BUS144 : STD_LOGIC_VECTOR (17 downto 0);
signal BUS443 : STD_LOGIC_VECTOR (17 downto 0);
signal BUS566 : STD_LOGIC_VECTOR (11 downto 0);
signal BUS883 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS892 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS901 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS906 : STD_LOGIC_VECTOR (3 downto 0);

---- Declarations for Dangling outputs ----
signal DANGLING_U6_segment7_5 : STD_LOGIC;
signal DANGLING_U6_segment7_4 : STD_LOGIC;
signal DANGLING_U6_segment7_3 : STD_LOGIC;
signal DANGLING_U6_segment7_2 : STD_LOGIC;
signal DANGLING_U6_segment7_1 : STD_LOGIC;
signal DANGLING_U6_segment7_0 : STD_LOGIC;
signal DANGLING_U7_segment7_5 : STD_LOGIC;
signal DANGLING_U7_segment7_4 : STD_LOGIC;
signal DANGLING_U7_segment7_3 : STD_LOGIC;
signal DANGLING_U7_segment7_2 : STD_LOGIC;
signal DANGLING_U7_segment7_1 : STD_LOGIC;
signal DANGLING_U7_segment7_0 : STD_LOGIC;
signal DANGLING_U8_segment7_5 : STD_LOGIC;
signal DANGLING_U8_segment7_4 : STD_LOGIC;
signal DANGLING_U8_segment7_3 : STD_LOGIC;
signal DANGLING_U8_segment7_2 : STD_LOGIC;
signal DANGLING_U8_segment7_1 : STD_LOGIC;
signal DANGLING_U8_segment7_0 : STD_LOGIC;
signal DANGLING_U9_segment7_5 : STD_LOGIC;
signal DANGLING_U9_segment7_4 : STD_LOGIC;
signal DANGLING_U9_segment7_3 : STD_LOGIC;
signal DANGLING_U9_segment7_2 : STD_LOGIC;
signal DANGLING_U9_segment7_1 : STD_LOGIC;
signal DANGLING_U9_segment7_0 : STD_LOGIC;

begin

----  Component instantiations  ----

U1 : spi_master
  port map(
       CE => NET51,
       CLK => CLK,
       DATA_OUT => BUS144( 17 downto 0 ),
       DATA_READY => NET416,
       ENABLE => ENABLE,
       MISO => MISO,
       MOSI => MOSI,
       RESET => RESET,
       SCK => SCK
  );

U2 : Prescaler
  port map(
       CE => CE,
       CEO => NET51,
       CLK => CLK,
       CLR => RESET
  );

U3 : memory
  port map(
       clk => CLK,
       data_in => BUS144,
       data_out => BUS443,
       new_data => NET416,
       ready => NET434,
       reset => RESET
  );

U4 : decoder
  port map(
       DATA_IN => BUS443( 17 downto 0 ),
       FRACTION_PART0 => LED_BIT0,
       FRACTION_PART1 => LED_BIT1,
       READY => NET434,
       RESET => RESET,
       TOTAL_PART => BUS566
  );

U5 : bin2bcd_12bit
  port map(
       binIN => BUS566,
       hundreds => BUS901,
       ones => BUS883,
       tens => BUS892,
       thousands => BUS906
  );

U6 : bcd2led
  port map(
       segment7(0) => DANGLING_U6_segment7_0,
       segment7(1) => DANGLING_U6_segment7_1,
       segment7(2) => DANGLING_U6_segment7_2,
       segment7(3) => DANGLING_U6_segment7_3,
       segment7(4) => DANGLING_U6_segment7_4,
       segment7(5) => DANGLING_U6_segment7_5,
       segment7(6) => ONES,
       bcd => BUS883,
       clk => CLK
  );

U7 : bcd2led
  port map(
       segment7(0) => DANGLING_U7_segment7_0,
       segment7(1) => DANGLING_U7_segment7_1,
       segment7(2) => DANGLING_U7_segment7_2,
       segment7(3) => DANGLING_U7_segment7_3,
       segment7(4) => DANGLING_U7_segment7_4,
       segment7(5) => DANGLING_U7_segment7_5,
       segment7(6) => TENS,
       bcd => BUS892,
       clk => CLK
  );

U8 : bcd2led
  port map(
       segment7(0) => DANGLING_U8_segment7_0,
       segment7(1) => DANGLING_U8_segment7_1,
       segment7(2) => DANGLING_U8_segment7_2,
       segment7(3) => DANGLING_U8_segment7_3,
       segment7(4) => DANGLING_U8_segment7_4,
       segment7(5) => DANGLING_U8_segment7_5,
       segment7(6) => HUNDREDS,
       bcd => BUS901,
       clk => CLK
  );

U9 : bcd2led
  port map(
       segment7(0) => DANGLING_U9_segment7_0,
       segment7(1) => DANGLING_U9_segment7_1,
       segment7(2) => DANGLING_U9_segment7_2,
       segment7(3) => DANGLING_U9_segment7_3,
       segment7(4) => DANGLING_U9_segment7_4,
       segment7(5) => DANGLING_U9_segment7_5,
       segment7(6) => THOUSANDS,
       bcd => BUS906,
       clk => CLK
  );


end top;
