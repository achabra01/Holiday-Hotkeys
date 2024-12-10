
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_divider is
	port(
		clk : in std_logic; -- 25.175 MHz from PLL
		reset : in std_logic;
		sample_clk : out std_logic; -- 48 kHz for Paul
		nes_clk : out std_logic; --83.3 kHz for NES Controller
		note_counter1 : out unsigned(9 downto 0); -- 6 Hz counter for ~1000 16th notes
		note_counter2 : out unsigned(13 downto 0) -- 6 Hz counter for ~1000 16th notes
	);
end;

architecture synth of clock_divider is 

-- Counters used to generate slower clocks
signal sample_count : unsigned(9 downto 0);
signal nes_count : unsigned(8 downto 0);
signal note_timing1 : unsigned(22 downto 0);
signal note_timing2 : unsigned(22 downto 0);


begin
	process (clk) begin
		if rising_edge(clk) then
			-- Increment and reset counters at the correct intervals to create new clocks
			sample_count <= "0000000000" when sample_count = "1000001100" else sample_count  + 1;
			nes_count <= "000000000" when nes_count = "100101110" else nes_count + 1;
			note_timing1 <= "00000000000000000000000" when note_timing1 = "111011000110010011010" else note_timing1 + 1;
			note_timing2 <= "00000000000000000000000" when note_timing2 = "00000111011000110010011" else note_timing2 + 1;
			if reset = '0' then
				note_counter1 <= note_counter1 + 1 when note_timing1 = "00000000000000000000001" else note_counter1;
				note_counter2 <= note_counter2 + 1 when note_timing2 = "00000000000000000000001" else note_counter2;
			else
				note_counter1 <= 10b"0";
				note_counter2 <= 14b"0";
			end if;
		end if;
	end process;
	-- Assign output clocks
	sample_clk <= '1' when sample_count >= "0100000110" else '0';
	nes_clk <= '1' when nes_count >= "010010111" else '0';

end;
