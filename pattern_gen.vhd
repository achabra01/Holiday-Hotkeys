library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pattern_gen is 
	port(
      clk : in std_logic;
	  row : in unsigned (9 downto 0);
	  col : in unsigned (9 downto 0);
	  valid : in std_logic;
	  VSYNC : in std_logic;
	  reset : in std_logic;
	  lft : in std_logic;
	  rght : in std_logic;
	  start : in std_logic;
	  pick_reset : in std_logic_vector (3 downto 0);
	  sync_count : in unsigned (12 downto 0);
	  key : out std_logic_vector(4 downto 0);
	  rgb : out std_logic_vector (5 downto 0);
	  state_flag : out std_logic := '0'
	);
end pattern_gen;

architecture synth of pattern_gen is
component piano is 
	port(
		row: in unsigned (9 downto 0);
		col: in unsigned (9 downto 0);
		valid: in std_logic;
		rgb: out std_logic_vector (5 downto 0)
	);
end component;

component my_rom is
  port(
	clk : in std_logic;
    yaddr : in std_logic_vector(6 downto 0);	-- 16 words total
	xaddr : in std_logic_vector(7 downto 0);	-- 16 words total
	data : out std_logic_vector(1 downto 0) -- 6-bit words, RRGGBB
  );
end component;

component tile2 is 
	generic (
		tile_start : unsigned(9 downto 0) := 10d"1";
		tile_end : unsigned(9 downto 0) := 10d"29";
		tile_width : unsigned(9 downto 0) := 10d"0";
		speed : unsigned(4 downto 0) := 5d"1"
	);
	port(
		note_count : in unsigned (12 downto 0);
		row : in unsigned (9 downto 0);
		col : in unsigned (9 downto 0);
		pll : in std_logic;
		valid : in std_logic;
		VSYNC : in std_logic;
		rgb : out std_logic_vector(5 downto 0)
	);
end component;

component key_select is 
	generic (
		key_select_start : unsigned(9 downto 0) := 10d"511";
		key_select_end : unsigned(9 downto 0) := 10d"514";
		bar_color : std_logic_vector(5 downto 0) := "111100"
	);
	port(
		clk : in std_logic;
		lft : in std_logic;
		rght : in std_logic;
		valid : in std_logic;
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		key : out std_logic_vector(4 downto 0);
		rgb : out std_logic_vector(5 downto 0)
	);
end component;

component background_rom is
  port(
    clk : in std_logic;
    yaddr : in std_logic_vector(6 downto 0);
    xaddr : in std_logic_vector(6 downto 0);
    data : out std_logic_vector(2 downto 0)
  );
end component;

	--PIANO STUFF
	signal piano_data : std_logic_vector (5 downto 0);
	
	--KEY SELECT STUFF
	signal select_bar_data : std_logic_vector (5 downto 0);

	--ROM STUFF
	signal rom_out : std_logic_vector (1 downto 0);
	signal rom_data : std_logic_vector (5 downto 0);
	
	signal note_count : unsigned (9 downto 0);
	
	--TEMPORARY OUTPUT
	signal background_or_tile : std_logic_vector (5 downto 0); 
	signal select_bar_and_piano : std_logic_vector (5 downto 0);
	signal title_screen : std_logic_vector (5 downto 0); 
	signal game_screen : std_logic_vector (5 downto 0); 
	signal game_background : std_logic_vector (5 downto 0);
	signal background_out : std_logic_vector (2 downto 0);

	--PRESENTATION STATES
	type STATE is (TITLE, GAME);
	signal curr_state : STATE := TITLE;
	
	--TILE STUFF
	signal tile2_out : std_logic_vector(5 downto 0);

begin

	--PORT MAPPING
	thepiano: piano port map (row, col, valid, piano_data);
	rom : my_rom port map (clk, std_logic_vector(row(8 downto 2)), std_logic_vector(col(9 downto 2)), rom_out);
	select_bar : key_select generic map (10d"500", 10d"520", "111100") port map (VSYNC, lft, rght, valid, row, col, key, select_bar_data);
	background : background_rom port map (clk, std_logic_vector(row(8 downto 2)), std_logic_vector(col(8 downto 2)), background_out);
	
	test : tile2 port map (sync_count, row, col, clk, valid, VSYNC, tile2_out);
	
	rom_data <= "000000" when rom_out = "00" else
	            "111111" when rom_out = "01" else
		        "110000" when rom_out = "10" else
		        "001001";
	
	game_background <= "000000" when background_out = "000" else
         "111111" when background_out = "001" else
         "111101" when background_out = "010" else
         "101101" when background_out = "011" else
         "101010" when background_out = "100" else
         "110000" when background_out = "101" else
         "100101" when background_out = "110";
	
	background_or_tile <= tile2_out when (tile2_out = "001111") else game_background;
	select_bar_and_piano <= select_bar_data when (select_bar_data = "111100") else piano_data;
	
	title_screen <=  rom_data;
	game_screen <= background_or_tile when col < 511 else select_bar_and_piano;

	process (VSYNC) begin
	if rising_edge(VSYNC) then
		case curr_state is
			  when TITLE => if (start = '1') then 
									curr_state <= GAME; 
									state_flag <= '0';
						   else curr_state <= TITLE; end if;
						   
			  when GAME => if (start = '1') then 
									curr_state <= TITLE; 
						   else curr_state <= GAME; end if;
			end case;
			state_flag <= '1' when curr_state = GAME else '0';
	end if;
	end process;
	
	rgb <= title_screen when curr_state = TITLE else game_screen;

end;