library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROM_out_converter is
Port ( input  : in STD_LOGIC_VECTOR (7 downto 0);
output : out STD_LOGIC_VECTOR (7 downto 0));
end ROM_out_converter;

architecture behav of ROM_out_converter is
begin

process(input)
begin

case input is
when "00000000" =>
output <= "11110000"; ---0
when "00000001" =>
output <= "11110001"; ---1
when "00000010" =>
output <= "11110010"; ---2
when "00000011" =>
output <= "11110011"; ---3
when "00000100" =>
output <= "11110100"; ---4
when "00000101" =>
output <= "11110101"; ---5
when "00000110" =>
output <= "11110110"; ---6
when "00000111" =>
output <= "11110111"; ---7
when "00001000" =>
output <= "11111000"; ---8
when "00001001" =>
output <= "11111001"; ---9
when "00001010" =>
output <= "00010000"; ---10
when "00001011" =>
output <= "00010001"; ---11
when "00001100" =>
output <= "00010010"; ---12
when "00001101" =>
output <= "00010011"; ---13
when "00001110" =>
output <= "00010100"; ---14
when "00001111" =>
output <= "00010101"; ---15
when "00010000" =>
output <= "00010110"; ---16
when "00010001" =>
output <= "00010111"; ---17
when "00010010" =>
output <= "00011000"; ---18
when "00010011" =>
output <= "00011001"; ---19
when "00010100" =>
output <= "00100000"; ---20
when "00010101" =>
output <= "00100001"; ---21
when "00010110" =>
output <= "00100010"; ---22
when "00010111" =>
output <= "00100011"; ---23
when "00011000" =>
output <= "00100100"; ---24
when "00011001" =>
output <= "00100101"; ---25
when "00011010" =>
output <= "00100110"; ---26
when "00011011" =>
output <= "00100111"; ---27
when "00011100" =>
output <= "00101000"; ---28
when "00011101" =>
output <= "00101001"; ---29
when "00011110" =>
output <= "00110000"; ---30
when "00011111" =>
output <= "00110001"; ---31
when others =>
output <= "11111111"; ---null
end case;

end process;

end behav;