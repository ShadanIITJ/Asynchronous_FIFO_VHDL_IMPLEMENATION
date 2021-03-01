--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:16:26 02/27/2021
-- Design Name:   
-- Module Name:   /home/ise/Desktop/CODE/Async_FIFO/test_syncronizer.vhd
-- Project Name:  Async_FIFO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: synchronizer
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
 
ENTITY test_syncronizer IS
END test_syncronizer;
 
ARCHITECTURE behavior OF test_syncronizer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT synchronizer
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         reset : IN  std_logic;
         input : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '1';
   signal reset : std_logic := '0';
   signal input : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: synchronizer PORT MAP (
          clk => clk,
          en => en,
          reset => reset,
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset<='1';
      wait for 100 ns;
		reset <='0';

      wait for clk_period*10;
		input <="1111";
		wait for clk_period;
		input <= "1110";
		wait for clk_period;
		input<="1100";
		wait for clk_period;
		input <= "1000";
		wait for clk_period;
		input <= "0001";
		wait for clk_period;
		input <= "0101";
		wait for clk_period;
		input <= "1100";

      -- insert stimulus here 

      wait;
   end process;

END;
