library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;

-- library textutil;
-- use textutil.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_full is
--  Port ( );
end test_full;

architecture Behavioral of test_full is
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
            Data_i  : in  std_logic_vector(3 downto 0);
            -- CCO_no_0  : out std_logic;
            -- RCO_no_0  : out std_logic;
            -- Q_o_0     : out unsigned(3 downto 0);
            CCO_no_1  : out std_logic;
            RCO_no_1  : out std_logic;
            Q_ls_o_1 : out std_logic_vector(3 downto 0);
            Q_ms_o_1 : out std_logic_vector(3 downto 0)
        );
    end component;
    
    function str2vec(str: string) return std_logic_vector is
        variable temp: std_logic_vector(str'range) := (others => 'X');
    begin
        for i in str'range loop
            if (str(i) = '1') then
                temp(i) := '1';
            elsif (str(i) = '0') then
                temp(i) := '0';
            elsif (str(i) = 'X') then
                temp(i) := 'X';
            elsif (str(i) = 'Z') then
                temp(i) := 'Z';
            elsif (str(i) = 'U') then
                temp(i) := 'U';
            elsif (str(i) = 'W') then
                temp(i) := 'W';
            elsif (str(i) = 'L') then
                temp(i) := 'L';
            elsif (str(i) = 'H') then
                temp(i) := 'H';
            else
                temp(i) := '-';
            end if;
        end loop;
        return temp;
    end function;

    function vec2str(vec: std_logic_vector) return string is
        variable temp: string(vec'left+1 downto 1);
    begin
        for i in vec'reverse_range loop
            if (vec(i) = '1') then
                temp(i+1) := '1';
            elsif (vec(i) = '0') then
                temp(i+1) := '0';
            elsif (vec(i) = 'X') then
                temp(i+1) := 'X';
            elsif (vec(i) = 'Z') then
                temp(i+1) := 'Z';
            elsif (vec(i) = 'U') then
                temp(i+1) := 'U';
            elsif (vec(i) = 'W') then
                temp(i+1) := 'W';
            elsif (vec(i) = 'L') then
                temp(i+1) := 'L';
            elsif (vec(i) = 'H') then
                temp(i+1) := 'H';
            else
                temp(i+1) := '-';
            end if;
        end loop;
        return temp;
    end;
    signal CLK    : std_logic := '0';
    signal OE     : std_logic;
    signal UD     : std_logic;
    signal ENT    : std_logic;
    signal ENP    : std_logic;
    signal SCLR   : std_logic;
    signal LOAD   : std_logic;
    signal ACLR   : std_logic;
    signal Data   : std_logic_vector(3 downto 0) := "0010";

    -- signal CCO_0  : std_logic;
    -- signal RCO_0  : std_logic;
    -- signal Q_0    : unsigned(3 downto 0);
    signal CCO_1  : std_logic;
    signal RCO_1  : std_logic;
    -- signal Q_1    : std_logic_vector(3 downto 0);
    signal Q_ls_o_1 : std_logic_vector(3 downto 0);
    signal Q_ms_o_1 : std_logic_vector(3 downto 0);
    constant PERIOD : time := 10 ns;

begin
    u_top_0 : top
    port map (
        CLK_i    => CLK,
        OE_ni    => OE,
        UD_i     => UD,
        ENT_ni   => ENT,
        ENP_ni   => ENP,
        SCLR_ni  => SCLR,
        LOAD_ni  => LOAD,
        ACLR_ni  => ACLR,
        Data_i   => Data,
        CCO_no_1 => CCO_1,
        RCO_no_1 => RCO_1,
        Q_ls_o_1 => Q_ls_o_1,
        Q_ms_o_1 => Q_ms_o_1
    );

    CLK <= not CLK after PERIOD/2;

    process
        file     vector_file     : text;
        variable vect            : std_logic_vector(20 downto 0);
        variable stimulus        : std_logic_vector(10 downto 0);
        variable expected        : std_logic_vector(9  downto 0);
        variable str_stimulus    : string          (21 downto 1);
        variable err_cnt         : integer := 0;
        variable file_line       : line;
    begin
        file_open(vector_file, "D:/PRJ/vivado/Lab_2/src/sim/test_file.vec", READ_MODE);
        wait until rising_edge(CLK);

        while not endfile(vector_file) loop
            readline (vector_file, file_line);
            read(file_line, str_stimulus);
            report "Vector: " & str_stimulus;
            stimulus := str2vec(str_stimulus)(21 downto 11);
        end loop;

        wait;
    end process;

end Behavioral;
