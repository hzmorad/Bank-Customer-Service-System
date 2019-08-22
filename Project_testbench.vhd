----------------------- IEEE LIBRARIES ------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

----------------------- TB ENTITY -----------------------------
ENTITY testbench IS
END ENTITY testbench;

----------------------- TB ARCHITECTURE -----------------------
ARCHITECTURE test_dff OF testbench IS

----------------------- DFF INSTANCE (DUT) --------------------
COMPONENT SBqm
PORT ( clk, reset: in std_logic;
	q_in, q_out: in std_logic;
	teller_1, teller_2, teller_3: in std_logic;
	empty_fg, full_fg: out std_logic;
	seven_segment_1: out std_logic_vector (6 downto 0);
	seven_segment_2: out std_logic_vector (6 downto 0);
	seven_segment_3: out std_logic_vector (6 downto 0));
END COMPONENT SBqm;
FOR SB: SBqm USE ENTITY WORK.SBqm (struct);

----------------------- DECLARING SIGNALS ---------------------
SIGNAL clock, rst, queue_in, queue_out: std_logic;
SIGNAL t_1, t_2, t_3: std_logic;
SIGNAL e_fg, f_fg: std_logic;
SIGNAL s_seg_1, s_seg_2, s_seg_3: std_logic_vector (6 downto 0);

BEGIN

----------------------- PORT MAPPING ---------------------------
SB: SBqm PORT MAP(clock, rst, queue_in, queue_out, t_1, t_2, t_3, e_fg, f_fg, s_seg_1, s_seg_2, s_seg_3);

pd: PROCESS IS

----------------------- FILE OPEN ------------------------------
FILE file_test: text OPEN READ_MODE IS "test_vectors.txt"; --"test_vectors_dff.txt"
FILE file_output: text open write_mode is "output_dff.txt"; --"output_dff.txt"

---------------------- DECLARING VARIABLES ---------------------
--VARIABLE ln: line;
--VARIABLE ol: line;
--VARIABLE d_in_file, clock_in_file, rst_in_file, q_out_file: std_logic;
--VARIABLE pause: time;
--VARIABLE message: string (1 TO 5);
--VARIABLE o_message: string (1 to 7) := "qout = ";
--VARIABLE o_q_out : std_logic;
VARIABLE ln: line;
VARIABLE ol: line;
VARIABLE clock_in_file, rst_in_file, queue_in_in_file, queue_out_in_file: std_logic;
VARIABLE t1_in_file, t2_in_file, t3_in_file: std_logic;
VARIABLE e_fg_in_file, f_fg_in_file: std_logic;
VARIABLE s_seg_1_in_file, s_seg_2_in_file, s_seg_3_in_file: std_logic_vector (6 downto 0);
VARIABLE pause: time;
--VARIABLE message: string (1 TO 5);
VARIABLE o_empty_fg_message: string (1 to 13) := "empty_flag = ";
VARIABLE o_full_fg_message: string (1 to 17) := "     full_flag = ";
VARIABLE o_seven_seg_1_decoder_message: string (1 to 37) := "     Pcount_seven_segement_decoder = ";
VARIABLE o_seven_seg_2_decoder_message: string (1 to 39) := "     Tcount_seven_segement_1_decoder = ";
VARIABLE o_seven_seg_3_decoder_message: string (1 to 39) := "     Tcount_seven_segement_2_decoder = ";
VARIABLE o_e_fg, o_f_fg: std_logic;
VARIABLE o_s_seg_1, o_s_seg_2, o_s_seg_3: std_logic_vector (6 downto 0);

BEGIN

--------------------- INITIALIZATION INPUTS --------------------
--d_in<='1'; clock<='0'; rst<='1'; --WAIT FOR 15 ns;
clock<='1'; rst<='0'; queue_in<='0'; queue_out<='0'; t_1<='0'; t_2<='0'; t_3<='0'; --WAIT FOR 15 ns;

--------------------- LOOP TO READ FROM FILE -------------------
--WHILE NOT endfile(file_test) LOOP
--readline (file_test,ln);
--read (ln,d_in_file);
--read (ln,clock_in_file);
--read (ln,rst_in_file); --will take the value and the unit (ex. "5 ns")
--read (ln,pause);
--read (ln,q_out_file);
--read (ln,message);
WHILE NOT endfile(file_test) LOOP
readline (file_test,ln);
read (ln,clock_in_file);
read (ln,rst_in_file); --will take the value and the unit (ex. "5 ns")
read (ln,queue_in_in_file);
read (ln,queue_out_in_file);
read (ln,t1_in_file);
read (ln,t2_in_file);
read (ln,t3_in_file);
read (ln,pause);
read (ln,e_fg_in_file);
read (ln,f_fg_in_file);
read (ln,s_seg_1_in_file);
read (ln,s_seg_2_in_file);
read (ln,s_seg_3_in_file);
--read (ln,message);

----ASSIGNING IMPORTED VALUES TO DUT SIGNALS -------------------
--d_in<=d_in_file; clock<=clock_in_file; rst<=rst_in_file;
clock<=clock_in_file; rst<=rst_in_file; queue_in<=queue_in_in_file; queue_out<=queue_out_in_file;
t_1<=t1_in_file; t_2<=t2_in_file; t_3<=t3_in_file;

----- WRITING OUTPUT TO FILE -----------------------------------
--write (ol,o_message);
--write (ol,q_out);
--writeline (file_output,ol);
write (ol,o_empty_fg_message);
write (ol,e_fg);
write (ol,o_full_fg_message);
write (ol,f_fg);
write (ol,o_seven_seg_1_decoder_message);
write (ol,s_seg_1);
write (ol,o_seven_seg_2_decoder_message);
write (ol,s_seg_2);
write (ol,o_seven_seg_3_decoder_message);
write (ol,s_seg_3);
writeline (file_output,ol);

----- WAIT AND ASSERT STATEMENTS FOR DEBUGGING -----------------
WAIT FOR pause;
--ASSERT q_out=q_out_file; --check if q_out==1 then report true else severity error
Assert e_fg=e_fg_in_file
report "design error in empty flag";
Assert f_fg=f_fg_in_file
report "design error in full flag";
Assert s_seg_1=s_seg_1_in_file
report "design error in sev_seg_1";
Assert s_seg_2=s_seg_2_in_file
report "design error in sev_seg_2";
Assert s_seg_3=s_seg_3_in_file
report "design error in sev_seg_3"
--REPORT message
SEVERITY warning;
END LOOP;

----- CLOSING FILES --------------------------------------------
file_close(file_test);
file_close(file_output);

WAIT;
END PROCESS pd;
END ARCHITECTURE test_dff;