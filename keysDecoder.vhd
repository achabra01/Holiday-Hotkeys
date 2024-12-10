library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity keysDecoder is
    port(
        clk : in std_logic;
        input : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(15 downto 0) := "0000000000000000"
    );
end keysDecoder;
architecture synth of keysDecoder is

begin
    process (clk) begin
        if rising_edge(clk) then
            case input is

                when 4b"1" => output <= "1011101110101100";

                when 4b"10" => output <= "1011000100100011";

                when 4b"11" => output <= "1010011100110010";

                when 4b"100" => output <= "1001010011110100";

                when 4b"101" => output <= "1000110010011000";

                when 4b"110" => output <= "1000010010110100";

                when 4b"111" => output <= "0111110101000001";

                when 4b"1000" => output <= "0111011000111010";

                when 4b"1001" => output <= "0110111110010111";

                when 4b"1010" => output <= "0110100101010100";

                when 4b"1011" => output <= "0110001101101010";

                when 4b"1100" => output <= "0101110111010110";

                when 4b"1101" => output <= "0101100010010010";

                when 4b"1110" => output <= "0101001110011001";

                when 4b"1111" => output <= "0100101001111010";

                when others => output <= (others => '0');
                
            end case;
        end if;
    end process;
end synth;
        

 