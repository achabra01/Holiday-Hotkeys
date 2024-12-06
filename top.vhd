library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is 
	port(
		input_clock 	: in std_logic;
		reset 			: in std_logic;
		output_clock 	: out std_logic;
		RGB 			: out std_logic_vector(5 downto 0);
		HSYNC			: out std_logic;
		VSYNC			: out std_logic
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
	  rgb : out std_logic_vector (5 downto 0)
	);
end component;

	--VGA STUFF
	signal internalclock : std_logic;
	signal row : unsigned (9 downto 0);
	signal col : unsigned (9 downto 0);
	signal valid : std_logic;

begin

	--PORT MAPPING
	pll: mypll port map (input_clock, '1', output_clock, internalclock);
	myvga: vga port map (internalclock, row, col, valid, HSYNC, VSYNC);
	the_pattern_gen: pattern_gen port map (internalclock, row, col, valid, VSYNC, reset, RGB);
end;
