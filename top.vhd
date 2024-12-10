library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is 
	port(
		input_clock 	: in std_logic;
		data : in std_logic;
		clock : out std_logic;
		latch : out std_logic;
		output_clock 	: out std_logic;
		RGB 			: out std_logic_vector(5 downto 0);
		HSYNC			: out std_logic;
		VSYNC			: out std_logic;
		a : out std_logic;
		b : out std_logic;
		slct : out std_logic;
		start : out std_logic;
		up : out std_logic;
		down : out std_logic;
		lft : out std_logic;
		rght : out std_logic;
		debugROM : out std_logic;
		audio_out : out std_logic
	);
end top;

architecture synth of top is

component mypll is
    port(
        ref_clk_i: in std_logic;	--clk in
        rst_n_i: in std_logic; 		--reset
        outcore_o: out std_logic;	--output to pins
        outglobal_o: out std_logic	--output for clk network
    );
end component;

component vga is 
	port(
		internal_clk		: in std_logic; --clk from PLL
		row					: out unsigned (9 downto 0);
		col					: out unsigned (9 downto 0);
		valid				: out std_logic;
		HSYNC 				: out std_logic;
		VSYNC 				: out std_logic
	);
end component;

component pattern_gen is 
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
	  state_flag : out std_logic
	);
end component;

component clock_divider is
	port(
		clk : in std_logic; -- 25.175 MHz from PLL
		reset : in std_logic;
		sample_clk : out std_logic; -- 48 kHz for Paul
		nes_clk : out std_logic; --83.3 kHz for NES Controller
		note_counter1 : out unsigned(9 downto 0); -- 6 Hz counter for ~1000 16th notes
		note_counter2 : out unsigned(13 downto 0) -- 6 Hz counter for ~1000 16th notes
	);
end component;

component nes_controller is 
	port (
		-- External/Physical IO
		data : in std_logic;
		clock : out std_logic;
		latch : out std_logic;
		
		-- Internal IO
		clk : in std_logic;
		a : out std_logic;
		b : out std_logic;
		slct : out std_logic;
		start : out std_logic;
		up : out std_logic;
		down : out std_logic;
		lft : out std_logic;
		rght : out std_logic
	);
end component;

component debounce is 
	generic (
		frames : unsigned(5 downto 0) := 6d"11"
	);
	port(
		clk : in std_logic;
		input : in std_logic;
		output : out std_logic
	);
end component;

 component square is
  port(
   clk : in std_logic;
            lngth : in std_logic_vector(15 downto 0);
            output : out std_logic
        );
    end component;
    component keysDecoder is
        port(
            clk : in std_logic;
            input : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(15 downto 0)
        );
    end component;
    component song_rom is
        generic(
            ADDR_WIDTH : natural := 9;
            WORD_SIZE : natural := 4 
        );
        port(
            clk : in std_logic;
            addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
            data : out std_logic_vector(WORD_SIZE - 1 downto 0)
        );
    end component;

	--VGA STUFF
	signal internalclock : std_logic;
	signal row : unsigned (9 downto 0);
	signal col : unsigned (9 downto 0);
	signal valid : std_logic;
	
	--OTHER CLOCKS
	signal note1_out : unsigned(9 downto 0);
	signal note2_out : unsigned(13 downto 0);
	signal sample_out : std_logic;
	signal nes_out : std_logic;

	--START DEBOUNCE
	signal start_debounced : std_logic;
	signal a_debounced : std_logic;
	signal lft_debounced : std_logic;
	signal rght_debounced : std_logic;
	
	--SOUND SIGNALS
	signal lngth : std_logic_vector (15 downto 0);
	signal note : std_logic_vector (3 downto 0);
	signal key_sound : std_logic;
	signal dead_key1_sound : std_logic;
	
	--WHAT KEY WERE AT RN
	signal key : std_logic_vector(4 downto 0);
	
	signal dead_key1 : std_logic_vector(15 downto 0);
	
	signal state : std_logic;
	signal full_song : std_logic;
	signal lngth2 : std_logic_vector (15 downto 0);

begin

	--PORT MAPPING
	pll: mypll port map (input_clock, '1', output_clock, internalclock);
	myvga: vga port map (internalclock, row, col, valid, HSYNC, VSYNC);
	the_pattern_gen: pattern_gen port map (internalclock, row, col, valid, VSYNC, a_debounced, lft_debounced, rght_debounced, start_debounced, note, note2_out(12 downto 0), key, RGB, state);
	the_divider: clock_divider port map (internalclock, start_debounced, sample_out, nes_out, note1_out, note2_out);
	the_nes: nes_controller port map (data, clock, latch, nes_out, a, b, slct, start, up, down, lft, rght);
	start_debouncer : debounce generic map ("111111") port map (VSYNC, start, start_debounced);
	lft_debouncer : debounce port map (VSYNC, lft, lft_debounced);
	rght_debouncer : debounce port map (VSYNC, rght, rght_debounced);
	a_debouncer : debounce port map (VSYNC, a, a_debounced);
	
	sqr : square port map(internalclock, lngth, full_song);
	rom : song_rom port map(internalclock, std_logic_vector(note1_out(8 downto 0)), note);
    dec : keysDecoder port map(internalclock, note, lngth);
	
	sqr2 : square port map(internalclock, lngth2, key_sound);
    dec2 : keysDecoder port map(internalclock, key(3 downto 0), lngth2);
	
	sqr3 : square port map(internalclock, dead_key1, dead_key1_sound);
	
	dead_key1 <= "1011101110101100" when key(4) = '1' else 16b"0";

	audio_out <= full_song when state = '0' else key_sound when a = '1' and key(4) = '0' and state = '1' else dead_key1_sound when a = '1' and key(4) = '1' and state = '1' else '0';
end;