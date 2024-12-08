
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_divider is
	port(
		clk : in std_logic; -- 25.175 MHz from PLL
		midi_clk : out std_logic; -- 31.25 kHz for communication with MIDI keyboard
		sample_clk : out std_logic; -- 48 kHz for Paul
		nes_clk : out std_logic; --83.3 kHz for NES Controller
		note_counter : out unsigned(9 downto 0) -- 35 Hz counter for ~1000 16th notes
	);
end;

architecture synth of clock_divider is 

-- Counters used to generate slower clocks
signal midi_count : unsigned(9 downto 0);
signal sample_count : unsigned(9 downto 0);
signal nes_count : unsigned(8 downto 0);
signal note_timing : unsigned(21 downto 0);

begin
	process (clk) begin
		if rising_edge(clk) then
			-- Increment and reset counters at the correct intervals to create new clocks
			midi_count <= "0000000000" when midi_count = "1100100110" else midi_count + 1; 
			sample_count <= "0000000000" when sample_count = "1000001100" else sample_count  + 1;
			nes_count <= "000000000" when nes_count = "100101110" else nes_count + 1;
			--note_timing <= "000000000000000000000" when note_timing = "111011000110010011010" else note_timing + 1;
			note_timing <= "0000000000000000000000" when note_timing = "0111011000110010011010" else note_timing + 1;
			note_counter <= note_counter + 1 when note_timing = "0000000000000000000001" else note_counter;
		end if;
	end process;
	
	-- Assign output clocks
	sample_clk <= '1' when sample_count >= "0100000110" else '0';
	midi_clk <= '1' when midi_count >= "0110010010" else '0';
	nes_clk <= '1' when nes_count >= "010010111" else '0';

end;
