--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:16:00 02/27/2021
-- Design Name:   
-- Module Name:   /home/ise/Desktop/CODE/Async_FIFO/test_gray_to_bin.vhd
-- Project Name:  Async_FIFO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: gray_to_binary
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_bin_to_gray IS
END test_bin_to_gray;
 
ARCHITECTURE behavior OF test_bin_to_gray IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT binary_to_gray
    PORT(
         input : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant cp : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: binary_to_gray PORT MAP (
          input => input,
          output => output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		

      wait for cp*10;
		input<="0000";
		wait for  cp;
		input<="0001";
		wait for  cp;
		input<="0010";
		wait for  cp;
		input<="0011";
		wait for  cp;
		input<="0100";
		wait for  cp;
		input<="0101";
		wait for  cp;
		
		input<="0110";
		wait for  cp;
		input<="0111";
		wait for cp;
		input<="1000";
		wait for cp;
		input<="1001";
      -- insert stimulus here 

      wait;
   end process;

END;
