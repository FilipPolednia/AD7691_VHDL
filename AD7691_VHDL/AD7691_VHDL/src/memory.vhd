LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity memory is

  port(
    
	clk : IN STD_LOGIC;
	data_in : OUT STD_LOGIC_VECTOR(17 downto 0) -- data input
	data_out : OUT STD_LOGIC_VECTOR(17 downto 0) -- data output
	ready : OUT STD_LOGIC
	);
end memory;




architecture logic of memory is
type machine is(collect, send);
	signal state : machite;
	signal count : STD_LOGIC_VECTOR(9 downto 0); -- vector of averages count
	signal ready_sig : STD_LOGIC;				-- end of collecting and averaging
	signal data : STD_LOGIC_VECTOR(27 downto 0); -- internal data vector
	signal data_processed : STD_LOGIC_VECTOR(17 downto 0); -- data to send to output
begin
	process (clk, reset)
	begin 
		if reset = '1' then
			data <= (others =>'0');
			data_processed <= (others =>'0');
			count <= (others =>'0');
			ready_sig <= '0';
			state <= collect;
		elsif clock'event and clock = '1' then
			case state is
				when collect => 
					data <= std_logic_vector(unsigned(data) + unsigned(data_in)); -- data + data_in;
					count <= std_logic_vector(unsigned(count) + unsigned(d));		--count++	
					ready_sig <= '0';
					if count = '1111111111' then	--kiedy zbierze 1024 próbki
						state <= send;				--przejdź do stanu send
						count <= (others =>'0');	--wyczyść count
					end if;
				
				when send =>
					if data[9] = '1' then	--jeżeli 10 bit jest 1 to po dzieleniu dodaj 1 bo zaokrąglenia
						data_processed <= (data srl 10) + conv_std_logic_vector(1, 18);
					else
						data_processed <= (data srl 10);
					end if;
					data <= (others =>'0');		--wyczyść dane wew
					ready_sig <= '1';			--wystaw 1 na ready
			end case;	
		end if;
		
	end process; 
	
	data_out <= data_processed;				--przypisanie na wyjście


end logic;