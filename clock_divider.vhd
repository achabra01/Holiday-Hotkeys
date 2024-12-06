-- pll clk in
-- sample clk out
-- midi clk out
-- 16th counter out

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_divider is
	port(
		clk : in std_logic; -- 25.175 MHz
		midi_clk : out std_logic;
		sample_clk : out std_logic;
		note_counter : out unsigned(9 downto 0)
	);
end;

architecture synth of clock_divider is 

signal midi_count : unsigned(10 downto 0);
signal sample_count : unsigned(10 downto 0);
signal note_timing : unsigned(20 downto 0);

begin
	process (clk) is 
	begin
		if rising_edge(clk) then
			midi_count <= "00000000000" when midi_count = "10110010100" else midi_count + 1; 
			sample_count <= "00000000000" when sample_count = "10000011001" else sample_count  + 1;
			note_timing <= "000000000000000000000" when sample_count = "101011111001101101011" else note_timing + 1;
		end if;
	end process;
	
	sample_clk <= '1' when sample_count >= "01000001100" else '0';
	midi_clk <= '1' when midi_count >= "01011001010" else '0';
	note_counter <= note_counter + 1 when note_timing >= "010101111100110110101" else note_counter;
end;