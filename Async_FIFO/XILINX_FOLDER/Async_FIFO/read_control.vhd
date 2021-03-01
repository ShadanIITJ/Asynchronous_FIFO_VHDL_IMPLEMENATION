----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:07 02/28/2021 
-- Design Name: 
-- Module Name:    read_control - Behavioral 
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

entity read_control is

	PORT(
		reset: in std_logic := '0';
		r_en: in std_logic := '0';
		clk_read: in std_logic;
		write_pointer: in std_logic_vector(9 downto 0) := (others=>'0');
		-- input to the control;
		empty: out std_logic :='1';
		read_pointer: out std_logic_vector(9 downto 0) := (others =>'0');
		read_gray_pointer: out std_logic_vector(9 downto 0) := (others =>'0')
	);
end read_control;

architecture arc1 of read_control is
	COMPONENT synchronizer
	generic(width:integer);
	port(
		clk,en,reset:in std_logic;
		input: in std_logic_vector(width-1 downto 0);
		output: out std_logic_vector(width-1 downto 0)
	);
	END COMPONENT;
	
	COMPONENT flip_flop
	GENERIC(width:integer);
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         en : IN  std_logic;
         input : IN  std_logic_vector(width-1 downto 0);
         output : OUT  std_logic_vector(width-1 downto 0)
        );
    END COMPONENT;
	 

	 
	 -- GRAY TO BINARY
	 COMPONENT gray_to_binary
	 GENERIC(width:integer);
	 PORT(
		input : in std_logic_vector(width -1 downto 0);
		output : out std_logic_vector(width -1 downto 0)
	 );
	 END COMPONENT;
	
	 -- BINARY TO GRAY
	 COMPONENT binary_to_gray
	 GENERIC(width:integer);
	 PORT(
		input : in std_logic_vector(width -1 downto 0);
		output : out std_logic_vector(width -1 downto 0)
	 );
	 END COMPONENT;
	
	signal old_read_binary: std_logic_vector(9 downto 0):=(others=>'0');
	signal write_after_sync: std_logic_vector(9 downto 0);
	signal write_binary: std_logic_vector(9 downto 0);
	signal read_binary : std_logic_vector(9 downto 0) :=(others=>'0');
	signal read_gray: std_logic_vector(9 downto 0) :=(others=>'0');
	signal empty_signal: std_logic := '1';
	constant size: integer := 10;

begin
	old_read:flip_flop
		GENERIC MAP(width => size)
		PORT MAP(
			clk     => clk_read,
			reset   => reset,
			en      => '1',
			input   => read_binary,
			output  => old_read_binary
		);
		
	bin_to_grap:binary_to_gray
		GENERIC MAP(width => size)
		PORT MAP(
			input => read_binary,
			output => read_gray
		);
	syncroniser_on_read: synchronizer
		GENERIC MAP(width => size)
		PORT MAP(
			clk    => clk_read,
			reset  => reset,
			en     => '1',
			input  => write_pointer,
			output => write_after_sync
		);
		
	gray_to_bin:gray_to_binary
		GENERIC MAP(width => size)
		PORT MAP(
			input => write_after_sync,
			output => write_binary
		);
		
		
		PROCESS(reset,clk_read,r_en)
		BEGIN
			if(reset ='1') then 
				read_binary <= "0000000000";
				--write_gray   <= "0000000000";
				empty_signal  <= '0';
			elsif(rising_edge(clk_read) and r_en='1') then
				if(((std_logic_vector(to_unsigned(to_integer(unsigned(old_read_binary)) + 1, 10)) = write_binary) or empty_signal = '1') and (write_binary = read_binary)) then 
					empty_signal <= '1';
				else
					read_binary <= std_logic_vector(to_unsigned(to_integer(unsigned(read_binary)) + 1, 10));
					empty_signal <='0';
				end if;
			end if;
		
		END PROCESS;
		
		read_gray_pointer <= read_gray;
		read_pointer      <= read_binary;
		empty             <= empty_signal;
		
		
		

end arc1;

