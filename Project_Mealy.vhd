LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity fsm is
	port ( clk, reset : in std_logic;
	       qin,qout: in std_logic;
		   empty_flag, full_flag: in std_logic;
		   count_state, count_enable: out std_logic);
end entity fsm;

architecture mealy_2p of fsm is
type state_type is (empty, available, full);
signal current_state: state_type;
signal next_state: state_type;
begin
	cs: process (clk, reset)
	begin
		if reset = '1' then
			current_state <= empty;
		elsif rising_edge (clk) then
			current_state <= next_state;
		end if;
	end process cs;
	
	ns: process (clk, reset)
	begin
		case current_state is
			when empty =>
				if qin='1' and qout='0' then
				        count_state<='1';
					count_enable<='1';
					next_state <= available;
				else
					count_state<='1';
					count_enable<='0';
					next_state <= empty;
				end if;
			when available =>
				if qin='1' and qout='0' then
					if full_flag='0' then
						count_state<='1';
						count_enable<='1';
						next_state <= available;
					else
						count_state<='0';
						count_enable<='0';
						next_state <= full;
					end if;
				elsif qin='0' and qout='1' then
					if empty_flag='0' then
						count_state<='0';
						count_enable<='1';
						next_state <= available;
					else
						count_state<='0';
						count_enable<='1';
						next_state <= empty;
					end if;
				else
						count_state<='0';
						count_enable<='0';
						next_state <= available;
				end if;
			when full =>
				if qin='0' and qout='1' then
				    	count_state<='0';
					count_enable<='1';
					next_state <= available;
				else
					count_state<='0';
					count_enable<='0';
					next_state <= full;
				end if;
		end case;
	end process ns;
end architecture mealy_2p;