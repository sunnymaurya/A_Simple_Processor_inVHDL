library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;   

entity memory is
port (
    enable		: 	in std_logic;
		read		:	in std_logic;
		write	:	in std_logic;
		address	:	in std_logic_vector(7 downto 0);
		data_in	:	in std_logic_vector(15 downto 0);
		data_out:	out std_logic_vector(15 downto 0)
);
end memory;

architecture behv of memory is			

  type ram_type is array (0 to 255) of 
        		std_logic_vector(15 downto 0);
  signal tmp_ram: ram_type;

begin
	

							
	writ: process(enable, read, address, data_in)
	begin
		if enable='1' then		
			tmp_ram <= (
							
						0=>  "0000000000000000",		
						1 => "0000001000000110",-- first instruction location			
						2 => "0000000100000111",--second 
						3 => "0000000000001000",	--and so on		
						4 => "0000000000000000",			
						5 => "0000000000000000",			
					  6=>"0000000001100100",---first operand
						7=>"0000000010010110",-- second						
						8 => "0000000000000000",-- third			
						others => "0000000000000000");
		else
			
				if (write ='1' and read = '0') then
					tmp_ram(conv_integer(address)) <= data_in;
				
			end if;
		end if;
	end process;

    rea: process(enable, read, address)
	begin
		if enable='1' then
			data_out <= (others=>'0');
		else
						if (read ='1' and write ='0') then								 
					data_out <= tmp_ram(conv_integer(address));
				end if;
		end if;
	end process;
end behv;
