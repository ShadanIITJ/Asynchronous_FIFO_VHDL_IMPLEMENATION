----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:45 02/27/2021 
-- Design Name: 
-- Module Name:    gray_to_binary - Behavioral 
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

entity gray_to_binary is
	GENERIC(
		width:integer :=4
	);
	PORT(
		input : in std_logic_vector(width -1 downto 0);
		output : out std_logic_vector(width -1 downto 0)
	);
end gray_to_binary;

architecture arc1 of gray_to_binary is
	signal temp : std_logic_vector(width-1 downto 0) := (others => '0');
begin
		temp(width-1)<=input(width-1);
		gen1:for i in width - 2 downto 0 generate
			temp(i) <= temp(i+1) xor input(i);
		end generate gen1;
		output<= temp;

end arc1;

