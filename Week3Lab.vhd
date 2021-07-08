----------------------------------------------------------------------------------
-- Company: UC
-- Engineer: Jackson Allred 36715295 TRISTIONSSS 12345678
-- 
-- Create Date: 11.03.2021 12:59:55
-- Design Name: Expensive calculator.
-- Module Name: Week3Lab - Behavioral
-- Project Name: 373 project

-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--------------------------------------------------___373 Project Main File___--------------------------------------------------

entity Week3Lab is
    Port ( CLK100MHZ : in std_logic ; -- Input clock of the system
           SW : in std_logic_vector (11 downto 0); -- the 11 input switches
           SEG : out std_logic_vector (1 to 7); -- the 7 segment displaus
           AN : out std_logic_vector (7 downto 0); -- the different lights for the 7 segs
           BTN : in std_logic_vector(2 downto 0); -- the input buttons
           LED : out std_logic_vector(15 downto 0));
end Week3Lab;



--------------------------------------------------___Componenets___--------------------------------------------------

architecture strut of Week3Lab is

Component my_divider -- the clock divider to slow down the clock
    Port ( Clk_in : in  STD_LOGIC; -- Input clock
           clk_limit : in std_logic_vector (27 downto 0); -- Max clock tick
           Clk_out : out  STD_LOGIC); -- The output clock
End Component;

Component bin2bcd_12bit -- Converts binary numbers to a bcd display 
    Port ( binIN : in  STD_LOGIC_VECTOR (10 downto 0); -- the binary number in to be converted
           ones : out  STD_LOGIC_VECTOR (4 downto 0); -- return of the ones in 7 segs
           tens : out  STD_LOGIC_VECTOR (4 downto 0); -- return of the tens in 7 segs
           hundreds : out  STD_LOGIC_VECTOR (4 downto 0); -- return of the hundreds in 7 segs
           thousands : out  STD_LOGIC_VECTOR (4 downto 0) -- return of the thousands in 7 segs
          );
  End Component;

Component BCD_to_7SEG is -- displays the numbers onto the 7 segs
    Port ( bcd_in: in std_logic_vector (4 downto 0); -- the converted binary number input
           leds_out: out	std_logic_vector (1 to 7)); -- the values to turn on the 7 segs
end Component;

Component multiplexer is -- to multiplex between the different 7 segment displays 
    Port ( clk_in : in  std_logic; -- clock in
           dataIn1 : in std_logic_vector (4 downto 0); -- first data
           dataIn2 : in std_logic_vector (4 downto 0); -- second data
           dataIn3 : in std_logic_vector (4 downto 0); -- third data
           dataIn4 : in std_logic_vector (4 downto 0); -- forth data
           dataIn5 : in std_logic_vector (4 downto 0); -- fifth data
           dataIn6 : in std_logic_vector (4 downto 0); -- sixth data
           dataIn7 : in std_logic_vector (4 downto 0); -- seventh data
           dataIn8 : in std_logic_vector (4 downto 0); -- eighth data
           dataOut : out std_logic_vector (4 downto 0); -- the output data
           anodes  : out std_logic_vector (7 downto 0)); -- anodes for output
end Component;

