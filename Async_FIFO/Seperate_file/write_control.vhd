----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:40:29 02/28/2021 
-- Design Name: 
-- Module Name:    write_control - Behavioral 
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

entity write_control is
	PORT(
		reset: in std_logic := '0';
		w_en: in std_logic := '0';
		clk_write: in std_logic;
		read_pointer: in std_logic_vector(9 downto 0) := (others=>'0');
		-- input to the control;
		full: out std_logic :='0';
		write_pointer: out std_logic_vector(9 downto 0) := (others =>'0');
		write_gray_pointer: out std_logic_vector(9 downto 0) := (others =>'0')
	);
end write_control;

architecture arc1 of write_control is
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

	signal old_write_binary: std_logic_vector(9 downto 0):=(others=>'0');
	signal read_after_sync: std_logic_vector(9 downto 0);
	signal read_binary: std_logic_vector(9 downto 0);
	signal write_binary : std_logic_vector(9 downto 0) :=(others=>'0');
	signal write_gray: std_logic_vector(9 downto 0) :=(others=>'0');
	signal full_signal: std_logic := '0';
	constant size: integer := 10;
	
	
	

begin

	old_write:flip_flop
		GENERIC MAP(width => size)
		PORT MAP(
			clk     => clk_write,
			reset   => reset,
			en      => '1',
			input   => write_binary,
			output  => old_write_binary
		);
		
	bin_to_grap:binary_to_gray
		GENERIC MAP(width => size)
		PORT MAP(
			input => write_binary,
			output => write_gray
		);
	
	syncroniser_on_read: synchronizer
		GENERIC MAP(width => size)
		PORT MAP(
			clk    => clk_write,
			reset  => reset,
			en     => '1',
			input  => read_pointer,
			output => read_after_sync
		);
	
	gray_to_bin:gray_to_binary
		GENERIC MAP(width => size)
		PORT MAP(
			input => read_after_sync,
			output => read_binary
		);
		
		PROCESS(reset,clk_write,w_en)
		BEGIN
			if(reset ='1') then 
				write_binary <= "0000000000";
				--write_gray   <= "0000000000";
				full_signal  <= '0';
			elsif(rising_edge(clk_write) and w_en='1') then
				if(((std_logic_vector(to_unsigned(to_integer(unsigned(old_write_binary)) + 1, 10)) = read_binary) or full_signal = '1') and (write_binary = read_binary)) then 
					full_signal <= '1';
				else
					write_binary <= std_logic_vector(to_unsigned(to_integer(unsigned(write_binary)) + 1, 10));
					full_signal <='0';
				end if;
			end if;
		
		END PROCESS;
		
		write_gray_pointer <= write_gray;
		write_pointer      <= write_binary;
		full               <= full_signal;
		
		
		

end arc1;

