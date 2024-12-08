library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tile is 
	generic (
		tile_start : unsigned(9 downto 0) := 10d"1";
		tile_end : unsigned(9 downto 0) := 10d"29";
		tile_width : unsigned(9 downto 0) := 10d"0";
		speed : unsigned(4 downto 0) := 5d"1"
	);
	port(
		note_count : in unsigned (9 downto 0);
		reset : in std_logic;
		row : in unsigned (9 downto 0);
		col : in unsigned (9 downto 0);
		valid : in std_logic;
		VSYNC : in std_logic;
		rgb : out std_logic_vector(5 downto 0)
	);
end tile;

architecture synth of tile is

signal block_test : std_logic_vector(5 downto 0);
signal row_limiter : std_logic_vector(5 downto 0);
signal counter : unsigned(9 downto 0) := 10d"0";

begin
process (VSYNC) begin
  if rising_edge(VSYNC) then
		-- NOTE CLK COUNTER
		if reset = '1' then
			if counter < 10d"511" then
				counter <= counter + speed;
			else 
				counter <= counter;
			end if;
		else
			counter <= 10d"0";
		end if;
  end if;
end process;

block_test <= "001111" when col > counter and col < counter + tile_width else "001100";
row_limiter <= block_test when row >= tile_start and row < tile_end else "000000";
rgb <= "000000" when valid = '0' else row_limiter;

end;
