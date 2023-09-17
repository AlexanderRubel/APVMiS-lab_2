----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2023 12:37:43
-- Design Name: 
-- Module Name: testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    component top is
        Port (
            CLK_i   : in  std_logic;
            OE_ni   : in  std_logic;
            UD_i    : in  std_logic;
            ENT_ni  : in  std_logic;
            ENP_ni  : in  std_logic;
            SCLR_ni : in  std_logic;
            LOAD_ni : in  std_logic;
            ACLR_ni : in  std_logic;
            Data_i  : in  unsigned(3 downto 0);
    
            CCO_no  : out std_logic;
            RCO_no  : out std_logic;
            Q_o     : out unsigned(3 downto 0)
        );
    end component;
    signal CLK  : std_logic := '0';
    signal OE   : std_logic;
    signal UD   : std_logic;
    signal ENT  : std_logic;
    signal ENP  : std_logic;
    signal SCLR : std_logic;
    signal LOAD : std_logic;
    signal ACLR : std_logic;
    signal Data : unsigned(3 downto 0);
    signal CCO  : std_logic;
    signal RCO  : std_logic;
    signal Q    : unsigned(3 downto 0);

    constant PERIOD : time := 10 ns;
begin
    u_top_0 : top 
    port map (
        CLK_i   => CLK,
        OE_ni   => OE,
        UD_i    => UD,
        ENT_ni  => ENT,
        ENP_ni  => ENP,
        SCLR_ni => SCLR,
        LOAD_ni => LOAD,
        ACLR_ni => ACLR,
        Data_i  => Data,
        CCO_no  => CCO,
        RCO_no  => RCO,
        Q_o     => Q
    );

    CLK <= not CLK after PERIOD/2;

    process
    begin
        ACLR <= '0';
        OE   <= '0';
        SCLR <= '1';
        LOAD <= '1';
        ENP  <= '0';
        ENT  <= '0';
        UD   <= '1';
        Data <= "0000";
        wait for PERIOD*3;
        ACLR <= '1';
        wait for PERIOD*3;
        Data <= "1011";
        wait for PERIOD/2;
        SCLR <= '0';
        wait for PERIOD/2;
        wait for PERIOD;
        SCLR <= '1';
        wait for PERIOD/2;
        LOAD <= '0';
        wait for PERIOD/2;
        wait for PERIOD/2;
        LOAD <= '1';
        wait for PERIOD/2;
        wait for PERIOD*5;
        wait for PERIOD/2;
        OE   <= '1';
        wait for PERIOD*2;
        OE   <= '0';
        wait for PERIOD/2;
        wait for PERIOD;
        wait for PERIOD/2;
        UD   <= '0';
        wait for PERIOD/2;
        wait for PERIOD*6;
        wait for PERIOD/2;
        ENP  <= '1';
        wait for PERIOD;
        ENT  <= '1';
        wait for PERIOD;
        ENP  <= '0';
        wait for PERIOD/2;
        wait;
    end process;

end Behavioral;