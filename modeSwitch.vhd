----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2021 16:35:48
-- Design Name: 
-- Module Name: modeSwitch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modeSwitch is    -- the modual to change the given mode of operation
                        -- this handles the changes between inputting values, handeling the operation selection
                        -- and when the results are shown 
                        -- this also stores the values for the inputs so they can be used in other components
    Port (clk : in std_logic; -- input clock
          mode : out std_logic_vector (1 downto 0); -- the current mode. 00 = first in, 01 = second in, 10 = operation, 11 = result
          BTNCIN : in std_logic; -- the input button to change between states
          resetBut : in std_logic; -- the input button to reset the board
          numInput : in std_logic_vector (11 downto 0); -- the 12 bit input number from the switches
          num1 : out std_logic_vector (11 downto 0); -- the storage of the first input number
          num2 : out std_logic_vector (11 downto 0); -- the storage for the second input number
          operation : out std_logic_vector (2 downto 0)); -- the operation to be computed on the two inputs
end modeSwitch;


architecture Behavioral of modeSwitch is
    type state_t2 is (NUMB1, NUMB2, OP, DISP); -- creates a state machine going between inputs operations and result value
    signal state2 : state_t2 := NUMB1; -- sets initial state
begin
--variable resetVar;
process(CLK, resetBut)
    begin
    
--    if reset = '1' then
--        state <= NUM1;
--        state2 <= released;
-- Reset not working so scrapped
    if (rising_edge(CLK) and BTNCIN = '1') then -- on rising clock edge 
         case state2 is -- goes through each of the states
            when NUMB1 =>
                num1 <= numInput; -- sets first input
                state2 <= numb2; -- sets the next state in state machine
                mode <= "01"; -- sets the mode to take in the second number
            when NUMB2 =>
                num2 <= numInput; -- sets second input
                state2 <= OP; -- sets the next state in state machine
                mode <= "10"; -- sets the mode to take the operator
            when OP =>
                operation <= numInput(2 downto 0); -- ouputs the desired operation
                state2 <= DISP; -- sets the next state in state machine
                mode <= "11"; -- sets the mode to take the display result
                when DISP =>
                --DISPLAY RESULT
                state2 <= NUMB1; -- sets the next state in state machine
                mode <= "00"; -- resets the mode to take in the first number again
        end case;
    end if;  
       
end process;
    

end Behavioral;
