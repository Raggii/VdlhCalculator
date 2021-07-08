----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 12:13:03
-- Design Name: 
-- Module Name: Division - Behavioral
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

entity Division is
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0);
           firstNegitiveFlag : in  STD_LOGIC;
           secondIn : in STD_LOGIC_VECTOR (11 downto 0);
           secondNegitiveFlag : in  STD_LOGIC;
           returnVal : out STD_LOGIC_VECTOR (19 downto 0);
           returnNegitiveFlag : out STD_LOGIC);
end Division;

architecture Behavioral of Division is

begin


end Behavioral;
