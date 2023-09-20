----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 16.09.2023 18:03:12
-- Design Name:
-- Module Name: top - Behavioral
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

entity top is
    Port (
        CLK_i   : in  std_logic;
        OE_ni   : in  std_logic;
        UD_i    : in  std_logic;
        ENT_ni  : in  std_logic;
        ENP_ni  : in  std_logic;
        SCLR_ni : in  std_logic;
        LOAD_ni : in  std_logic;
        ACLR_ni : in  std_logic;
        Data_i  : in  std_logic_vector(3 downto 0);

        CCO_no_0  : out std_logic;
        RCO_no_0  : out std_logic;
        Q_o_0     : out unsigned(3 downto 0);
        CCO_no_1  : out std_logic;
        RCO_no_1  : out std_logic;
        Q_o_1     : out std_logic_vector(3 downto 0)
    );
end top;

architecture Behavioral of top is
    component counter is
    port (
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
    component counter_struct is
        port (
            CLK_i   : in  std_logic;
            OE_ni   : in  std_logic;
            UD_i    : in  std_logic;
            ENT_ni  : in  std_logic;
            ENP_ni  : in  std_logic;
            SCLR_ni : in  std_logic;
            LOAD_ni : in  std_logic;
            ACLR_ni : in  std_logic;
            Data_i  : in  std_logic_vector(3 downto 0);

            CCO_no  : out std_logic;
            RCO_no  : out std_logic;
            Q_o     : out std_logic_vector(3 downto 0)
        );
        end component;
begin
    u_counter_0 : counter
        port map (
            CLK_i   => CLK_i,
            OE_ni   => OE_ni,
            UD_i    => UD_i,
            ENT_ni  => ENT_ni,
            ENP_ni  => ENP_ni,
            SCLR_ni => SCLR_ni,
            LOAD_ni => LOAD_ni,
            ACLR_ni => ACLR_ni,
            Data_i  => unsigned(Data_i),
            CCO_no  => CCO_no_0,
            RCO_no  => RCO_no_0,
            Q_o     => Q_o_0
        );
    u_counter_1 : counter_struct
        port map (
            CLK_i   => CLK_i,
            OE_ni   => OE_ni,
            UD_i    => UD_i,
            ENT_ni  => ENT_ni,
            ENP_ni  => ENP_ni,
            SCLR_ni => SCLR_ni,
            LOAD_ni => LOAD_ni,
            ACLR_ni => ACLR_ni,
            Data_i  => Data_i,
            CCO_no  => CCO_no_1,
            RCO_no  => RCO_no_1,
            Q_o     => Q_o_1
        );

end Behavioral;
