
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY InstructionMemory IS
	port (  
		inIM  : in  std_logic_vector(31 downto 0);
		outIM : out std_logic_vector(31 downto 0));
END InstructionMemory;

ARCHITECTURE InstructionMemory_1 of InstructionMemory is


	type mem_type is array (natural range <>) of std_logic_vector(7 downto 0);
	signal mem: mem_type(0 to 1023) := (
	0 => "00100001",
1 => "01000001",
2 => "00000000",
3 => "00010100",
4 => "00100001",
5 => "01000010",
6 => "00000000",
7 => "00001010",
8 => "00100001",
9 => "01000011",
10 => "00000000",
11 => "00110010",
12 => "00000000",
13 => "00100010",
14 => "00101000",
15 => "00100000",
16 => "10101100",
17 => "01100101",
18 => "00000000",
19 => "00000101",
20 => "10001100",
21 => "01101010",
22 => "00000000",
23 => "00000101",
		others=> (others => '0'));

	signal FullInstruction: std_logic_vector(31 downto 0); 
	signal IM_address:      integer;

BEGIN

	IM_address <= to_integer(unsigned(inIM));
	FullInstruction <= mem(IM_address) & mem(IM_address+1) & mem(IM_address+2) & mem(IM_address+3)
		               when (IM_address >= 0) else std_logic_vector(to_signed(-1,32));
	outIM <= FullInstruction;

END InstructionMemory_1;