----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 12:13:03
-- Design Name: 
-- Module Name: Addition - Behavioral
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

entity Addition is
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0);
           secondIn : in STD_LOGIC_VECTOR (11 downto 0);
           opp : in  STD_LOGIC_VECTOR (2 downto 0);
           returnVal : out STD_LOGIC_VECTOR (11 downto 0));
end Addition;



architecture Behavioral of Addition is

begin

process(firstIn, secondIn, opp)
    variable buff, negNumber : STD_LOGIC_VECTOR (10 downto 0);
        begin
        if(opp = "000") then
            if (firstIN(0) = '1' and secondIn(0) = '1') then
                buff := firstIN(10 downto 0) + secondIn(10 downto 0);
                returnVal <= "100000000000" + buff;
                
            elsif (firstIn(0) = '1') then
                if (firstIn(10 downto 0) > secondIn(10 downto 0)) then
                    --negative result
                    negNumber := not(firstIn(10 downto 0)) + '1';
                    buff := negNumber(10 downto 0) + secondIn(10 downto 0);
                    returnVal <= "100000000000" + buff;
                else
                    --Positive
                end if;
            elsif (secondIn(0) = '1') then
                if (firstIn(10 downto 0) > secondIn(10 downto 0)) then
                    --Positive
                else
                    --Negative
                    negNumber := not(secondIn(10 downto 0)) + '1';
                    buff := firstIN(10 downto 0) + secondIn(10 downto 0);
                    returnVal <= "100000000000" + buff;
                end if;
            else
                returnVal <= firstIn + secondIn;
            end if;
        elsif(opp = "001") then -- Sub
        
        elsif(opp = "010") then -- Mult
        
        elsif(opp = "011") then -- Div
        
        elsif(opp = "100") then -- Squared
        
        else 
            -- Fuked upp somehow
            
        end if;
       -- figure out how to find if returnVal is negitive and return if it is!!!
       -- check which is bigger and do the stuff
   end process;

end Behavioral;
