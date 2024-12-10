library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity piano is 
	port(
		row: in unsigned (9 downto 0);
		col: in unsigned (9 downto 0);
		valid: in std_logic;
		rgb: out std_logic_vector (5 downto 0)
	);
end piano;

architecture synth of piano is

signal piano_area : std_logic_vector (5 downto 0);
signal flat_area : std_logic_vector (5 downto 0);

begin
process (col) begin
	if valid = '1' then
	-- LOWER HALF
		-- key 1
		if row > 0 and row < 47 then
			piano_area <= "111111";
			
		-- key 2
		elsif row >= 48 and row < 95 then
			piano_area <= "111111";
			
		-- key 3
		elsif row >= 96 and row < 141 then
			piano_area <= "111111";
			
		-- key 4
		elsif row >= 142 and row < 188 then
			piano_area <= "111111";
			
		-- key 5
		elsif row >= 189 and row < 239 then
			piano_area <= "111111";
			
		-- key 6
		elsif row >= 240 and row < 291 then
			piano_area <= "111111";
			
		-- key 7	
		elsif row >= 292 and row < 338 then
			piano_area <= "111111";
			
		-- key 8
		elsif row >= 339 and row < 384 then
			piano_area <= "111111";
			
		-- key 9
		elsif row >= 385 and row < 434 then
			piano_area <= "111111";

		-- key 10
		elsif row >= 435 and row < 479 then
			piano_area <= "111111";

		-- lines between keys
		else 
			piano_area <= "000000";
		end if;
		
	-- UPPER HALF
		-- key 1
		if row >= 1 and row < 29 then
			flat_area <= "111111";
		
		-- key 2
		elsif row >= 29 and row < 57 then
			flat_area <= "000000";
		
		-- key 3
		elsif row >= 57 and row < 85 then
			flat_area <= "111111";
	
		-- key 4
		elsif row >= 87 and row < 113 then
			flat_area <= "000000";
		
		-- key 5
		elsif row >= 113 and row < 141 then
			flat_area <= "111111";
	
		-- key 6
		elsif row >= 142 and row < 170 then
			flat_area <= "111111";
	
		-- key 7
		elsif row >= 170 and row < 198 then
			flat_area <= "000000";
			
		-- key 8
		elsif row >= 198 and row < 226 then
			flat_area <= "111111";	

		-- key 9
		elsif row >= 226 and row < 254 then
			flat_area <= "000000";
			
		-- key 10
		elsif row >= 254 and row < 282 then
			flat_area <= "111111";	
			
		-- key 11
		elsif row >= 282 and row < 310 then
			flat_area <= "000000";	
			
		-- key 12
		elsif row >= 310 and row < 338 then
			flat_area <= "111111";	
			
		-- key 13
		elsif row >= 339 and row < 367 then
			flat_area <= "111111";	

		-- key 14
		elsif row >= 367 and row < 395 then
			flat_area <= "000000";	

		-- key 15
		elsif row >= 395 and row < 423 then
			flat_area <= "111111";	

		-- key 16
		elsif row >= 423 and row < 451 then
			flat_area <= "000000";	

		-- key 17
		elsif row >= 451 and row < 479 then
			flat_area <= "111111";	

		-- lines between keys
		else 
			flat_area <= "000000";
		end if;
	
		-- background
		if col < 511 then
			rgb <= "100000";
		elsif col < 591 then
			rgb <= flat_area;
		else
			rgb <= piano_area;
		end if;
		
	else 
		rgb <= "000000";
	end if;
	
end process;

end;