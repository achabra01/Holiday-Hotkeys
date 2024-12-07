library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nes_controller is 
	port (
		data : in std_logic;
		clock : out std_logic;
		latch : out std_logic;
		a : out std_logic;
		b : out std_logic;
		slct : out std_logic;
		start : out std_logic;
		up : out std_logic;
		down : out std_logic;
		lft : out std_logic;
		rght : out std_logic
	);
end;

architecture synth of nes_controller is

	component HSOSC is
		generic (
			CLKHF_DIV : String := "0b00"); -- Divide 48MHz clock by 2ˆN (0-3)
		port(
			CLKHFPU : in std_logic := 'X'; -- Set to 1 to power up
			CLKHFEN : in std_logic := 'X'; -- Set to 1 to enable output
			CLKHF : out std_logic := 'X' -- Clock output
			); 
	end component;

	signal clk : std_logic;
	signal NESclk : std_logic;
	signal NEScount : unsigned(10 downto 0);
	signal counter : unsigned(19 downto 0);
	signal register1 : unsigned(7 downto 0);
	signal register2 : unsigned(7 downto 0);
	signal register_counter : unsigned(2 downto 0);
	
	begin
		hsosc_port_map : HSOSC generic map (CLKHF_DIV => "0b00")
							   port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);

		process (clk) is
		begin
			if rising_edge(clk) then
				counter <= counter + 1;
				
				if rising_edge(clock) then
					register1 <= register1(6 downto 0) & data;
				end if;
				
				if (NEScount = "00000001000") then
					register2 <= register1;
				end if;
			end if;
		end process;
			
		NESclk <= counter(8);
		NEScount <= counter(19 downto 9);
		latch <= '1' when (NEScount = "11111111111") else '0';
		clock <= NESclk when (NEScount < "00000001000") else '0';
		
		a <= not register2(7);
		b <= not register2(6);
		slct <= not register2(5);
		start <= not register2(4);
		up <= not register2(3);
		down <= not register2(2);
		lft <= not register2(1);
		rght <= not register2(0);

end;
