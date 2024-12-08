library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is 
	port(
		counter_button : in std_logic;
		reset_button : in std_logic;
		digit_pow : out std_logic_vector(1 downto 0);
		segment_out : out unsigned(6 downto 0)
	);
end;

architecture synth of top is

component HSOSC is
	generic (
		CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock by 2ˆN (0-3)
	port(
		CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
		CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
		CLKHF : out std_logic := 'X'); -- Clock output
end component;

component dddd is
	port(
		input_num : in unsigned(5 downto 0);
		digit_1 : out unsigned(6 downto 0);
		digit_2 : out unsigned(6 downto 0)
	);
end component;

signal clk : std_logic;
signal counter : unsigned(5 downto 0);
signal current_number : unsigned(5 downto 0);
signal button_prev : std_logic;
signal digit_1_out : unsigned(6 downto 0);
signal digit_2_out : unsigned(6 downto 0);
signal button_change : std_logic;
signal debouncing_counter : unsigned(15 downto 0);
signal debounced_full : std_logic;
signal debouncing_reset : std_logic;
signal button_state : std_logic;

begin
	hsosc_port_map : HSOSC generic map (CLKHF_DIV => "0b00")
						   port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
						   
	dddd_port_map : dddd port map(
		input_num => current_number,
		digit_1 => digit_1_out,
		digit_2 => digit_2_out
	);
	
	process (clk) is
	begin
		if rising_edge(clk) then
			counter <= counter + 1;
			button_state <= not button_state when debouncing_counter = "1111111111111111";
			button_change <= '1' when button_state xor counter_button else '0';
			current_number <= "000000" when reset_button = '0' else current_number + "000001" when rising_edge(button_state); --button_state = '1'
			
			if (button_change = '1') then
				debouncing_counter <= debouncing_counter + 16b"1";
			end if;
		end if;
	end process;
	
	--Alternate digits
	digit_pow <= "01" when counter(5) = '1' else "10";
	segment_out <= digit_1_out when counter(5) = '1' else digit_2_out;
end;