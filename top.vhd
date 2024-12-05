library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is 
	port(
		input_clock 	: in std_logic;
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

	--VGA STUFF
	signal internalclock : std_logic;
	signal row : unsigned (9 downto 0);
	signal col : unsigned (9 downto 0);
	signal valid : std_logic;
	
	--PIANO STUFF
	signal piano_data : std_logic_vector (5 downto 0);

	--ROM STUFF
	--signal rom_addr : std_logic_vector (14 downto 0);
	signal rom_data : std_logic_vector (1 downto 0);

begin

	--ROM READING
	--rom_addr <= std_logic_vector(row(8 downto 2) & col (9 downto 2));


	--PORT MAPPING
	pll: mypll port map (input_clock, '1', output_clock, internalclock);
	myvga: vga port map (internalclock, row, col, valid, HSYNC, VSYNC);
	thepiano: piano port map (row, col, valid, piano_data);
	rom : my_rom port map (internalclock, std_logic_vector(row(8 downto 2)), std_logic_vector(col(9 downto 2)), rom_data);
	
	--rgb <= rom_data;
	rgb <= "000000" when rom_data = "00" else
	       "111111" when rom_data = "01" else
		   "110000" when rom_data = "10" else
		   "001100";
	
end;
