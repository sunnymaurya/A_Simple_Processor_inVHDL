library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity IR is
generic (n : integer := 11;
propagation_delay : time := 10 ns);

port ( inputs : IN std_logic_vector (n-1 downto 0);
outputs : OUT std_logic_vector (n-1 downto 0);
inEn ,clear, load, outputEn : IN bit );

end IR ;

Architecture BehavioralReg of IR is

Signal temp : std_logic_vector (n-1 downto 0);

begin

Process1: process (inEn)
  begin
   if (clear = '1') then
  temp <="00000000000" ;
else 
if (load = '1' and inEn='1') then temp <= inputs ; end if; 
if (outputEn = '1') then outputs <= temp; end if;
end if;
end process Process1;

end BehavioralReg;