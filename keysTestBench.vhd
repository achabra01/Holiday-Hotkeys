library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all; --imports text io

entity testbench is
end testbench;

architecture sim of testbench is
    component square is
        port(
            clk : in std_logic;
            length : in std_logic_vector(15 downto 0);
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
    component keys is
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

    signal clk, output : std_logic := '0';
    signal length : std_logic_vector(15 downto 0);
    signal note : std_logic_vector(3 downto 0);
    signal time : unsigned(8 downto 0) := 9b"0";

begin
    sqr : square port map(clk, length, output);
    rom : keys port map(clk, std_logic_vector(time), note);
    dec : keysDecoder port map(clk, note, length);
    process begin
        clk <= NOT clk;
        wait for 39 ns;
    end process;
    process begin
        time <= time + 1;
        wait for 67 ms;
    end process;
end sim;
