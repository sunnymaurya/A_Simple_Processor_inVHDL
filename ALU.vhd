library	ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;			   
use ieee.std_logic_unsigned.all;

entity ALU is
    port (	num_A: in std_logic_vector(15 downto 0);
		num_B: 	in std_logic_vector(15 downto 0);
		Cin:	in std_logic;
		ALUs:	in std_logic_vector( 3 downto 0);
		ALUout:	out std_logic_vector(15 downto 0)
);
end ALU;
architecture arc of ALU is
    
signal temp: std_logic_vector(15 downto 0);
 begin
        process(num_A, Cin , num_B, ALUs)
 begin 
	    if (ALUs = "0000" and Cin='0') then
	     temp <= num_A;		
	elsif(ALUs = "0000" and Cin='1') then
	     temp <= num_A+1;	
	elsif (ALUs = "0001" and Cin='0') then
	     temp <= num_A+num_B;
	elsif (ALUs = "0001" and Cin='1') then
	     temp <= num_A+num_B+1;
	elsif (ALUs = "0010" and Cin='0') then
	     temp <= num_A+ not num_B;
	elsif (ALUs = "0010" and Cin='1') then
	     temp <= num_A+not num_B+1;	
	elsif (ALUs = "0011" and Cin='0') then
	     temp <= num_A-1;				    
   elsif (ALUs = "0011" and Cin='1') then
	     temp <= num_A;	     	
	elsif (ALUs = "0100" and Cin='-') then
	     temp <= num_A and num_B; 
	elsif (ALUs = "0101" and Cin='-') then
	     temp <= num_A or num_B;
	elsif (ALUs = "0110" and Cin='-') then
	     temp <= num_A xor num_B;
	elsif (ALUs = "0111" and Cin='-') then
	     temp <=  not num_A;
	else  
	
	end if;
	end process;
	ALUout <= temp;  
	end arc;