
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Memory IS
	port (  
		inRAM     : in  std_logic_vector(31 downto 0); 
		WriteData : in  std_logic_vector(31 downto 0); 
		MemWrite  : in  std_logic;                    
		MemRead   : in  std_logic;                     
		outRAM    : out std_logic_vector(31 downto 0);
		reset     : in  std_logic);
END Memory;

ARCHITECTURE Memory_1 of Memory is

	type ram_type is array (natural range <>) of std_logic_vector(31 downto 0);
	signal ram:     ram_type(0 to 1023) := (others=> (others => '0'));
	signal Address: integer := 0;

BEGIN

	Address <= to_integer(unsigned(inRAM)) 
	      when (to_integer(unsigned(inRAM)) <= 1023)
	      else 0;

	
	ram(Address)    <= WriteData when (MemWrite='1' and reset='0');

	with reset select
		outRAM <=
			ram(Address)    when '0',
			(others => '0') when others;

END Memory_1;