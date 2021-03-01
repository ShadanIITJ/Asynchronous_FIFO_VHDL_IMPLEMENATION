----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:41 02/27/2021 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memory is
	port(
		-- from write FSM
		-- reset : in std_logic :='0';
		clk_write:in std_logic;
		w_en:in std_logic :='0';
		full:in std_logic :='0';
		w_addr:in std_logic_vector(9 downto 0) :=(others=>'0');
		w_data:in std_logic_vector(7 downto 0) := (others=>'0'); -- 8 bit data as per instruction set.
		
		-- from read FSM
		clk_read:in std_logic;
		r_en:in std_logic;
		empty:in std_logic;
		r_addr:in std_logic_vector(9 downto 0) :=(others=>'0');
		r_data:out std_logic_vector(7 downto 0)  -- 8 bit data as per instruction set.
	);
end Memory;

architecture mem_arc of Memory is
	type ram_type is array(0 to 1023) of std_logic_vector(7 downto 0); -- created a RAM type.
	signal mem:ram_type := (others => (others=>'0')); -- initilaised with zero.

begin
	write_process: process(clk_write)
						begin
							if(rising_edge(clk_write)) then 
								if(w_en='1' and full='0') then
									mem(to_integer(unsigned(w_addr))) <= w_data;
								end if;
							end if;
						end process write_process;

	read_process: process(clk_read)
					  begin
							if(rising_edge(clk_read)) then 
								if(r_en='1' and empty='0') then
									r_data <= mem(to_integer(unsigned(r_addr)));
								end if;
							end if;
					  end process read_process;
end mem_arc;

