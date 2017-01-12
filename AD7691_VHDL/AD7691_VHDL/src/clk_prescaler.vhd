-------------------------------------------------------------------------------
--
-- Title       : Prescaler
-- Design      : TutorVHDL
-- Author      : PJR & JK
-- Company     : AGH
--
-------------------------------------------------------------------------------
--
-- Description : Synchronous prescaler circuit
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity Prescaler is
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLR : in STD_LOGIC;
		CEO : out STD_LOGIC
		);	   
end Prescaler;



architecture Prescaler of Prescaler is

signal DIVIDER: std_logic_vector(27 downto 0);	-- internal divider register 
constant divide_factor: integer := 1000000;			-- divide factor user constant
												-- remember to adjust lenght of DIVIDER register when divide_factor is being changed

begin 
	process (CLK, CLR)
	begin
		if CLR = '1' then
			DIVIDER <= (others => '0');
		elsif CLK'event and CLK = '1' then
			if CE = '1' then
				if DIVIDER = (divide_factor-1) then
					DIVIDER <= (others => '0');
				else
					DIVIDER <= DIVIDER + 1;
				end if;
			end if;
		end if;
	end process;

CEO <= '1' when DIVIDER = (divide_factor-1) and CE = '1' else '0';
	
end Prescaler;