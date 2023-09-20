----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 16.09.2023 18:04:28
-- Design Name:
-- Module Name: counter - Behavioral
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

entity counter is
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
end counter;

architecture Behavioral of counter is
    signal cntr : unsigned(3 downto 0);
    signal RCO : std_logic;
begin
    Q_o    <= cntr when OE_ni = '0' else "ZZZZ";
    RCO_no <= RCO;

    process (all)
    begin
        if (ACLR_ni = '0') then
            cntr <= "0000";
        elsif (CLK_i'event and CLK_i='1') then
            if (SCLR_ni = '0') then
                cntr <= "0000";
            elsif (LOAD_ni = '0') then
                cntr <= Data_i;
            elsif (ENT_ni = '0' and ENP_ni = '0') then
                if (UD_i = '1') then
                    if (cntr = "1001") then
                        cntr <= "0000";
                    else
                        cntr <= cntr + 1;
                    end if;
                elsif (UD_i = '0') then
                    if (cntr = "0000") then
                        cntr <= "1001";
                    else
                        cntr <= cntr - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process (all)
        variable zero_cond : std_logic;
    begin
        zero_cond := '1' when ((UD_i = '1' and cntr = "1001")
                        or (UD_i = '0' and cntr = "0000")) else '0';

        if (ENT_ni = '1') then
            RCO <= '1';
        elsif (zero_cond = '1') then
            RCO <= '0';
        else
            RCO <= '1';
        end if;
    end process;

    process (all)
    begin
        if (CLK_i = '0' and ENP_ni = '0' and ENT_ni = '0') then
            CCO_no <= RCO;
        else
            CCO_no <= '1';
        end if;
    end process;
end Behavioral;
