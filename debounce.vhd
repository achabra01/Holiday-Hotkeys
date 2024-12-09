library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debounce is 
	generic (
		frames : unsigned(5 downto 0) := 6d"11"
	);
	port(
		clk : in std_logic;
		input : in std_logic;
		output : out std_logic
	);
end debounce;

architecture synth of debounce is

type STATE is (WAITING, COOLDOWN);
signal curr_state : STATE := WAITING;
signal counter : unsigned(5 downto 0);

begin

process (clk) begin
	if rising_edge(clk) then
		case curr_state is
		  when WAITING => if (input = '1') then 
								curr_state <= COOLDOWN; 
								counter <= 6d"0";
					   else curr_state <= WAITING; end if;
					   
		  when COOLDOWN => if (counter < frames) then 
								curr_state <= COOLDOWN; 
								counter <= counter + 1;
					   else curr_state <= WAITING; end if;
		end case;
	end if;
	
	output <= '1' when counter = 0 else '0'; 
	
end process;
end;