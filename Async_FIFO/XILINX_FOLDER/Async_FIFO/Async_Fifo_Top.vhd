----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:31:16 02/28/2021 
-- Design Name: 
-- Module Name:    Async_Fifo_Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Async_Fifo_Top is
	port(
		reset : in std_logic;
		-- write block
		clk_write:in std_logic;
		w_en : in std_logic := '0';
		w_data: in std_logic_vector(7 downto 0);
		full : out std_logic :='0';
		-- read block
		clk_read : in std_logic;
		r_en    : in std_logic := '0';
		r_data   : out std_logic_vector(7 downto 0);
		empty    : out std_logic
	);

end Async_Fifo_Top;

architecture main_behav of Async_Fifo_Top is
	COMPONENT read_control
	PORT(
		reset: in std_logic := '0';
		r_en: in std_logic := '0';
		clk_read: in std_logic;
		write_pointer: in std_logic_vector(9 downto 0) := (others=>'0');
		-- output from the control;
		empty: out std_logic :='1';
		read_pointer: out std_logic_vector(9 downto 0) := (others =>'0');
		read_gray_pointer: out std_logic_vector(9 downto 0) := (others =>'0')
	);
	END COMPONENT;
	
	COMPONENT write_control
	PORT(
		reset: in std_logic := '0';
		w_en: in std_logic := '0';
		clk_write: in std_logic;
		read_pointer: in std_logic_vector(9 downto 0) := (others=>'0');
		-- output to the control;
		full: out std_logic :='0';
		write_pointer: out std_logic_vector(9 downto 0) := (others =>'0');
		write_gray_pointer: out std_logic_vector(9 downto 0) := (others =>'0')
	);
	END COMPONENT;
	
	COMPONENT Memory
		port(
		-- from write control
		clk_write:in std_logic;
		w_en:in std_logic :='0';
		full:in std_logic :='0';
		w_addr:in std_logic_vector(9 downto 0) :=(others=>'0');
		w_data:in std_logic_vector(7 downto 0) := (others=>'0'); -- 8 bit data as per instruction set.
		
		-- from read control
		clk_read:in std_logic;
		r_en:in std_logic;
		empty:in std_logic;
		r_addr:in std_logic_vector(9 downto 0) :=(others=>'0');
		r_data:out std_logic_vector(7 downto 0)  -- 8 bit data as per instruction set.
	);
	END COMPONENT;
	-- for write block
	signal write_bin: std_logic_vector(9 downto 0);
	signal write_gray: std_logic_vector(9 downto 0);
	signal full_signal: std_logic;
	
	-- for read block
	signal read_bin: std_logic_vector(9 downto 0);
	signal read_gray: std_logic_vector(9 downto 0);
	signal empty_signal: std_logic;
	
	
	
	
begin
	memory_added:Memory
	PORT MAP(
		clk_write => clk_write,
		w_en      => w_en,
		full      => full_signal,
		w_addr    => write_bin,
		w_data    => w_data,
		clk_read  => clk_read,
		r_en      => r_en,
		empty     => empty_signal,
		r_addr    => read_bin,
		r_data    => r_data
	);
	
	write_control_added: write_control
	PORT MAP(
		reset        => reset,
		w_en         => w_en,
		clk_write    => clk_write,
		read_pointer => read_gray,
		full         => full_signal,
		write_pointer => write_bin,
		write_gray_pointer => write_gray
	
	);
	
	read_control_added: read_control
	PORT MAP(
		reset        			=> reset,
		r_en         			=> r_en,
		clk_read    			=> clk_read,
		write_pointer 			=> write_gray,
		empty         			=> empty_signal,
		read_pointer 			=> read_bin,
		read_gray_pointer 	=> read_gray
	
	);
	
	full  <= full_signal;
	empty <= empty_signal; 
	

end main_behav;

