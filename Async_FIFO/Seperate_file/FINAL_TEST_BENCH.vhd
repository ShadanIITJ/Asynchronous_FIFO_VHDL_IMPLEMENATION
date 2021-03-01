--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:21:26 02/28/2021
-- Design Name:   
-- Module Name:   /home/ise/Desktop/CODE/Async_FIFO/FINAL_TEST_BENCH.vhd
-- Project Name:  Async_FIFO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Async_Fifo_Top
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
 
ENTITY FINAL_TEST_BENCH IS
END FINAL_TEST_BENCH;
 
ARCHITECTURE behavior OF FINAL_TEST_BENCH IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Async_Fifo_Top
    PORT(
         reset : IN  std_logic;
         clk_write : IN  std_logic;
         w_en : IN  std_logic;
         w_data : IN  std_logic_vector(7 downto 0);
         full : OUT  std_logic;
         clk_read : IN  std_logic;
         r_en : IN  std_logic;
         r_data : OUT  std_logic_vector(7 downto 0);
         empty : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk_write : std_logic := '0';
   signal w_en : std_logic := '0';
   signal w_data : std_logic_vector(7 downto 0) := (others => '0');
   signal clk_read : std_logic := '0';
   signal r_en : std_logic := '0';

 	--Outputs
   signal full : std_logic;
   signal r_data : std_logic_vector(7 downto 0);
   signal empty : std_logic;

   -- Clock period definitions
   constant clk_write_period : time := 10 ns;
   constant clk_read_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Async_Fifo_Top PORT MAP (
          reset => reset,
          clk_write => clk_write,
          w_en => w_en,
          w_data => w_data,
          full => full,
          clk_read => clk_read,
          r_en => r_en,
          r_data => r_data,
          empty => empty
        );

   -- Clock process definitions
   clk_write_process :process
   begin
		clk_write <= '0';
		wait for clk_write_period/2;
		clk_write <= '1';
		wait for clk_write_period/2;
   end process;
 
   clk_read_process :process
   begin
		clk_read <= '0';
		wait for clk_read_period/2;
		clk_read <= '1';
		wait for clk_read_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <='1';
      wait for 100 ns;
		reset <='0';
		wait for clk_write_period*10;
		w_en <='1';
		w_data <= "11111111";
		wait for clk_write_period;
		w_data <= "11001111";
		wait for clk_write_period;
		w_data <= "10000001";
		wait for clk_write_period;
		w_en <='0';
		r_en <='1';
		wait for clk_read_period*4;
		r_en <='0';
		



      -- insert stimulus here 

      wait;
   end process;

END;
