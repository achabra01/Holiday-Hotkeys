
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_divider is
	port(
		clk : in std_logic; -- 25.175 MHz from PLL
		--VSYNC : in std_logic; -- 60 Hz
		sample_clk : out std_logic; -- 48 kHz for Paul
		nes_clk : out std_logic; --83.3 kHz for NES Controller
		note_counter : out unsigned(13 downto 0) -- 6 Hz counter for ~1000 16th notes
		--sync_counter : out unsigned(13 downto 0)
	);
end;

architecture synth of clock_divider is 

-- Counters used to generate slower clocks
signal sample_count : unsigned(9 downto 0);
signal nes_count : unsigned(8 downto 0);
signal note_timing : unsigned(22 downto 0);
--signal sync_timing : unsigned(1 downto 0);


begin
	process (clk) begin
		if rising_edge(clk) then
			-- Increment and reset counters at the correct intervals to create new clocks
			sample_count <= "0000000000" when sample_count = "1000001100" else sample_count  + 1;
			nes_count <= "000000000" when nes_count = "100101110" else nes_count + 1;
			--note_timing <= "000000000000000000000" when note_timing = "111011000110010011010" else note_timing + 1;
			--note_timing <= "0000000000000000000000" when note_timing = "0111011000110010011010" else note_timing + 1;
			--note_counter <= note_counter + 1 when note_timing = "0000000000000000000001" else note_counter;
			--note_timing <= "000000000000000000000" when note_timing = "1110110001100100110100" else note_timing + 1;
			note_timing <= "00000000000000000000000" when note_timing = "00000111011000110010011" else note_timing + 1;
			note_counter <= note_counter + 1 when note_timing = "00000000000000000000001" else note_counter;
		end if;
	end process;
	--process (VSYNC) begin
		--if rising_edge(VSYNC) then
			--sync_timing <= sync_timing + 1;
		--end if;
	--end process;
		
			--sync_counter <= sync_counter + 1 when sync_timing = 2d"2" else sync_counter;
	-- Assign output clocks
	sample_clk <= '1' when sample_count >= "0100000110" else '0';
	nes_clk <= '1' when nes_count >= "010010111" else '0';

end;
