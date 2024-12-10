library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tile2 is 
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
end tile2;

architecture synth of tile2 is

signal step1 : unsigned (8 downto 0);
signal shifted_note_count : unsigned (8 downto 0);
signal test : std_logic_vector (5 downto 0);
signal note : std_logic_vector(3 downto 0);

signal key16 : std_logic_vector (5 downto 0);
signal key15 : std_logic_vector (5 downto 0);
signal key17 : std_logic_vector (5 downto 0);
signal key13 : std_logic_vector (5 downto 0);
signal key12 : std_logic_vector (5 downto 0);
signal key11 : std_logic_vector (5 downto 0);
signal key10 : std_logic_vector (5 downto 0);
signal key9 : std_logic_vector (5 downto 0);
signal key8 : std_logic_vector (5 downto 0);
signal key7 : std_logic_vector (5 downto 0);
signal key6 : std_logic_vector (5 downto 0);
signal key5 : std_logic_vector (5 downto 0);
signal key4 : std_logic_vector (5 downto 0);
signal key3 : std_logic_vector (5 downto 0);
signal key1 : std_logic_vector (5 downto 0);


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

begin

rom_for_graphics : song_rom port map(pll, std_logic_vector(shifted_note_count), note);

key17 <= "001111" when note = "0001" else "000000";
key16 <= "001111" when note = "0010" else "000000";
key15 <= "001111" when note = "0011" else "000000";
key13 <= "001111" when note = "0100" else "000000";
key12 <= "001111" when note = "0101" else "000000";
key11 <= "001111" when note = "0110" else "000000";
key10 <= "001111" when note = "0111" else "000000";
key9 <= "001111" when note = "1000" else "000000";
key8 <= "001111" when note = "1001" else "000000";
key7 <= "001111" when note = "1010" else "000000";
key6 <= "001111" when note = "1011" else "000000";
key5 <= "001111" when note = "1100" else "000000";
key4 <= "001111" when note = "1101" else "000000";
key3 <= "001111" when note = "1110" else "000000";
key1 <= "001111" when note = "1111" else "000000";

test <= "000000" when note = "0000" else 
		key17 when row >= 451 and row < 479 else
		key16 when row >= 423 and row < 451 else
		key15 when row >= 395 and row < 423 else
		key13 when row >= 339 and row < 367 else
		key12 when row >= 310 and row < 338 else
		key11 when row >= 282 and row < 310 else
		key10 when row >= 254 and row < 282 else
		key9 when row >= 226 and row < 254 else
		key8 when row >= 198 and row < 226 else
		key7 when row >= 170 and row < 198 else
		key6 when row >= 142 and row < 170 else
		key5 when row >= 113 and row < 141 else
		key4 when row >= 87 and row < 113 else
		key3 when row >= 57 and row < 85 else
		key1 when row >= 1 and row < 29 else
		"000000";


step1 <= ("000000" & note_count(3 downto 1)) - col(8 downto 0);
shifted_note_count <= ("000" & (step1(8 downto 3))) + note_count(12 downto 4);

rgb <= "000000" when valid = '0' else test;


end;