LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.all;

entity memory is

  port(
    
  	clk : IN STD_LOGIC;		  
  	reset: IN STD_LOGIC;
	new_data: IN STD_LOGIC;
	data_in : IN STD_LOGIC_VECTOR(17 downto 0); -- data input
	data_out : OUT STD_LOGIC_VECTOR(17 downto 0); -- data output
	ready : OUT STD_LOGIC	  
	);
end memory;




architecture logic of memory is
type machine is(collect, send, save);
	signal state : machine;
	signal save_val_sig : STD_LOGIC;
	signal zero_level_sig : STD_LOGIC_VECTOR(27 downto 0);
	signal difference : STD_LOgic_vector(27 downto 0);
	signal ready_sig : STD_LOGIC;				-- end of collecting and averaging
	signal data : STD_LOGIC_VECTOR(27 downto 0); -- internal data vector
	signal data_processed : STD_LOGIC_VECTOR(17 downto 0); -- data to send to output
begin
	process (clk, reset)   
	variable count : INTEGER; -- vector of averages count
	begin 				   
		if reset = '1' then
			data <= (others =>'0');
			data_processed <= (others =>'0');
			count := 0;
			ready_sig <= '0';
			save_val_sig <= '1';
			state <= collect;
		elsif clk'event and clk = '1' then
			case state is
				when collect => 
					if new_data = '1' then
						--data <= std_logic_vector(signed(data) + signed(data_in)); 	-- data + data_in;	  
						data <= data + data_in;
						--count <= std_logic_vector(unsigned(count) + unsigned(1));		--count++	
						count := count + 1;
						ready_sig <= '0';					
						if count = 1023 then	--kiedy zbierze 1024 prołbki	
							count := 0;	--wyczyĹ›Ä‡ count
							if save_val_sig = '1' then
								state <= save;
							end if;
							state <= send;				--przejdĹş do stanu send
						end if;
					end if;	 
					
				when send =>
					if data(9) = '1' then	--jeżeli 10 bit jest 1 to po dzieleniu dodaj 1 bo zaokrÄ…glenia
						--data_processed <= (data srl 10) + conv_std_logic_vector(1, 18);
						difference <= data - zero_level_sig; --(27 downto 10) + 1;
						data_processed <= difference(27 downto 10) + 1;
					else
						difference <= data - zero_level_sig; --(27 downto 10) + 1;
						data_processed <= difference(27 downto 10);
					end if;
					data <= (others =>'0');		--wyczysc dane wewnetrzne
					ready_sig <= '1';			--wystaw 1 na ready
					state <= collect;	 
				
				when save =>
					zero_level_sig <= data;
					data <= (others =>'0');		--wyczysc dane wewnetrzne
					state <= collect; 
					save_val_sig <= '0';
				end case;
		end if;
		
	end process; 
	
	data_out <= data_processed;				--przypisanie na wyjscie			  
	ready <= ready_sig;


end logic;
