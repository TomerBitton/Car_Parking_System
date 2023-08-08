-- VHDL code for car parking system
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Car_Parking_System_VHDL is
port 
(
  clk,reset_n: in std_logic; -- clock and reset of the car parking system
  front_sensor, back_sensor: in std_logic; -- two sensor in front and behind the gate of the car parking system
  password_1, password_2: in std_logic_vector(1 downto 0); -- input password 
  GREEN_LED,RED_LED: out std_logic -- signaling LEDs
);
end Car_Parking_System_VHDL;

-- right password for password_1 is "01" and for password_2 is "10"

architecture Behavioral of Car_Parking_System_VHDL is
-- FSM States
type FSM_States is (IDLE,WAIT_PASSWORD,WRONG_PASS,RIGHT_PASS,STOP);
signal current_state,next_state: FSM_States;
signal red_tmp, green_tmp: std_logic;

begin
-- Sequential circuits
process(clk,reset_n)
begin
 if(reset_n='0') then
  current_state <= IDLE;
 elsif(rising_edge(clk)) then
  current_state <= next_state;
 end if;
end process;

-- combinational logic
process(current_state,front_sensor,password_1,password_2,back_sensor)
 begin
 case current_state is 
 when IDLE =>
 if(front_sensor = '1') then -- if the front sensor is on,
 -- there is a car going to the gate
  next_state <= WAIT_PASSWORD;-- wait for password
  else 
  next_state <= IDLE;
  end if;
  
 when WAIT_PASSWORD =>
 if((password_1="01") and (password_2="10")) then
  next_state <= RIGHT_PASS; -- if password is correct, let them in
 else
 next_state <= WRONG_PASS; -- if not,let them input the password again
 end if;
 
 when WRONG_PASS =>
 if((password_1="01") and (password_2="10")) then
  next_state <= RIGHT_PASS; -- if password is correct, let them in
 else
  next_state <= WRONG_PASS;
 end if;
  
  when RIGHT_PASS =>
  if(front_sensor='1' and back_sensor = '1') then
   next_state <= STOP; 
  elsif(back_sensor = '1' and front_sensor='0') then
   next_state <= IDLE;
  else
   next_state <= RIGHT_PASS;
  end if;
  
  when STOP =>
  if((password_1="01")and(password_2="10"))then
  -- check password of the next car
  -- if the password is correct, let them in
   next_state <= RIGHT_PASS;
  else
   next_state <= STOP;
 end if;
 when others => next_state <= IDLE;
 end case;
 end process;

-- output 
 process(clk) -- LED checking
 begin
 if(rising_edge(clk)) then
 case(current_state) is
 when IDLE => 
 if next_state = IDLE then
 green_tmp <= '0';
 red_tmp <= '0';
 elsif next_state = WAIT_PASSWORD then
 green_tmp <= '0';
 red_tmp <= '1';
 end if;
 
 when WAIT_PASSWORD =>
 if next_state = RIGHT_PASS then
 green_tmp <= '1';
 red_tmp <= '0';
 elsif next_state = WRONG_PASS then
 green_tmp <= '0';
 red_tmp <= '1';
 end if;
 
 when WRONG_PASS =>
 if next_state = RIGHT_PASS then
 green_tmp <= '1';
 red_tmp <= '0';
 elsif next_state = WRONG_PASS then
 green_tmp <= '0'; 
 red_tmp <= '1';
 end if;
 
 when RIGHT_PASS =>
 green_tmp <= '1';
 red_tmp <= '0'; 
 if next_state = STOP then
 green_tmp <= '0';
 red_tmp <= '1';
 elsif next_state = IDLE then
 green_tmp <= '0';
 red_tmp <= '0';
 end if;
 
 when STOP =>
 if next_state = RIGHT_PASS then
 green_tmp <= '1';
 red_tmp <= '0';
 elsif next_state = WRONG_PASS then
 green_tmp <= '0';
 red_tmp <= '1'; 
 end if;
 
 when others => 
 green_tmp <= '0';
 red_tmp <= '0';
 end case;
 end if;
 end process;
  RED_LED <= red_tmp  ;
  GREEN_LED <= green_tmp;
end Behavioral;