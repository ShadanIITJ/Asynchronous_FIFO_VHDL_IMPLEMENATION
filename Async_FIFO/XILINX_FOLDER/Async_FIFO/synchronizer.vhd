----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:44:38 02/27/2021 
-- Design Name: 
-- Module Name:    synchronizer - Behavioral 
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

entity synchronizer is
	generic(
		width:integer := 4
	);
	port(
		clk,en,reset:in std_logic;
		input: in std_logic_vector(width-1 downto 0);
		output: out std_logic_vector(width-1 downto 0)
	);
end synchronizer;

architecture twoFfSync of synchronizer is
    COMPONENT flip_flop
	 GENERIC(width:integer);
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         en : IN  std_logic;
         input : IN  std_logic_vector(width-1 downto 0);
         output : OUT  std_logic_vector(width -1 downto 0)
        );
    END COMPONENT;

	 --Inputs
	signal input_f2: std_logic_vector(width-1 downto 0);

 	--Outputs
   signal output_f2 : std_logic_vector(3 downto 0);


begin

	-- instantiate first ff
	f1:flip_flop 
		GENERIC MAP(
			width=> width
		)
		PORT MAP(
		clk=> clk,
		reset=> reset,
		en=> en,
		input=>input,
		output=>input_f2
	);
	f2:flip_flop 
		GENERIC MAP(
			width=> width
		)
		PORT MAP(
			clk=> clk,
			reset=> reset,
			en=> en,
			input=>input_f2,
			output=>output
		);
	


end twoFfSync;

