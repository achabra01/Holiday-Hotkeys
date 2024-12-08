library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity square is
    port(
        clk : in std_logic;
        length : in std_logic_vector(15 downto 0);
        output : out std_logic
    );
end square;

architecture synth of square is
    signal count : unsigned(16 downto 0) := 17b"0";
    signal low : unsigned(16 downto 0);
    signal high : unsigned(16 downto 0);
begin
    low <= unsigned('0' & length);
    high <= unsigned(length & '0');
    process (clk) begin
        if rising_edge(clk) then
            count <= count + 1;
            if NOR length then -- if length is 0000
                output <= '0';
            else
                output <= '1' when (count >= low) else '0';
                if count >= high then
                    count <= 17b"0";
                end if;
            end if;
        end if;
    end process;
end;
