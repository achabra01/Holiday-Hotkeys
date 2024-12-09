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
	  key : out std_logic_vector(3 downto 0);
	  rgb : out std_logic_vector (5 downto 0)
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

component tile is
generic (
	tile_start : unsigned(9 downto 0) := 10d"1";
	tile_end : unsigned(9 downto 0) := 10d"29";
	tile_width : unsigned(9 downto 0) := 10d"25";
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
end component;

component tilev2 is 
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
		--VSYNC : in std_logic;
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
		key : out std_logic_vector(3 downto 0);
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
	
	--TILE STUFF
	signal tile1_data : std_logic_vector (5 downto 0);
	signal tile2_data : std_logic_vector (5 downto 0);
	signal tile3_data : std_logic_vector (5 downto 0);
	signal tile4_data : std_logic_vector (5 downto 0);
	signal tile5_data : std_logic_vector (5 downto 0);
	signal tile6_data : std_logic_vector (5 downto 0);
	signal tile7_data : std_logic_vector (5 downto 0);
	signal tile8_data : std_logic_vector (5 downto 0);
	signal tile9_data : std_logic_vector (5 downto 0);
	signal tile10_data : std_logic_vector (5 downto 0);
	signal tile11_data : std_logic_vector (5 downto 0);
	signal tile12_data : std_logic_vector (5 downto 0);
	signal tile13_data : std_logic_vector (5 downto 0);
	signal tile14_data : std_logic_vector (5 downto 0);
	signal tile15_data : std_logic_vector (5 downto 0);
	signal tile16_data : std_logic_vector (5 downto 0);
	signal tile17_data : std_logic_vector (5 downto 0);
	
	signal tile_final : std_logic_vector (5 downto 0); 
	
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
	
	--TILE DROP TIMING NIGHTMARE
	signal reset1 : std_logic;
	signal reset2 : std_logic;
	signal reset3 : std_logic;
	signal reset4 : std_logic;
	signal reset5 : std_logic;
	signal reset6 : std_logic;
	signal reset7 : std_logic;
	signal reset8 : std_logic;
	signal reset9 : std_logic;
	signal reset10 : std_logic;
	signal reset11 : std_logic;
	signal reset12 : std_logic;
	signal reset13 : std_logic;
	signal reset14 : std_logic;
	signal reset15 : std_logic;
	signal reset16 : std_logic;
	signal reset17 : std_logic;
	
	-- Counters to decide which tile falls next
	signal tile1_counter : unsigned(4 downto 0);
	signal tile2_counter : unsigned(4 downto 0);
	signal tile3_counter : unsigned(4 downto 0);
	signal tile4_counter : unsigned(4 downto 0);
	signal tile5_counter : unsigned(4 downto 0);
	signal tile6_counter : unsigned(4 downto 0);
	signal tile7_counter : unsigned(4 downto 0);
	signal tile8_counter : unsigned(4 downto 0);
	signal tile9_counter : unsigned(4 downto 0);
	signal tile10_counter : unsigned(4 downto 0);
	signal tile11_counter : unsigned(4 downto 0);
	signal tile12_counter : unsigned(4 downto 0);
	signal tile13_counter : unsigned(4 downto 0);
	signal tile14_counter : unsigned(4 downto 0);
	signal tile15_counter : unsigned(4 downto 0);
	signal tile16_counter : unsigned(4 downto 0);
	signal tile17_counter : unsigned(4 downto 0);
	
	signal tile2_out : std_logic_vector(5 downto 0);

begin

	--PORT MAPPING
	thepiano: piano port map (row, col, valid, piano_data);
	rom : my_rom port map (clk, std_logic_vector(row(8 downto 2)), std_logic_vector(col(9 downto 2)), rom_out);
	select_bar : key_select generic map (10d"500", 10d"520", "111100") port map (VSYNC, lft, rght, valid, row, col, key, select_bar_data);
	background : background_rom port map (clk, std_logic_vector(row(8 downto 2)), std_logic_vector(col(8 downto 2)), background_out);
	
	test : tilev2 port map (sync_count, row, col, clk, valid, tile2_out);
	
	--tile1 : tile generic map (10d"1", 10d"29", 10d"32", 5d"1") 		port map (note_count, reset1, row, col, valid, VSYNC, tile1_data);
	--tile2 : tile generic map (10d"29", 10d"57", 10d"32", 5d"1") 	port map (note_count, reset2, row, col, valid, VSYNC, tile2_data);
	--tile3 : tile generic map (10d"57", 10d"85", 10d"32", 5d"1") 	port map (note_count, reset, row, col, valid, VSYNC, tile3_data);
	--tile4 : tile generic map (10d"87", 10d"113", 10d"32", 5d"1") 	port map (note_count, reset4, row, col, valid, VSYNC, tile4_data);
	--tile5 : tile generic map (10d"113", 10d"141", 10d"32", 5d"1")	port map (note_count, reset5, row, col, valid, VSYNC, tile5_data);
	--tile6 : tile generic map (10d"142", 10d"170", 10d"32", 5d"1")	port map (note_count, reset6, row, col, valid, VSYNC, tile6_data);
	--tile7 : tile generic map (10d"170", 10d"198", 10d"32", 5d"1")	port map (note_count, reset7, row, col, valid, VSYNC, tile7_data);
	--tile8 : tile generic map (10d"198", 10d"226", 10d"32", 5d"1")	port map (note_count, reset8, row, col, valid, VSYNC, tile8_data);
	--tile9 : tile generic map (10d"226", 10d"254", 10d"32", 5d"1")	port map (note_count, reset9, row, col, valid, VSYNC, tile9_data);
	--tile10 : tile generic map (10d"254", 10d"282", 10d"32", 5d"1")  port map (note_count, reset10, row, col, valid, VSYNC, tile10_data);
	--tile11 : tile generic map (10d"282", 10d"310", 10d"32", 5d"1")  port map (note_count, reset11, row, col, valid, VSYNC, tile11_data);
	--tile12 : tile generic map (10d"310", 10d"338", 10d"32", 5d"1")  port map (note_count, reset12, row, col, valid, VSYNC, tile12_data);
	--tile13 : tile generic map (10d"339", 10d"367", 10d"32", 5d"1")  port map (note_count, reset13, row, col, valid, VSYNC, tile13_data);
	--tile14 : tile generic map (10d"367", 10d"395", 10d"32", 5d"1")  port map (note_count, reset14, row, col, valid, VSYNC, tile14_data);
	--tile15 : tile generic map (10d"395", 10d"423", 10d"32", 5d"1")  port map (note_count, reset15, row, col, valid, VSYNC, tile15_data);
	--tile16 : tile generic map (10d"423", 10d"451", 10d"32", 5d"1")  port map (note_count, reset16, row, col, valid, VSYNC, tile16_data);
	--tile17 : tile generic map (10d"451", 10d"479", 10d"32", 5d"1")  port map (note_count, reset, row, col, valid, VSYNC, tile17_data);

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
				
	--tile_final <= tile1_data when (tile1_data = "001111") else
		  --tile2_data when (tile2_data = "001111") else
		  --tile3_data when (tile3_data = "001111") else
		  --tile4_data when (tile4_data = "001111") else
		  --tile5_data when (tile5_data = "001111") else
		  --tile6_data when (tile6_data = "001111") else
		  --tile7_data when (tile7_data = "001111") else
		  --tile8_data when (tile8_data = "001111") else
		  --tile9_data when (tile9_data = "001111") else
		  --tile10_data when (tile10_data = "001111") else
		  --tile11_data when (tile11_data = "001111") else
		  --tile12_data when (tile12_data = "001111") else
		  --tile13_data when (tile13_data = "001111") else
		  --tile14_data when (tile14_data = "001111") else
		  --tile15_data when (tile15_data = "001111") else
		  --tile16_data when (tile16_data = "001111") else
		  --tile17_data when (tile17_data = "001111") else
		  --"000000";
		 
	--reset16 <= '1' when pick_reset = "0001" else '0';
	--reset15 <= '1' when pick_reset = "0010" else '0';
	--reset14 <= '1' when pick_reset = "0011" else '0';
	--reset13 <= '1' when pick_reset = "0100" else '0';
	--reset12 <= '1' when pick_reset = "0101" else '0';
	--reset11 <= '1' when pick_reset = "0110" else '0';
	--reset10 <= '1' when pick_reset = "0111" else '0';
	--reset9 <= '1' when pick_reset = "1000" else '0';
	--reset8 <= '1' when pick_reset = "1001" else '0';
	--reset7 <= '1' when pick_reset = "1010" else '0';
	--reset6 <= '1' when pick_reset = "1011" else '0';
	--reset5 <= '1' when pick_reset = "1100" else '0';
	--reset4 <= '1' when pick_reset = "1101" else '0';
	--reset2 <= '1' when pick_reset = "1110" else '0';
	--reset1 <= '1' when pick_reset = "1111" else '0';
	
	
	--background_or_tile <= tile_final when (tile_final = "001111") else game_background;
	background_or_tile <= tile2_out when (tile2_out = "001111") else game_background;
	select_bar_and_piano <= select_bar_data when (select_bar_data = "111100") else piano_data;
	
	title_screen <=  rom_data;
	--game_screen <= background_or_tile when col < 511 and col > 64 else select_bar_and_piano;
	game_screen <= background_or_tile when col < 511 else select_bar_and_piano;

	process (VSYNC) begin
	if rising_edge(VSYNC) then
		case curr_state is
			  when TITLE => if (start = '1') then 
									curr_state <= GAME; 
						   else curr_state <= TITLE; end if;
						   
			  when GAME => if (start = '1') then 
									curr_state <= TITLE; 
						   else curr_state <= GAME; end if;
			end case;
			
	end if;
	end process;
	
	rgb <= title_screen when curr_state = TITLE else game_screen;

end;