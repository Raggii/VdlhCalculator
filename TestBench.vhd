----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2021 17:01:33
-- Design Name: 
-- Module Name: TestBench - Behavioral
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

entity TestBench is
--  Port ( );
end TestBench;

architecture Behavioral of TestBench is

    component Operations is -- the modual that handles all the compuation
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0); -- first number in
           secondIn : in STD_LOGIC_VECTOR (11 downto 0); -- second number in
           opp : in  STD_LOGIC_VECTOR (2 downto 0); -- the operation to be done on the 2 numbers
           mode : in std_logic_vector (1 downto 0); -- to know when the operation is to be done the system has to be in operations mode 
           returnVal : out STD_LOGIC_VECTOR (11 downto 0)); -- the value returned after the operation
    end component;

    signal firstSig, secondSig, returnSig : STD_LoGiC_VectoR(11 downto 0);
    signal oppSig : std_logic_vector (2 downto 0);
    signal  modeSig : STD_LOGIC_VECTOR (1 downto 0);
    
begin 

    UUT : Operations port map (firstSig, secondSig, oppSig, modeSig, returnSig);
    
    
Io_process : process   
    begin
        wait for 100ns;
        firstSig <= "000000000001";
        secondSig <= "000000000001";
        oppSig <= "000";
        modeSig <=  "10";
        wait for 40ns;
        
--        firstSig <= "000000000101";
--        secondSig <= "100000000001";
--        oppSig <= "001";
--        modeSig <=  "10";
--        wait for 40ns;
        
--        firstSig <= "000001000001";
--        secondSig <= "100000000011";
--        oppSig <= "010";
--        modeSig <=  "10";
--        wait for 40ns;
        
--        firstSig <= "000000000101";
--        secondSig <= "010000000001";
--        oppSig <= "011";
--        modeSig <=  "10";
--        wait for 40ns;
        
--        firstSig <= "000000000000";
--        secondSig <= "000000000001";
--        oppSig <= "100";
--        modeSig <=  "10";
--        wait for 40ns;
        
    
    end process Io_process;
    
end Behavioral;
