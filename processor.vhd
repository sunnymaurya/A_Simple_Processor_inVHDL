--processor by sunny kumar maurya--

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity processor is
end processor;

architecture arc of processor is

component PC
  generic ( n : integer := 8;
             propagation_delay : time := 0 ns);

  port ( inputs : IN std_logic_vector (n-1 downto 0);
        outputs : OUT std_logic_vector (n-1 downto 0);
         inEn,clear, load, outputEn : IN bit
          );
  end component ;
  
  
component IR
  generic ( n : integer := 12;
             propagation_delay : time := 0 ns);

  port ( inputs : IN std_logic_vector (n-1 downto 0);
        outputs : OUT std_logic_vector (n-1 downto 0);
         inEn,clear, load, outputEn : IN bit
         );
  end component ;
  
  
component AR
  generic ( n : integer := 8;
             propagation_delay : time := 0 ns);

  port ( inputs : IN std_logic_vector (n-1 downto 0);
        outputs : OUT std_logic_vector (n-1 downto 0);
         inEn,clear, load, outputEn : IN bit
        );
  end component ;
  
component ACC
  generic ( n : integer := 16;
             propagation_delay : time := 0 ns);

  port ( inputs : IN std_logic_vector (n-1 downto 0);
        outputs : OUT std_logic_vector (n-1 downto 0);
         inEn,clear,flag,load, outputEn : IN bit
          );
  end component ;
  
  component ALU 
    port (	num_A: in std_logic_vector(15 downto 0);
		num_B: 	in std_logic_vector(15 downto 0);
		Cin:	in std_logic;
		ALUs:	in std_logic_vector( 3 downto 0);
		ALUout:	out std_logic_vector(15 downto 0)
);
end component;
  
component ControlUnit 
 
 port(instruct : in std_logic_vector(10 downto 0);
      op_address: out std_logic_vector(7 downto 0);
      opcode : out std_logic_vector(3 downto 0)
       );
end component;   
  
component memory

generic( bits : INTEGER:=8;
         words :INTEGER:=256);  

port ( 	
    enable		: 	in std_logic;
		read		:	in std_logic;
		write		:	in std_logic;
		addr	:	in INTEGER range 0 to words-1;
		data_in	:	in std_logic_vector(15 downto 0);
		data_out:	out std_logic_vector(15 downto 0)
);
end component;


signal PCinputs :std_logic_vector(7 downto 0):="00000000";
signal PCoutputs :std_logic_vector(7 downto 0):="00000000";
signal PCinEn:bit:='0';
signal PCload : bit :='0';
signal PCclear : bit :='0';
signal PCoutputEn : bit :='0';
signal ARinputs : std_logic_vector( 7 downto 0) :="00000000";
signal ARoutputs : std_logic_vector(7 downto 0) :="00000000";
signal ARinEn:bit:='0';
signal ARload : bit :='0';
signal ARclear : bit :='0';
signal ARoutputEn : bit :='0';
signal IRinputs : std_logic_vector( 10 downto 0) :="00000000000";
signal IRoutputs : std_logic_vector(10 downto 0) :="00000000000";
signal IRinEn:bit:='0';
signal IRload : bit :='0';
signal IRclear : bit :='0';
signal IRoutputEn : bit :='0';
signal ACCinputs : std_logic_vector( 15 downto 0) :="0000000000000000";
signal ACCoutputs : std_logic_vector(15 downto 0) :="0000000000000000";
signal ACCinEn:bit:='0';
signal ACCload : bit :='0';
signal ACCclear : bit :='0';
signal ACCoutputEn : bit :='0';
signal ACCflag : bit :='0';
signal CTRLinstruct :  std_logic_vector(10 downto 0):="00000000000";
signal CTRLop_address:  std_logic_vector(7 downto 0):="00000000";
signal CTRLopcode :  std_logic_vector(3 downto 0):="0000";
signal ALUnum_A:  std_logic_vector(15 downto 0):="0000000000000000";
signal	ALUnum_B:  std_logic_vector(15 downto 0):="0000000000000000";
signal ALUCin : std_logic:='0';
signal ALUALUs : std_logic_vector( 3 downto 0):="0000";
signal	ALUALUout : std_logic_vector(15 downto 0):="0000000000000000";
signal MEMenable		: std_logic:='0';
signal	MEMread		:	std_logic:='0';
signal	MEMwrite		:	std_logic:='0';
signal MEMaddr	:	 INTEGER range 0 to 255;
signal	MEMdata_in	:	std_logic_vector(15 downto 0):="0000000000000000";
signal	MEMdata_out:	 std_logic_vector(15 downto 0):="0000000000000000";
signal clk: bit ;
  signal clocktime :integer range 0 to 10 :=0;
  signal rst : bit :='0';
