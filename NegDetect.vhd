----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 15:56:54
-- Design Name: 
-- Module Name: NegDetect - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NegDetect is -- File to check position of the off 7 segments as well as where to put the negivitve value
    Port ( negativeSelect : in STD_LOGIC; -- the negitive value for the inputs 
           negRes : in std_logic; -- the negitive value for the return result
           LED : out STD_LoGiC_VEcTor(15 downto 0);
           seg1 : in STD_LoGiC_VEcTor(4 downto 0); -- first input value
           seg2 : in STD_Logic_vector(4 downto 0); -- second input value
           seg3 : in STD_Logic_vector(4 downto 0); -- third input value
           seg4 : in STD_Logic_vector(4 downto 0); -- forth input value
           seg5 : in STD_Logic_vector(4 downto 0); -- fifth input value
           seg6 : in STD_Logic_vector(4 downto 0); -- sixth input value
           seg7 : in STD_Logic_vector(4 downto 0); -- seventh input value
           seg8 : in STD_Logic_vector(4 downto 0); -- eighth input value
           
           seg1res : in STD_LoGiC_VEcTor(4 downto 0); -- the first result value
           seg2res : in STD_Logic_vector(4 downto 0); -- the second result value
           seg3res : in STD_Logic_vector(4 downto 0); -- the third result value
           seg4res : in STD_Logic_vector(4 downto 0); -- the forth result value
           seg5res : in STD_Logic_vector(4 downto 0); -- the fifth result value
           seg6res : in STD_Logic_vector(4 downto 0); -- the sixth result value
           seg7res : in STD_Logic_vector(4 downto 0); -- the seventh result value
           seg8res : in STD_Logic_vector(4 downto 0); -- the eighth result value
           
           segment1 : out std_logic_vector(4 downto 0); -- the first return value thats been altered to check for negitive pos
           segment2 : out STD_Logic_vector(4 downto 0); -- the second return value
           segment3 : out STD_Logic_vector(4 downto 0); -- the third return value
           segment4 : out STD_Logic_vector(4 downto 0); -- the forth return value
           segment5 : out STD_Logic_vector(4 downto 0); -- the fifth return value
           segment6 : out STD_Logic_vector(4 downto 0); -- the sixth return value
           segment7 : out STD_Logic_vector(4 downto 0); -- the seventh return value
           segment8 : out STD_Logic_vector(4 downto 0); -- the eighth return value
           
           mode : in  STD_Logic_vector(1 downto 0); -- a 2 bit value to check which mode the ALU is in 
                                                    -- (00, 01 = first and second value. 10 = opp. 11 = result)
           operation : in  STD_Logic_vector(2 downto 0); -- the different operation to be displayed on the 7 segs
                                                          -- 000 = , 001 = , 010 = , 011 = , 100 = .
           overflow : in std_logic);
end NegDetect;

architecture Behavioral of NegDetect is