Component NegDetect is -- File to check position of the off 7 segments as well as where to put the negivitve value
    Port ( negativeSelect : in STD_LOGIC; -- the negitive value for the inputs 
           negRes : in std_logic; -- the negitive value for the return result
           LED : out STD_LoGiC_VEcTor(15 downto 0); -- the LEDS to turn on for overflow
           seg1 : in STD_LoGiC_VEcTor(4 downto 0); -- first input value
           seg2 : in STD_Logic_vector(4 downto 0); -- second input value
           seg3 : in STD_Logic_vector(4 downto 0); -- third input value
           seg4 : in STD_Logic_vector(4 downto 0); -- forth input value
           seg5 : in STD_Logic_vector(4 downto 0); -- fifth input value
           seg6 : in STD_Logic_vector(4 downto 0); -- sixth input value
           seg7 : in STD_Logic_vector(4 downto 0); -- seventh input value
           seg8 : in STD_LoGic_vector(4 downto 0); -- eighth input value
           
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
end Component;

Component modeSwitch is -- the modual to change the given mode of operation
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
end Component;
    
Component Dbncr is   -- a debouncer modual
    Port (clk_i : in std_logic; -- the input clock
          sig_i : in std_logic; -- the input signal to be debounced
          pls_o : out std_logic); -- the output debounced signal
end Component;

component Operations is -- the modual that handles all the compuation
    Port ( firstIn : in STD_LOGIC_VECTOR (11 downto 0); -- first number in
           secondIn : in STD_LOGIC_VECTOR (11 downto 0); -- second number in
           opp : in  STD_LOGIC_VECTOR (2 downto 0); -- the operation to be done on the 2 numbers
           mode : in std_logic_vector (1 downto 0); -- to know when the operation is to be done the system has to be in operations mode 
           returnVal : out STD_LOGIC_VECTOR (11 downto 0); -- the value returned after the operation
           overflow : out std_logic); -- comments are fun
end component;



--------------------------------------------------___Signals___--------------------------------------------------

signal clk_devided_200hz: std_logic; -- signal to hold the input clock values
signal negitveFlag: std_logic; -- signal for negitives
signal first_digit, second_digit, third_digit, fourth_digit, fifth_digit, 
sixth_digit, seventh_digit, eighth_digit, display_digit : std_logic_vector (4 downto 0); -- signal to hold the input numbers

signal first_digit_out, second_digit_out, third_digit_out, fourth_digit_out, 
fifth_digit_out, sixth_digit_out, seventh_digit_out, eighth_digit_out: std_logic_vector (4 downto 0); -- signal for the output numbers changed by negative

signal res1,res2,res3,res4,res5,res6,res7,res8: std_logic_vector (4 downto 0); -- signal for the resulting numbers after operation
signal mode: STD_LOGIC_VECTOR(1 downto 0); -- signal to pass the current mode around moduals
signal operate : STD_LOGIC_VECTOR(2 downto 0); -- signal to know which operation to compute
signal returnNumber1, returnNumber2 : std_logic_vector (11 downto 0); -- the numbers put into the operations
signal debouncedButton, resetButton : std_logic; -- the button signal after its been debounced
signal finalResult : std_logic_vector(11 downto 0); -- the ouput result to be displayed 
signal overflow : std_logic;



--------------------------------------------------___Structural Architecture___--------------------------------------------------

begin
    BCD2BIN1: bin2bcd_12bit port map (SW(10 downto 0), first_digit, second_digit, third_digit, fourth_digit);
    CLK_dev2: my_divider port map (CLK100MHZ, X"0000848", clk_devided_200hz);
    Debouncer: Dbncr port map (CLK100MHZ, BTN(0), debouncedButton);
    DebouncerTwo: Dbncr port map (CLK100MHZ, BTN(1), resetButton);
    modeSelect: modeSwitch port map(CLK100MHZ, mode,debouncedButton, resetButton,SW(11 downto 0),
    returnNumber1, returnNumber2,operate);
    NegAtive: NegDetect port map (SW(11), finalresult(11), LED(15 downto 0), first_digit, second_digit, third_digit, fourth_digit,
    fifth_digit, sixth_digit, seventh_digit, eighth_digit,res1,res2,res3,res4,res5,res6,res7,res8, first_digit_out,
    second_digit_out, third_digit_out, fourth_digit_out, fifth_digit_out, sixth_digit_out, seventh_digit_out, 
    eighth_digit_out, mode, operate, overflow);
    multiplx: multiplexer port map (clk_devided_200hz, first_digit_out, second_digit_out, third_digit_out,
    fourth_digit_out, fifth_digit_out, sixth_digit_out, seventh_digit_out, eighth_digit_out, display_digit, AN);
    BCD7SEG1: BCD_to_7SEG port map (display_digit, SEG (1 to 7));
    operationss: operations port map (returnNumber1, returnNumber2, operate, mode, finalResult, overflow);
    BCD2BIN2: bin2bcd_12bit port map (finalResult(10 downto 0), res1, res2, res3, res4);
end strut;
