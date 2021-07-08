----------------------------------------------------------------------------------
-- Company:  UC, ECE
-- Lecturer: Steve Weddell
-- 
-- Create Date:    23:24:33 02/07/2011 
-- Revised Date:   22:01:20 04/03/2019
-- Design Name: 
-- Module Name:    my_divider - Behavioral 
-- Project Name: 	For ENEL373 course on digital logic
-- Target Devices: Any
-- Tool versions:  Any
-- Description:   This clock divider will take a 100MHz clock and divide it down to 1Hz
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplexer is
    Port ( clk_in : in  std_logic;
           dataIn1 : in std_logic_vector (4 downto 0);
           dataIn2 : in std_logic_vector (4 downto 0);
           dataIn3 : in std_logic_vector (4 downto 0);
           dataIn4 : in std_logic_vector (4 downto 0);
           dataIn5 : in std_logic_vector (4 downto 0);
           dataIn6 : in std_logic_vector (4 downto 0);
           dataIn7 : in std_logic_vector (4 downto 0);
           dataIn8 : in std_logic_vector (4 downto 0);
           dataOut : out std_logic_vector (4 downto 0);
           anodes  : out std_logic_vector (7 downto 0));
			  
-- attributes - these are not needed, as they are provided in the constraints file	
end multiplexer;

architecture Behavioral of multiplexer is

    signal clk_ctr : std_logic_vector(2 downto 0);

	
begin

    select_line: process (clk_in)

		begin
		if Clk_in = '1' and Clk_in'Event then
		  if clk_ctr = "111" then
			 clk_ctr <= "000";					--  reset counter
		  else											-- else
		  	 clk_ctr <= clk_ctr + "001";	--  counter = counter + 1
		  end if;
		end if;

	end process select_line;
	


	multiplexer: process (clk_ctr)		-- Enter this process whenever BCD input changes state
		begin
            case clk_ctr is
                when "000"	=> dataOut <= dataIn1;
                               anodes <= "11111110";
                when "001"	=> dataOut <= dataIn2;
                               anodes <= "11111101";
                when "010"  => dataOut <= dataIn3;
                               anodes <= "11111011";
                when "011"  => dataOut <= dataIn4;
                               anodes <= "11110111";
                when "100"  => dataOut <= dataIn5;
                               anodes <= "11101111";
                when "101"  => dataOut <= dataIn6;
                               anodes <= "11011111";
                when "110"  => dataOut <= dataIn7;
                               anodes <= "10111111";
                when others => dataOut <= dataIn8;
                               anodes <= "01111111";
             end case;	

	end process multiplexer;

end Behavioral;

