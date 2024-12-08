library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity key_select is 
	generic (
		key_select_start : unsigned(9 downto 0) := 10d"480";
		key_select_end : unsigned(9 downto 0) := 10d"600";
		bar_color : std_logic_vector(5 downto 0) := "111100"
	);
	port(
		clk : in std_logic;
		lft : in std_logic;
		rght : in std_logic;
		valid : in std_logic;
		row : in unsigned(9 downto 0);
		col : in unsigned(9 downto 0);
		rgb : out std_logic_vector(5 downto 0)
	);
end key_select;

architecture synth of key_select is

type STATE is (KEY1, KEY2, KEY3, KEY4, KEY5, KEY6, KEY7, KEY8, KEY9, KEY10, KEY11, KEY12, KEY13, KEY14, KEY15, KEY16, KEY17);
signal curr_key : STATE := KEY9;
signal change : std_logic;
signal col_limiter : std_logic_vector(5 downto 0);
signal select_bar : std_logic_vector(5 downto 0);

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

begin

col_limiter <= select_bar when (col >= key_select_start) and (col < key_select_end) else "000000";
rgb <= "000000" when valid = '0' else col_limiter;
--col_limiter <= select_bar;
tile1_data <= bar_color when row >= 1 and row < 29 else "000000";
tile2_data <= bar_color when row >= 29 and row < 57 else "000000";
tile3_data <= bar_color when row >= 57 and row < 85 else "000000";
tile4_data <= bar_color when row >= 87 and row < 113 else "000000";
tile5_data <= bar_color when row >= 113 and row < 141 else "000000";
tile6_data <= bar_color when row >= 142 and row < 170 else "000000";
tile7_data <= bar_color when row >= 170 and row < 198 else "000000";
tile8_data <= bar_color when row >= 198 and row < 226 else "000000";
tile9_data <= bar_color when row >= 226 and row < 254 else "000000";
tile10_data <= bar_color when row >= 254 and row < 282 else "000000";
tile11_data <= bar_color when row >= 282 and row < 310 else "000000";
tile12_data <= bar_color when row >= 310 and row < 338 else "000000";
tile13_data <= bar_color when row >= 339 and row < 367 else "000000";
tile14_data <= bar_color when row >= 367 and row < 395 else "000000";
tile15_data <= bar_color when row >= 395 and row < 423 else "000000";
tile16_data <= bar_color when row >= 423 and row < 451 else "000000";
tile17_data <= bar_color when row >= 451 and row < 479 else "000000";


select_bar <= tile1_data when (curr_key = KEY1) else
		  tile2_data when (curr_key = KEY2) else
		  tile3_data when (curr_key = KEY3) else
		  tile4_data when (curr_key = KEY4) else
		  tile5_data when (curr_key = KEY5) else
		  tile6_data when (curr_key = KEY6) else
		  tile7_data when (curr_key = KEY7) else
		  tile8_data when (curr_key = KEY8) else
		  tile9_data when (curr_key = KEY9) else
		  tile10_data when (curr_key = KEY10) else
		  tile11_data when (curr_key = KEY11) else
		  tile12_data when (curr_key = KEY12) else
		  tile13_data when (curr_key = KEY13) else
		  tile14_data when (curr_key = KEY14) else
		  tile15_data when (curr_key = KEY15) else
		  tile16_data when (curr_key = KEY16) else
		  tile17_data when (curr_key = KEY17) else
		  "000000";

process (clk) begin
  if rising_edge(clk) then
  
	case curr_key is
	  when KEY1 => if (lft = '1') then curr_key <= KEY2; 
				   elsif (rght = '1') then curr_key <= KEY17;
				   else curr_key <= KEY1; end if;
				   
	  when KEY2 => if (lft = '1') then curr_key <= KEY3; 
				   elsif (rght = '1') then curr_key <= KEY1;
				   else curr_key <= KEY2; end if;
				   
	  when KEY3 => if (lft = '1') then curr_key <= KEY4; 
				   elsif (rght = '1') then curr_key <= KEY2;
				   else curr_key <= KEY3; end if;
				   
	  when KEY4 => if (lft = '1') then curr_key <= KEY5; 
				   elsif (rght = '1') then curr_key <= KEY3;
				   else curr_key <= KEY4; end if;
				   
	  when KEY5 => if (lft = '1') then curr_key <= KEY6; 
				   elsif (rght = '1') then curr_key <= KEY4;
				   else curr_key <= KEY5; end if;
				   
	  when KEY6 => if (lft = '1') then curr_key <= KEY7; 
				   elsif (rght = '1') then curr_key <= KEY5;
				   else curr_key <= KEY6; end if;
				   
	  when KEY7 => if (lft = '1') then curr_key <= KEY8; 
				   elsif (rght = '1') then curr_key <= KEY6;
				   else curr_key <= KEY7; end if;
				   
	  when KEY8 => if (lft = '1') then curr_key <= KEY9; 
				   elsif (rght = '1') then curr_key <= KEY7;
				   else curr_key <= KEY8; end if;
				   
	  when KEY9 => if (lft = '1') then curr_key <= KEY10; 
				   elsif (rght = '1') then curr_key <= KEY8;
				   else curr_key <= KEY9; end if;
				   
	  when KEY10 => if (lft = '1') then curr_key <= KEY11; 
				   elsif (rght = '1') then curr_key <= KEY9;
				   else curr_key <= KEY10; end if;
				   
	  when KEY11 => if (lft = '1') then curr_key <= KEY12; 
				   elsif (rght = '1') then curr_key <= KEY10;
				   else curr_key <= KEY11; end if;
				   
	  when KEY12 => if (lft = '1') then curr_key <= KEY13; 
				   elsif (rght = '1') then curr_key <= KEY11;
				   else curr_key <= KEY12; end if;
				   
	  when KEY13 => if (lft = '1') then curr_key <= KEY14; 
				   elsif (rght = '1') then curr_key <= KEY12;
				   else curr_key <= KEY13; end if;
				   
	  when KEY14 => if (lft = '1') then curr_key <= KEY15; 
				   elsif (rght = '1') then curr_key <= KEY13;
				   else curr_key <= KEY14; end if;
				   
	  when KEY15 => if (lft = '1') then curr_key <= KEY16; 
				   elsif (rght = '1') then curr_key <= KEY14;
				   else curr_key <= KEY15; end if;
				   
	  when KEY16 => if (lft = '1') then curr_key <= KEY17; 
				   elsif (rght = '1') then curr_key <= KEY15;
				   else curr_key <= KEY16; end if;
				   
	  when KEY17 => if (lft = '1') then curr_key <= KEY1; 
				   elsif (rght = '1') then curr_key <= KEY16;
				   else curr_key <= KEY17; end if;
	end case;
  end if;
end process;
end;
