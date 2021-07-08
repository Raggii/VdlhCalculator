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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Operations is
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0);
           secondIn : in STD_LOGIC_VECTOR (11 downto 0);
           opp : in  STD_LOGIC_VECTOR (2 downto 0);
           mode : in std_logic_vector (1 downto 0);
           returnVal : out STD_LOGIC_VECTOR (11 downto 0);
           overflow : out std_logic := '0'
           );
end Operations;



architecture Behavioral of Operations is

begin

process(firstIn, secondIn, opp, mode)
    variable buff, n, buff4 : STD_LOGIC_VECTOR (10 downto 0);
    variable buff2 : STD_LOGIC_VECTOR (11 downto 0);
    variable buff3 : std_logic_vector (21 downto 0);
        begin
        if (mode = "00") then
            overflow <= '0';
        end if;
        --Calculate result from inputs
        if(opp = "000") then -- addition
            buff := "00000000000";
            if (firstIN(11) = '1' and secondIn(11) = '1') then -- check if both inputs are negitive
                buff := firstIN(10 downto 0) + secondIn(10 downto 0); -- add the magnitude of the numbers
                returnVal <= '1' & buff; -- bit shift the answer by 1 because - + - is a negitive
                
            elsif (firstIn(11) = '1') then -- if one is negitive
                if (firstIn(10 downto 0) > secondIn(10 downto 0)) then
                    --negative result
                    buff := firstIn(10 downto 0) - secondIn(10 downto 0);
                    returnVal <= '1' & buff;
                else
                    --Positive
                    buff := secondIn(10 downto 0) - firstIn(10 downto 0);
                    returnVal <= '0' & buff;
                end if;
            elsif (secondIn(11) = '1') then -- check other negitive
                if (firstIn(10 downto 0) > secondIn(10 downto 0)) then
                    --Positive
                    buff := firstIn(10 downto 0) - secondIn(10 downto 0);
                    returnVal <= '0' & buff;
                else
                    --Negative
                    buff :=  secondIn(10 downto 0) - firstIN(10 downto 0);
                    returnVal <= '1' & buff;
                end if;
            else
            --Positive
                buff := firstIn(10 downto 0) + secondIn(10 downto 0);
                returnVal <= '0' & buff;
            end if;
            if (buff < firstIn and buff < secondIn) then
                overflow <= '1';
            end if;
                
        elsif(opp = "001") then -- Sub
            --Same as addition but inver the sign of the second value
            --Invert 2nd number
            if (secondIn(11) = '1') then
                buff2 := '0' & secondIn(10 downto 0);
            else
                buff2 := '1' & secondIn(10 downto 0);
            end if;
            --Addition
            buff := "00000000000";
            if (firstIN(11) = '1' and buff2(11) = '1') then
                buff := firstIN(10 downto 0) + buff2(10 downto 0);
                returnVal <= '1' & buff;
                
            elsif (firstIn(11) = '1') then
                if (firstIn(10 downto 0) > buff2(10 downto 0)) then
                    --negative result
                    buff := firstIn(10 downto 0) - buff2(10 downto 0);
                    returnVal <= '1' & buff;
                else
                    --Positive
                    buff := buff2(10 downto 0) - firstIn(10 downto 0);
                    returnVal <= '0' & buff;
                end if;
            elsif (buff2(11) = '1') then
                if (firstIn(10 downto 0) > buff2(10 downto 0)) then
                    --Positive
                    buff := firstIn(10 downto 0) - buff2(10 downto 0);
                    returnVal <= '0' & buff;
                else
                    --Negative
                    buff :=  buff2(10 downto 0) - firstIN(10 downto 0);
                    returnVal <= '1' & buff;
                end if;
            else
            --Positive
                buff := firstIn(10 downto 0) + buff2(10 downto 0);
                returnVal <= '0' & buff;
            end if;
            if (buff < firstIn and buff < secondIn) then
                overflow <= '1';
            end if;
        elsif(opp = "010") then -- Mult
            buff3 := firstIn(10 downto 0) * secondIn(10 downto 0);
            if(buff3 > 2047) then -- overflow
                overflow <= '1';
            end if;
            buff := buff3(10 downto 0);
            --Sets result to either a Negative or positive
            -- checks if both are negitive or positive.
            if ((firstIn(11) = '1' and secondIn(11) = '1') or (firstIn(11) = '0' and secondIn(11) = '0')) then
                returnVal <= '0' & buff; -- if they are then the answer will be positive so shifts the answer by 0
                
            else
                returnVal <= '1' & buff; -- else sets first bit to a 1.
                
            end if;
            
        elsif(opp = "011") then -- Div
            buff := STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(firstIn(10 downto 0))) / to_integer(unsigned(secondIn(10 downto 0))), 11));
            --Sets result to either a Negative or positive
            if ((firstIn(11) = '1' and secondIn(11) = '1') or (firstIn(11) = '0' and secondIn(11) = '0')) then
                returnVal <= '0' & buff;
                
            else
                returnVal <= '1' & buff;
                
            end if;
            if (secondIn(10 downto 0) = "00000000000") then
                overflow <= '1';
            end if;
        
        elsif(opp = "100") then -- Rem
            buff := STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(firstIn(10 downto 0))) rem to_integer(unsigned(secondIn(10 downto 0))), 11));
            --Sets result to either a Negative or positive
            if ((firstIn(11) = '1' and secondIn(11) = '1') or (firstIn(11) = '0' and secondIn(11) = '0')) then
                returnVal <= '0' & buff;
                
            else
                returnVal <= '1' & buff;
                
            end if;
            if (secondIn(10 downto 0) = "00000000000") then
                overflow <= '1';
            end if;
            
        else 
            -- Fuked upp somehow
            
        end if;
   end process;

end Behavioral;
