library	ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;			   
use ieee.std_logic_unsigned.all;

entity ControlUnit is
 
 port(instruct : in std_logic_vector(10 downto 0);
      op_address: out std_logic_vector(7 downto 0);
      opcode : out std_logic_vector(3 downto 0)
       );
end ControlUnit;       

architecture arc of ControlUnit is

signal temp: std_logic_vector(3 downto 0);
begin 
process(instruct)
begin

op_address<=instruct(7 downto 0);
if(instruct(10 downto 8)="000") then
temp<="0100";
elsif(instruct(10 downto 8)="001") then
temp<="0001";
elsif(instruct(10 downto 8)="010") then
temp<="0000";
elsif(instruct(10 downto 8)="011") then
temp<="0000";
elsif(instruct(10 downto 8)="100") then
temp<="0011";
elsif(instruct(10 downto 8)="101") then
temp<="0101";
elsif(instruct(10 downto 8)="110") then
temp<="0110";
end if;
end process;
opcode<=temp;
end arc;


       