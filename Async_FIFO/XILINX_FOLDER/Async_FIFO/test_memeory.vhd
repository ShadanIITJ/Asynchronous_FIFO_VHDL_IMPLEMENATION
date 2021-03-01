--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:54:27 02/27/2021
-- Design Name:   
-- Module Name:   /home/ise/Desktop/CODE/Async_FIFO/test_memeory.vhd
-- Project Name:  Async_FIFO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Memory
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
 
ENTITY test_memeory IS
END test_memeory;
 
ARCHITECTURE behavior OF test_memeory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Memory
    PORT(
         clk_write : IN  std_logic;
         w_en : IN  std_logic;
         full : IN  std_logic;
         w_addr : IN  std_logic_vector(9 downto 0);
         w_data : IN  std_logic_vector(7 downto 0);
         clk_read : IN  std_logic;
         r_en : IN  std_logic;
         empty : IN  std_logic;
         r_addr : IN  std_logic_vector(9 downto 0);
         r_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_write : std_logic := '0';
   signal w_en : std_logic := '0';
   signal full : std_logic := '0';
   signal w_addr : std_logic_vector(9 downto 0) := (others => '0');
   signal w_data : std_logic_vector(7 downto 0) := (others => '0');
   signal clk_read : std_logic := '0';
   signal r_en : std_logic := '0';
   signal empty : std_logic := '0';
   signal r_addr : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal r_data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_write_period : time := 10 ns;
   constant clk_read_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Memory PORT MAP (
          clk_write => clk_write,
          w_en => w_en,
          full => full,
          w_addr => w_addr,
          w_data => w_data,
          clk_read => clk_read,
          r_en => r_en,
          empty => empty,
          r_addr => r_addr,
          r_data => r_data
        );

   -- Clock process definitions
   clk_write_process :process
   begin
		clk_write <= '1';
		wait for clk_write_period/2;
		clk_write <= '0';
		wait for clk_write_period/2;
   end process;
 
   clk_read_process :process
   begin
		clk_read <= '1';
		wait for clk_read_period/2;
		clk_read <= '0';
		wait for clk_read_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

      wait for clk_write_period*10;
		
			-- start writing something here.
			w_en <= '1';
			w_data <= "11111111";
			w_addr <= "0000000000";
		wait for clk_write_period;
			w_en <= '1';
			w_data <= "11110000";
			w_addr <= "0000000001";
		wait for clk_write_period;
			w_en <= '1';
			w_data <= "11100111";
			w_addr <= "0000000010";
		wait for clk_write_period;
			w_en <= '0'; -- STOP WRITING;
			r_en <='1'; -- START WRITING;
			r_addr <= "0000000000";
		wait for clk_read_period;
			r_addr <= "0000000001";
		wait for clk_read_period;
			r_addr <= "0000000010";
		wait for clk_read_period;
			r_en <= '0'; -- STOP READING;

      -- insert stimulus here 

      wait;
   end process;

END;
