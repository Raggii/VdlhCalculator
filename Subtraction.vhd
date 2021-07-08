----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 12:13:03
-- Design Name: 
-- Module Name: Subtraction - Behavioral
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

entity Subtraction is
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0);
           firstNegitiveFlag : in  STD_LOGIC;
           secondIn : in STD_LOGIC_VECTOR (11 downto 0);
           secondNegitiveFlag : in  STD_LOGIC;
           returnVal : out STD_LOGIC_VECTOR (12 downto 0);
           returnNegitiveFlag : out STD_LOGIC);
end Subtraction;

architecture Behavioral of Subtraction is

signal firstHolder, secondHolder : STD_LOGIC_VECTOR (11 downto 0);

begin

    process(firstIn, firstNegitiveFlag, secondIn, secondNegitiveFlag)
        begin
        
        firstHolder <= firstIn;
        secondHolder <= secondIn;
    
        if(firstNegitiveFlag = '1') then
            -- take 2s complement
            -- assign to firstholder
        end if;
        if(firstNegitiveFlag = '1') then
            -- take 2s complement
            -- assign to secondholder
        end if;
       returnVal <= firstHolder + secondHolder;
       returnNegitiveFlag <= '0'; -- fix this
       -- figure out how to find if returnVal is negitive and return if it is!!!
       -- check which is bigger and do the stuff
   end process;


end Behavioral;
