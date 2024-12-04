library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is 
	port(
		internal_clk		: in std_logic; --clk from PLL
		row					: out unsigned (9 downto 0);
		col					: out unsigned (9 downto 0);
		valid				: out std_logic;
		HSYNC 				: out std_logic;
		VSYNC 				: out std_logic
	);
end vga;

architecture synth of vga is

signal row_count : unsigned (9 downto 0) := "0000000000";
signal col_count : unsigned (9 downto 0) := "0000000000";

begin

process (internal_clk) begin
	if rising_edge(internal_clk) then
		col_count <= col_count + 1;
		
		if col_count = 799 then
			row_count <= row_count + 1;
			col_count <= "0000000000";
		end if;
		
		if row_count = 524 then
			row_count <= "0000000000";
		end if;
		
	end if;
end process;

valid <= '1' when (col_count < 640 and row_count < 480) else '0';
HSYNC <= '0' when (col_count > 655 and col_count < 751) else '1';
VSYNC <= '0' when (row_count > 489 and row_count < 491) else '1';

col <= col_count;
row <= row_count;


end;