--now PORT MAPPING COMPONENTS-----
begin
PCmap: PC generic map(8) port map( 
          inputs => PCinputs,
          outputs=> PCoutputs ,
          inEn=>PCinEn,
          clear => PCclear,
          load => PCload,
          outputEn =>PCoutputEn 
);
ARmap: AR generic map(8) port map( 
          inputs => ARinputs,
          outputs=> ARoutputs ,
          inEn=>ARinEn,
          clear => ARclear,
          load => ARload,
          outputEn =>ARoutputEn 
);
IRmap: IR generic map(11) port map( 
         inputs => IRinputs,
         outputs=> IRoutputs ,
         inEn=>IRinEn,
         clear => IRclear,
         load => IRload,
         outputEn =>IRoutputEn 
);
ACCmap: ACC generic map(16) port map( 
inputs => ACCinputs,
        outputs=> ACCoutputs ,
         inEn=>ACCinEn,
         clear => ACCclear,
          flag => ACCflag,
          load => ACCload,
          outputEn =>ACCoutputEn 
          
);



CTRLmap: ControlUnit port map(instruct=>CTRLinstruct ,
      op_address=>CTRLop_address,
      opcode =>CTRLopcode );


ALUmap: ALU port map(	num_A=>ALUnum_A,
	  num_B => ALUnum_B,
	  Cin => ALUCin,
		ALUs => ALUALUs,
		ALUout => ALUALUout
);

MEMmap: memory port map( 	
		enable=>MEMenable	,
		read=>MEMread	,
		write=>MEMwrite,
		addr=>MEMaddr	,
		data_in=>MEMdata_in	,
		data_out=>MEMdata_out
);

--end of port mapping----
 clk <= not clk after 10 ns;
 process(clk)
 begin
   if (clocktime = 10 or rst ='1') then
     clocktime <=0;
 else 
 clocktime<= clocktime+1;   
 end if;
 end process; 
 -- clock end

process (clocktime)
  begin
    if(clocktime=0)then
    PCoutputEn <='1';
    ARinEn<='1';
    ARinputs <= PCoutputs;
    ARinEn<='0';
    PCinEn<='1';
    pcinputs<=pcoutputs+1;
    PCinEn<='0';
    ARload <='1';
    PCoutputEn <='0';
    ARload <='0';   
   
   elsif(
   clocktime=1)then
    ARoutputEn<='1';
    MEMaddr <= conv_integer(ARoutputs);
    MEMread<='1';
    IRinEn<='1';
    IRinputs<=MEMdata_out(10 downto 0);
    IRinEn<='0';
    IRload<='1';
    ARoutputEn<='0'; 
    MEMread<='0'; 
    IRload<='0'; 
   
   elsif(clocktime=2)then
    IRoutputEn<='1';
    CTRLinstruct <= IRoutputs;    
    ARinEn<='1';
    ARinputs<=CTRLop_address;
    ARinEn<='0';
    ARload<='1';
    ARoutputEn<='1';
    MEMaddr <= conv_integer(ARoutputs);
    MEMread<='1';
  elsif(clocktime=3)then
  
  if(ACCflag='0')then
    ALUnum_A<= MEMdata_out;
    ALUALUs<=CTRLopcode;    
    ACCinEn<='1';
    ACCinputs<=ALUALUout;
    ARinEn<='0';
    ACCload<='1';
    ACCflag<='1';
  else
    ALUnum_B<= MEMdata_out;
    ALUALUs<=CTRLopcode;
    ACCinEn<='1';
    ACCinputs<=ALUALUout;
    ACCinEn<='0';
    ACCload<='1';
    ACCflag<='1';
  end if;

end if;
end process;
end arc;
