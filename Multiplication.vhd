----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 12:13:03
-- Design Name: 
-- Module Name: Multiplication - Behavioral
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

entity Multiplication is
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0);
           firstNegitiveFlag : in  STD_LOGIC;
           secondIn : in STD_LOGIC_VECTOR (11 downto 0);
           secondNegitiveFlag : in  STD_LOGIC;
           returnVal : out STD_LOGIC_VECTOR (19 downto 0);
           returnNegitiveFlag : out STD_LOGIC);
end Multiplication;

architecture Behavioral of Multiplication is

begin


end Behavioral;
