library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; --for the conv_integer function
use ieee.std_logic_textio.all;
use std.textio.all;

entity rom is
	generic ( --n: integer := 5;
		  c: integer := 3;
		  t: integer := 2;
	          m: integer := 8);
	port ( --addr: in std_logic_vector (n-1 downto 0);
	       counter_value: in std_logic_vector (c-1 downto 0);
	       teller_1: in std_logic;
	       teller_2: in std_logic;
	       teller_3: in std_logic;
               --num_tellers: in std_logic_vector (t-1 downto 0);
	       clk: in std_logic;
	       data: out std_logic_vector (m-1 downto 0));
end entity rom;

architecture behav of rom is
	type rm is array (0 to 2**(c+t)-1) of std_logic_vector (m-1 downto 0); --((2**(c)-1)*(t+1)-1))
	--file f: text open READ_MODE is "rom.txt";
	impure function rom_fill return rm is
		variable memory: rm;
		--file f: text open READ_MODE is "rom.txt";
                FILE f: text OPEN READ_MODE IS "rom.txt";
		variable l: line;
	begin
		for index in memory'range loop
               -- WHILE NOT endfile (f) LOOP
			readline(f, l);
			read(l, memory(index));
		end loop;
		--file_close(f);
		return memory;
	end function rom_fill;
	constant word: rm := rom_fill;
        signal address: std_logic_vector ((c+t-1) downto 0);
        signal num_tellers: std_logic_vector (t-1 downto 0);
	--file_close(f);
begin
	--addr: process (teller_1, teller_2, teller_3) is
	--variable input: std_logic_vector (2 downto 0);
	--variable output: std_logic_vector (t-1 downto 0);
	--begin
	--	input := teller_1 & teller_2 & teller_3;
	--	case input is
	--	    when "000" => output := "00";
	--	    when "001" => output := "01";
	--	    when "010" => output := "01";
	--	    when "011" => output := "10";
	--	    when "100" => output := "01";
	--	    when "101" => output := "10";
	--	    when "110" => output := "10";
	--	    when "111" => output := "11";
	--	    when others =>
	--	end case;
	--	num_tellers <= output;
	--end process addr;
	memory: process (clk) is--, counter_value, teller_1, teller_2, teller_3) is
	variable input: std_logic_vector (2 downto 0);
	variable output: std_logic_vector (1 downto 0);
	--variable address: std_logic_vector ((c+t-1) downto 0);
	begin
		input := teller_1 & teller_2 & teller_3;
		case input is
		    when "000" => output := "00";
		    when "001" => output := "01";
		    when "010" => output := "01";
		    when "011" => output := "10";
		    when "100" => output := "01";
		    when "101" => output := "10";
		    when "110" => output := "10";
		    when "111" => output := "11";
		    when others =>
		end case;
		num_tellers <= output;
		address <= num_tellers((t-1) downto 0) & counter_value((c-1) downto 0);
		if ( clk'event and clk = '1' ) then
			data <= word(conv_integer(address));
		end if;
	end process memory;
end architecture behav;