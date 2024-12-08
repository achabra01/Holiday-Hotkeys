-- Template for generating a ROM module from a text file

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity song_rom is
    generic(
        ADDR_WIDTH : natural := 9;
        WORD_SIZE : natural := 4 
    );
    port(
        clk : in std_logic;
        addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        data : out std_logic_vector(WORD_SIZE - 1 downto 0)
    );
end song_rom;
-- Notes: r- 0000, f- 0001, G- 0010, g- 0011, A- 0100, a- 0101, B- 0110, C- 0111, c- 1000, D- 1001, d- 1010, E- 1011, hF- 1100, hf- 1101, hG- 1110, hA- 1111
-- We want to transpose this, so the actual keys being used for each number are:
-- (skip C), C# 1, D 2, D# 3,  E 4, F 5, F# 6, G 7, G# 8, A 9, A# 10, B 11, high C 12, high C# 13, (skip high D), high D# 14, high E 15
architecture synth of song_rom is
begin
    process (clk) begin
        if rising_edge(clk) then
            case addr is
                when 9b"0" => data <= "0010";

                when 9b"1" => data <= "0010";

                when 9b"10" => data <= "0010";

                when 9b"11" => data <= "0000";

                when 9b"100" => data <= "0010";

                when 9b"101" => data <= "0000";

                when 9b"110" => data <= "0000";

                when 9b"111" => data <= "0000";

                when 9b"1000" => data <= "0010";

                when 9b"1001" => data <= "0000";

                when 9b"1010" => data <= "0000";

                when 9b"1011" => data <= "0000";

                when 9b"1100" => data <= "0010";

                when 9b"1101" => data <= "0000";

                when 9b"1110" => data <= "0000";

                when 9b"1111" => data <= "0000";

                when 9b"10000" => data <= "1110";

                when 9b"10001" => data <= "0000";

                when 9b"10010" => data <= "0000";

                when 9b"10011" => data <= "0000";

                when 9b"10100" => data <= "1111";

                when 9b"10101" => data <= "0000";

                when 9b"10110" => data <= "0000";

                when 9b"10111" => data <= "0000";

                when 9b"11000" => data <= "1110";

                when 9b"11001" => data <= "1110";

                when 9b"11010" => data <= "1011";

                when 9b"11011" => data <= "1011";

                when 9b"11100" => data <= "0111";

                when 9b"11101" => data <= "0000";

                when 9b"11110" => data <= "0000";

                when 9b"11111" => data <= "0000";

                when 9b"100000" => data <= "1001";

                when 9b"100001" => data <= "0000";

                when 9b"100010" => data <= "0000";

                when 9b"100011" => data <= "0000";

                when 9b"100100" => data <= "1011";

                when 9b"100101" => data <= "0000";

                when 9b"100110" => data <= "0000";

                when 9b"100111" => data <= "0000";

                when 9b"101000" => data <= "1001";

                when 9b"101001" => data <= "1001";

                when 9b"101010" => data <= "0110";

                when 9b"101011" => data <= "0110";

                when 9b"101100" => data <= "0100";

                when 9b"101101" => data <= "0000";

                when 9b"101110" => data <= "0000";

                when 9b"101111" => data <= "0000";

                when 9b"110000" => data <= "0010";

                when 9b"110001" => data <= "0010";

                when 9b"110010" => data <= "0010";

                when 9b"110011" => data <= "0010";

                when 9b"110100" => data <= "0010";

                when 9b"110101" => data <= "0010";

                when 9b"110110" => data <= "0010";

                when 9b"110111" => data <= "0010";

                when 9b"111000" => data <= "0010";

                when 9b"111001" => data <= "0010";

                when 9b"111010" => data <= "0010";

                when 9b"111011" => data <= "0010";

                when 9b"111100" => data <= "0010";

                when 9b"111101" => data <= "0010";

                when 9b"111110" => data <= "0010";

                when 9b"111111" => data <= "0010";

                when 9b"1000000" => data <= "0010";

                when 9b"1000001" => data <= "0010";

                when 9b"1000010" => data <= "0010";

                when 9b"1000011" => data <= "0000";

                when 9b"1000100" => data <= "0100";

                when 9b"1000101" => data <= "0100";

                when 9b"1000110" => data <= "0110";

                when 9b"1000111" => data <= "0110";

                when 9b"1001000" => data <= "0111";

                when 9b"1001001" => data <= "0111";

                when 9b"1001010" => data <= "1001";

                when 9b"1001011" => data <= "1001";

                when 9b"1001100" => data <= "1011";

                when 9b"1001101" => data <= "1011";

                when 9b"1001110" => data <= "1100";

                when 9b"1001111" => data <= "1100";

                when 9b"1010000" => data <= "1110";

                when 9b"1010001" => data <= "0000";

                when 9b"1010010" => data <= "0000";

                when 9b"1010011" => data <= "0000";

                when 9b"1010100" => data <= "1111";

                when 9b"1010101" => data <= "0000";

                when 9b"1010110" => data <= "0000";

                when 9b"1010111" => data <= "0000";

                when 9b"1011000" => data <= "1110";

                when 9b"1011001" => data <= "1110";

                when 9b"1011010" => data <= "1011";

                when 9b"1011011" => data <= "1011";

                when 9b"1011100" => data <= "1001";

                when 9b"1011101" => data <= "1001";

                when 9b"1011110" => data <= "0111";

                when 9b"1011111" => data <= "0111";

                when 9b"1100000" => data <= "1001";

                when 9b"1100001" => data <= "0000";

                when 9b"1100010" => data <= "0000";

                when 9b"1100011" => data <= "0000";

                when 9b"1100100" => data <= "1001";

                when 9b"1100101" => data <= "1001";

                when 9b"1100110" => data <= "1011";

                when 9b"1100111" => data <= "1011";

                when 9b"1101000" => data <= "1001";

                when 9b"1101001" => data <= "1001";

                when 9b"1101010" => data <= "0111";

                when 9b"1101011" => data <= "0111";

                when 9b"1101100" => data <= "0100";

                when 9b"1101101" => data <= "0000";

                when 9b"1101110" => data <= "0000";

                when 9b"1101111" => data <= "0000";

                when 9b"1110000" => data <= "0111";

                when 9b"1110001" => data <= "0111";

                when 9b"1110010" => data <= "0111";

                when 9b"1110011" => data <= "0111";

                when 9b"1110100" => data <= "0111";

                when 9b"1110101" => data <= "0111";

                when 9b"1110110" => data <= "0111";

                when 9b"1110111" => data <= "0111";

                when 9b"1111000" => data <= "0111";

                when 9b"1111001" => data <= "0111";

                when 9b"1111010" => data <= "0111";

                when 9b"1111011" => data <= "0111";

                when 9b"1111100" => data <= "0111";

                when 9b"1111101" => data <= "0111";

                when 9b"1111110" => data <= "0111";

                when 9b"1111111" => data <= "0111";

                when 9b"10000000" => data <= "0111";

                when 9b"10000001" => data <= "0000";

                when 9b"10000010" => data <= "0000";

                when 9b"10000011" => data <= "0000";

                when 9b"10000100" => data <= "0010";

                when 9b"10000101" => data <= "0000";

                when 9b"10000110" => data <= "0000";

                when 9b"10000111" => data <= "0000";

                when 9b"10001000" => data <= "0010";

                when 9b"10001001" => data <= "0000";

                when 9b"10001010" => data <= "0000";

                when 9b"10001011" => data <= "0000";

                when 9b"10001100" => data <= "0010";

                when 9b"10001101" => data <= "0000";

                when 9b"10001110" => data <= "0000";

                when 9b"10001111" => data <= "0000";

                when 9b"10010000" => data <= "0010";

                when 9b"10010001" => data <= "0000";

                when 9b"10010010" => data <= "0000";

                when 9b"10010011" => data <= "0000";

                when 9b"10010100" => data <= "0100";

                when 9b"10010101" => data <= "0000";

                when 9b"10010110" => data <= "0000";

                when 9b"10010111" => data <= "0000";

                when 9b"10011000" => data <= "1110";

                when 9b"10011001" => data <= "1110";

                when 9b"10011010" => data <= "1011";

                when 9b"10011011" => data <= "1011";

                when 9b"10011100" => data <= "0111";

                when 9b"10011101" => data <= "0000";

                when 9b"10011110" => data <= "0000";

                when 9b"10011111" => data <= "0000";

                when 9b"10100000" => data <= "1001";

                when 9b"10100001" => data <= "0000";

                when 9b"10100010" => data <= "0000";

                when 9b"10100011" => data <= "0000";

                when 9b"10100100" => data <= "1011";

                when 9b"10100101" => data <= "0000";

                when 9b"10100110" => data <= "0000";

                when 9b"10100111" => data <= "0000";

                when 9b"10101000" => data <= "1001";

                when 9b"10101001" => data <= "1001";

                when 9b"10101010" => data <= "0110";

                when 9b"10101011" => data <= "0110";

                when 9b"10101100" => data <= "0100";

                when 9b"10101101" => data <= "0000";

                when 9b"10101110" => data <= "0000";

                when 9b"10101111" => data <= "0000";

                when 9b"10110000" => data <= "0010";

                when 9b"10110001" => data <= "0010";

                when 9b"10110010" => data <= "0010";

                when 9b"10110011" => data <= "0010";

                when 9b"10110100" => data <= "0010";

                when 9b"10110101" => data <= "0010";

                when 9b"10110110" => data <= "0010";

                when 9b"10110111" => data <= "0010";

                when 9b"10111000" => data <= "0010";

                when 9b"10111001" => data <= "0010";

                when 9b"10111010" => data <= "0010";

                when 9b"10111011" => data <= "0010";

                when 9b"10111100" => data <= "0010";

                when 9b"10111101" => data <= "0010";

                when 9b"10111110" => data <= "0010";

                when 9b"10111111" => data <= "0010";

                when 9b"11000000" => data <= "0010";

                when 9b"11000001" => data <= "0010";

                when 9b"11000010" => data <= "0010";

                when 9b"11000011" => data <= "0000";

                when 9b"11000100" => data <= "0100";

                when 9b"11000101" => data <= "0100";

                when 9b"11000110" => data <= "0110";

                when 9b"11000111" => data <= "0110";

                when 9b"11001000" => data <= "0111";

                when 9b"11001001" => data <= "0111";

                when 9b"11001010" => data <= "1001";

                when 9b"11001011" => data <= "1001";

                when 9b"11001100" => data <= "1011";

                when 9b"11001101" => data <= "1011";

                when 9b"11001110" => data <= "1100";

                when 9b"11001111" => data <= "1100";

                when 9b"11010000" => data <= "1110";

                when 9b"11010001" => data <= "0000";

                when 9b"11010010" => data <= "0000";

                when 9b"11010011" => data <= "0000";

                when 9b"11010100" => data <= "1111";

                when 9b"11010101" => data <= "0000";

                when 9b"11010110" => data <= "0000";

                when 9b"11010111" => data <= "0000";

                when 9b"11011000" => data <= "1110";

                when 9b"11011001" => data <= "1110";

                when 9b"11011010" => data <= "1011";

                when 9b"11011011" => data <= "1011";

                when 9b"11011100" => data <= "1001";

                when 9b"11011101" => data <= "1001";

                when 9b"11011110" => data <= "0111";

                when 9b"11011111" => data <= "0111";

                when 9b"11100000" => data <= "1001";

                when 9b"11100001" => data <= "0000";

                when 9b"11100010" => data <= "0000";

                when 9b"11100011" => data <= "0000";

                when 9b"11100100" => data <= "1001";

                when 9b"11100101" => data <= "1001";

                when 9b"11100110" => data <= "1011";

                when 9b"11100111" => data <= "1011";

                when 9b"11101000" => data <= "1001";

                when 9b"11101001" => data <= "1001";

                when 9b"11101010" => data <= "0111";

                when 9b"11101011" => data <= "0111";

                when 9b"11101100" => data <= "0100";

                when 9b"11101101" => data <= "0000";

                when 9b"11101110" => data <= "0000";

                when 9b"11101111" => data <= "0000";

                when 9b"11110000" => data <= "0111";

                when 9b"11110001" => data <= "0111";

                when 9b"11110010" => data <= "0111";

                when 9b"11110011" => data <= "0111";

                when 9b"11110100" => data <= "0111";

                when 9b"11110101" => data <= "0111";

                when 9b"11110110" => data <= "0111";

                when 9b"11110111" => data <= "0111";

                when 9b"11111000" => data <= "0111";

                when 9b"11111001" => data <= "0111";

                when 9b"11111010" => data <= "0111";

                when 9b"11111011" => data <= "0111";

                when 9b"11111100" => data <= "0111";

                when 9b"11111101" => data <= "0111";

                when 9b"11111110" => data <= "0111";

                when 9b"11111111" => data <= "0111";

                when 9b"100000000" => data <= "0111";

                when 9b"100000001" => data <= "0111";

                when 9b"100000010" => data <= "0111";

                when 9b"100000011" => data <= "0000";

                when 9b"100000100" => data <= "0000";

                when 9b"100000101" => data <= "0000";

                when 9b"100000110" => data <= "0000";

                when 9b"100000111" => data <= "0000";

                when 9b"100001000" => data <= "0000";

                when 9b"100001001" => data <= "0000";

                when 9b"100001010" => data <= "0000";

                when 9b"100001011" => data <= "0000";

                when 9b"100001100" => data <= "0011";

                when 9b"100001101" => data <= "0011";

                when 9b"100001110" => data <= "0100";

                when 9b"100001111" => data <= "0100";

                when 9b"100010000" => data <= "1011";

                when 9b"100010001" => data <= "0000";

                when 9b"100010010" => data <= "0000";

                when 9b"100010011" => data <= "0000";

                when 9b"100010100" => data <= "0011";

                when 9b"100010101" => data <= "0011";

                when 9b"100010110" => data <= "0100";

                when 9b"100010111" => data <= "0100";

                when 9b"100011000" => data <= "1011";

                when 9b"100011001" => data <= "0000";

                when 9b"100011010" => data <= "0000";

                when 9b"100011011" => data <= "0000";

                when 9b"100011100" => data <= "0011";

                when 9b"100011101" => data <= "0011";

                when 9b"100011110" => data <= "0100";

                when 9b"100011111" => data <= "0100";

                when 9b"100100000" => data <= "1011";

                when 9b"100100001" => data <= "0000";

                when 9b"100100010" => data <= "0000";

                when 9b"100100011" => data <= "0000";

                when 9b"100100100" => data <= "0001";

                when 9b"100100101" => data <= "0001";

                when 9b"100100110" => data <= "0001";

                when 9b"100100111" => data <= "0000";

                when 9b"100101000" => data <= "1010";

                when 9b"100101001" => data <= "1010";

                when 9b"100101010" => data <= "1010";

                when 9b"100101011" => data <= "1010";

                when 9b"100101100" => data <= "1010";

                when 9b"100101101" => data <= "1010";

                when 9b"100101110" => data <= "1010";

                when 9b"100101111" => data <= "1010";

                when 9b"100110000" => data <= "0000";

                when 9b"100110001" => data <= "0000";

                when 9b"100110010" => data <= "0000";

                when 9b"100110011" => data <= "0000";

                when 9b"100110100" => data <= "1011";

                when 9b"100110101" => data <= "1011";

                when 9b"100110110" => data <= "1011";

                when 9b"100110111" => data <= "1011";

                when 9b"100111000" => data <= "1010";

                when 9b"100111001" => data <= "1010";

                when 9b"100111010" => data <= "0110";

                when 9b"100111011" => data <= "0110";

                when 9b"100111100" => data <= "0011";

                when 9b"100111101" => data <= "0011";

                when 9b"100111110" => data <= "0011";

                when 9b"100111111" => data <= "0011";

                when 9b"101000000" => data <= "1000";

                when 9b"101000001" => data <= "1000";

                when 9b"101000010" => data <= "1000";

                when 9b"101000011" => data <= "1000";

                when 9b"101000100" => data <= "1000";

                when 9b"101000101" => data <= "1000";

                when 9b"101000110" => data <= "1000";

                when 9b"101000111" => data <= "1000";

                when 9b"101001000" => data <= "1000";

                when 9b"101001001" => data <= "1000";

                when 9b"101001010" => data <= "1000";

                when 9b"101001011" => data <= "1000";

                when 9b"101001100" => data <= "1000";

                when 9b"101001101" => data <= "1000";

                when 9b"101001110" => data <= "1000";

                when 9b"101001111" => data <= "0000";

                when 9b"101010000" => data <= "0000";

                when 9b"101010001" => data <= "0000";

                when 9b"101010010" => data <= "0000";

                when 9b"101010011" => data <= "0000";

                when 9b"101010100" => data <= "1010";

                when 9b"101010101" => data <= "1010";

                when 9b"101010110" => data <= "1010";

                when 9b"101010111" => data <= "1010";

                when 9b"101011000" => data <= "1000";

                when 9b"101011001" => data <= "1000";

                when 9b"101011010" => data <= "0100";

                when 9b"101011011" => data <= "0100";

                when 9b"101011100" => data <= "0001";

                when 9b"101011101" => data <= "0001";

                when 9b"101011110" => data <= "0100";

                when 9b"101011111" => data <= "0000";

                when 9b"101100000" => data <= "1000";

                when 9b"101100001" => data <= "1000";

                when 9b"101100010" => data <= "1000";

                when 9b"101100011" => data <= "1000";

                when 9b"101100100" => data <= "1011";

                when 9b"101100101" => data <= "1011";

                when 9b"101100110" => data <= "1011";

                when 9b"101100111" => data <= "1011";

                when 9b"101101000" => data <= "1010";

                when 9b"101101001" => data <= "1010";

                when 9b"101101010" => data <= "1010";

                when 9b"101101011" => data <= "1010";

                when 9b"101101100" => data <= "0001";

                when 9b"101101101" => data <= "0001";

                when 9b"101101110" => data <= "0001";

                when 9b"101101111" => data <= "0000";

                when 9b"101110000" => data <= "0110";

                when 9b"101110001" => data <= "0110";

                when 9b"101110010" => data <= "0110";

                when 9b"101110011" => data <= "0110";

                when 9b"101110100" => data <= "0110";

                when 9b"101110101" => data <= "0110";

                when 9b"101110110" => data <= "0110";

                when 9b"101110111" => data <= "0110";

                when 9b"101111000" => data <= "0110";

                when 9b"101111001" => data <= "0110";

                when 9b"101111010" => data <= "0110";

                when 9b"101111011" => data <= "0110";

                when 9b"101111100" => data <= "0110";

                when 9b"101111101" => data <= "0110";

                when 9b"101111110" => data <= "0110";

                when 9b"101111111" => data <= "0110";

                when 9b"110000000" => data <= "0110";

                when 9b"110000001" => data <= "0110";

                when 9b"110000010" => data <= "0110";

                when 9b"110000011" => data <= "0110";

                when 9b"110000100" => data <= "0110";

                when 9b"110000101" => data <= "0110";

                when 9b"110000110" => data <= "0110";

                when 9b"110000111" => data <= "0000";

                when 9b"110001000" => data <= "0000";

                when 9b"110001001" => data <= "0000";

                when 9b"110001010" => data <= "0000";

                when 9b"110001011" => data <= "0000";

                when 9b"110001100" => data <= "0001";

                when 9b"110001101" => data <= "0001";

                when 9b"110001110" => data <= "0010";

                when 9b"110001111" => data <= "0010";

                when 9b"110010000" => data <= "1001";

                when 9b"110010001" => data <= "1001";

                when 9b"110010010" => data <= "1001";

                when 9b"110010011" => data <= "0000";

                when 9b"110010100" => data <= "0001";

                when 9b"110010101" => data <= "0001";

                when 9b"110010110" => data <= "0010";

                when 9b"110010111" => data <= "0010";

                when 9b"110011000" => data <= "1001";

                when 9b"110011001" => data <= "1001";

                when 9b"110011010" => data <= "1001";

                when 9b"110011011" => data <= "0000";

                when 9b"110011100" => data <= "0001";

                when 9b"110011101" => data <= "0001";

                when 9b"110011110" => data <= "0010";

                when 9b"110011111" => data <= "0010";

                when 9b"110100000" => data <= "1001";

                when 9b"110100001" => data <= "1001";

                when 9b"110100010" => data <= "1001";

                when 9b"110100011" => data <= "0000";

                when 9b"110100100" => data <= "1011";

                when 9b"110100101" => data <= "1011";

                when 9b"110100110" => data <= "1011";

                when 9b"110100111" => data <= "0000";

                when 9b"110101000" => data <= "1000";

                when 9b"110101001" => data <= "1000";

                when 9b"110101010" => data <= "1000";

                when 9b"110101011" => data <= "1000";

                when 9b"110101100" => data <= "1000";

                when 9b"110101101" => data <= "1000";

                when 9b"110101110" => data <= "1000";

                when 9b"110101111" => data <= "1000";

                when 9b"110110000" => data <= "0000";

                when 9b"110110001" => data <= "0000";

                when 9b"110110010" => data <= "0000";

                when 9b"110110011" => data <= "0000";

                when 9b"110110100" => data <= "1001";

                when 9b"110110101" => data <= "1001";

                when 9b"110110110" => data <= "1001";

                when 9b"110110111" => data <= "1001";

                when 9b"110111000" => data <= "1000";

                when 9b"110111001" => data <= "1000";

                when 9b"110111010" => data <= "0100";

                when 9b"110111011" => data <= "0100";

                when 9b"110111100" => data <= "0001";

                when 9b"110111101" => data <= "0001";

                when 9b"110111110" => data <= "0001";

                when 9b"110111111" => data <= "0001";

                when 9b"111000000" => data <= "0110";

                when 9b"111000001" => data <= "0110";

                when 9b"111000010" => data <= "0110";

                when 9b"111000011" => data <= "0110";

                when 9b"111000100" => data <= "0110";

                when 9b"111000101" => data <= "0110";

                when 9b"111000110" => data <= "0110";

                when 9b"111000111" => data <= "0110";

                when 9b"111001000" => data <= "0110";

                when 9b"111001001" => data <= "0110";

                when 9b"111001010" => data <= "0110";

                when 9b"111001011" => data <= "0110";

                when 9b"111001100" => data <= "0110";

                when 9b"111001101" => data <= "0110";

                when 9b"111001110" => data <= "0110";

                when 9b"111001111" => data <= "0110";

                when 9b"111010000" => data <= "0000";

                when 9b"111010001" => data <= "0000";

                when 9b"111010010" => data <= "0000";

                when 9b"111010011" => data <= "0000";

                when 9b"111010100" => data <= "1001";

                when 9b"111010101" => data <= "0000";

                when 9b"111010110" => data <= "0000";

                when 9b"111010111" => data <= "0000";

                when 9b"111011000" => data <= "0100";

                when 9b"111011001" => data <= "0100";

                when 9b"111011010" => data <= "0010";

                when 9b"111011011" => data <= "0000";

                when 9b"111011100" => data <= "1001";

                when 9b"111011101" => data <= "0000";

                when 9b"111011110" => data <= "0000";

                when 9b"111011111" => data <= "0000";

                when 9b"111100000" => data <= "0010";

                when 9b"111100001" => data <= "0000";

                when 9b"111100010" => data <= "0000";

                when 9b"111100011" => data <= "0000";

                when 9b"111100100" => data <= "0100";

                when 9b"111100101" => data <= "0000";

                when 9b"111100110" => data <= "1001";

                when 9b"111100111" => data <= "0000";

                when 9b"111101000" => data <= "0100";

                when 9b"111101001" => data <= "0000";

                when 9b"111101010" => data <= "0000";

                when 9b"111101011" => data <= "0000";

                when 9b"111101100" => data <= "0010";

                when 9b"111101101" => data <= "0000";

                when 9b"111101110" => data <= "1010";

                when 9b"111101111" => data <= "0000";

                when 9b"111110000" => data <= "0010";

                when 9b"111110001" => data <= "0000";

                when 9b"111110010" => data <= "0100";

                when 9b"111110011" => data <= "0000";

                when 9b"111110100" => data <= "1001";

                when 9b"111110101" => data <= "0000";

                when 9b"111110110" => data <= "0000";

                when 9b"111110111" => data <= "0000";

                when 9b"111111000" => data <= "0010";

                when 9b"111111001" => data <= "0000";

                when 9b"111111010" => data <= "0000";

                when 9b"111111011" => data <= "0000";

                when 9b"111111100" => data <= "1001";

                when 9b"111111101" => data <= "0000";

                when 9b"111111110" => data <= "0000";

                when 9b"111111111" => data <= "0000";

                when others => data <= (others => '0');
            end case;
        end if;
    end process;
end;