begin
process(negativeSelect)
variable over : std_logic := '0';
    begin
    over := overflow;
    if(mode /= "11") then -- restetet when starts
        over := '0';
        LED(15 downto 0) <= "0000000000000000";
    end if;
    if(mode /= "10") then -- when the mode is not in the opperation stage
        
        if (seg7 /= "00000") then -- check the front bit to see if its 0 so we know which displays to disable
            segment2 <= seg2;
            segment3 <= seg3;
            segment4 <= seg4;
            segment5 <= seg5;
            segment6 <= seg6;
            segment7 <= seg7;
            
            if(negativeSelect = '1') then -- It then checks the negitive value and places the negitive in front of the number
               segment8 <= "01110";
               
            else 
               segment8 <= "01111";
               
            end if;
            
             
        elsif (seg6 /= "00000") then -- Checking the 6th display
        
            segment2 <= seg2;
            segment3 <= seg3;
            segment4 <= seg4;
            segment5 <= seg5;
            segment6 <= seg6;
            
            if(negativeSelect = '1') then 
               segment7 <= "01110";
               
            else 
               segment7 <= "01111";
               
            end if;
            
            segment8 <= "01111"; -- if there is no negitive it turns all of the other 7 segs off
            
            
        elsif (seg5 /= "00000") then -- Checking the 5th display
        
            segment2 <= seg2;
            segment3 <= seg3;
            segment4 <= seg4;
            segment5 <= seg5;
            
            if(negativeSelect = '1') then 
               segment6 <= "01110";
               
            else 
               segment6 <= "01111";
               
            end if;
            
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif (seg4 /= "00000") then -- Checking the 4th display
        
            segment2 <= seg2;
            segment3 <= seg3;
            segment4 <= seg4;
            
            if(negativeSelect = '1') then 
               segment5 <= "01110";
               
            else 
               segment5 <= "01111";
               
            end if;
            
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif (seg3 /= "00000") then -- Checking the 3rd display
            segment2 <= seg2;
            segment3 <= seg3;
            
            if(negativeSelect = '1') then 
               segment4 <= "01110";
               
            else 
               segment4 <= "01111";
               
            end if;
            
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif (seg2 /= "00000") then -- Checking the 2th display
            segment2 <= seg2;
            
            if(negativeSelect = '1') then 
               segment3 <= "01110";
               
            else 
               segment3 <= "01111";
               
            end if;
            
            segment4 <= "01111";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif (seg1 /= "00000") then -- Checking the 1st display
        
            if(negativeSelect = '1') then 
               segment2 <= "01110";
               
            else 
               segment2 <= "01111";
               
            end if;
            
            segment3 <= "01111";
            segment4 <= "01111";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        else
            segment1 <= "01111";
            segment2 <= "01111";
            segment3 <= "01111";
            segment4 <= "01111";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        end if;
        
        
        segment1 <= seg1;
        
        -----------------------------------------___Results___-----------------------------------------
        if (mode = "11") then
            if (seg7res /= "00000") then -- same as before checks each of the 7 segments for the first one to be off
            
                segment2 <= seg2res; -- sets all of the values that are on
                segment3 <= seg3res;
                segment4 <= seg4res;
                segment5 <= seg5res;
                segment6 <= seg6res;
                segment7 <= seg7res;
                
                if(negRes = '1') then 
                   segment8 <= "01110"; -- if the number is negitive the sets the bit to negitive
                   
                else 
                   segment8 <= "01111"; -- or turns off the other segments that are not negitive
                   
                end if;
                 
                 
            elsif (seg6res /= "00000") then
                segment2 <= seg2res;
                segment3 <= seg3res;
                segment4 <= seg4res;
                segment5 <= seg5res;
                segment6 <= seg6res;
                
                if(negRes = '1') then 
                   segment7 <= "01110";
                   
                else 
                   segment7 <= "01111";
                   
                end if;
                
                segment8 <= "01111";
                
                
            elsif (seg5res /= "00000") then
            
                segment2 <= seg2res;
                segment3 <= seg3res;
                segment4 <= seg4res;
                segment5 <= seg5res;
                
                if(negRes = '1') then 
                   segment6 <= "01110";
                   
                else 
                   segment6 <= "01111";
                   
                end if;
                
                segment7 <= "01111";
                segment8 <= "01111";
                
                
            elsif (seg4res /= "00000") then
            
                segment2 <= seg2res;
                segment3 <= seg3res;
                segment4 <= seg4res;
                
                if(negRes = '1') then 
                   segment5 <= "01110";
                   
                else 
                   segment5 <= "01111";
                   
                end if;
                
                segment6 <= "01111";
                segment7 <= "01111";
                segment8 <= "01111";
                
                
            elsif (seg3res /= "00000") then
            
                segment2 <= seg2res;
                segment3 <= seg3res;
                
                if(negRes = '1') then 
                   segment4 <= "01110";
                   
                else 
                   segment4 <= "01111";
                   
                end if;
                
                segment5 <= "01111";
                segment6 <= "01111";
                segment7 <= "01111";
                segment8 <= "01111";
                
                
            elsif (seg2res /= "00000") then
            
                segment2 <= seg2res;
                
                if(negRes = '1') then 
                   segment3 <= "01110";
                   
                else 
                   segment3 <= "01111";
                   
                end if;
                
                segment4 <= "01111";
                segment5 <= "01111";
                segment6 <= "01111";
                segment7 <= "01111";
                segment8 <= "01111";
                
                
            elsif (seg1res /= "00000") then
            
                if(negRes = '1') then 
                   segment2 <= "01110";
                   
                else 
                   segment2 <= "01111";
                   
                end if;
                
                segment3 <= "01111";
                segment4 <= "01111";
                segment5 <= "01111";
                segment6 <= "01111";
                segment7 <= "01111";
                segment8 <= "01111";
                
                
            else
                segment1 <= "01111";
                segment2 <= "01111";
                segment3 <= "01111";
                segment4 <= "01111";
                segment5 <= "01111";
                segment6 <= "01111";
                segment7 <= "01111";
                segment8 <= "01111";
                
                
            end if;
            
            
            segment1 <= seg1res;
            
            
        end if;
        if (over = '1') then
            LED(15 downto 0) <= "1111111111111111";
        elsif (over = '0') then
            LED(15 downto 0) <= "0000000000000000";
        end if;
    else -- When the mode is 10 it will display th different operands
        if(seg1 = "00000") then -- Addition
            segment1 <= "10010";
            segment2 <= "10010";
            segment3 <= "10000";
            segment4 <= "01111";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif(seg1 = "00001") then -- subtraction
            segment1 <= "10001";
            segment2 <= "11010";
            segment3 <= "10111";
            segment4 <= "01111";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif(seg1 = "00010") then -- Product
            segment1 <= "10010";
            segment2 <= "11001";
            segment3 <= "11000";
            segment4 <= "10100";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif(seg1 = "00011") then -- Division
            segment1 <= "11010";
            segment2 <= "10011";
            segment3 <= "10010";
            segment4 <= "01111";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        elsif(seg1 = "00100") then -- Remainder
            segment1 <= "10110";
            segment2 <= "10101";
            segment3 <= "11011";
            segment4 <= "10101";
            segment5 <= "01111";
            segment6 <= "01111";
            segment7 <= "01111";
            segment8 <= "01111";
            
            
        end if;
        
    end if;
            
 end process;


end Behavioral;
