----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2019 04:22:44 PM
-- Design Name: 
-- Module Name: dataForwarder - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dataForwarder is Port (
    doMemoryWriteback, doWritebackWriteback, operand1Passthrough, operand2Passthrough : in std_logic;
    readReg1, readReg2, memoryWritebackDest, writebackWritebackDest : in std_logic_vector(2 downto 0);
    operand1DecodeStage, operand2DecodeStage, memoryWritebackValue, writebackWritebackValue : in std_logic_vector(15 downto 0);
    operand1, operand2 : out std_logic_vector(15 downto 0)
);
end dataForwarder;

architecture Behavioral of dataForwarder is

signal operand1Selector, operand2Selector : std_logic_vector(2 downto 0);

signal operand1UseMemoryWB, operand2UseMemoryWB : std_logic;
signal operand1UseWritebackWB, operand2UseWritebackWB : std_logic;
signal operand1MemoryDestMatch, operand2MemoryDestMatch : std_logic;
signal operand1WritebackDestMatch, operand2WritebackDestMatch : std_logic;

begin

operand1MemoryDestMatch <= '1' when readReg1 = memoryWritebackDest else '0';
operand1WritebackDestMatch <= '1' when readReg1 = writebackWritebackDest else '0';
operand1UseMemoryWB <= (operand1MemoryDestMatch and doMemoryWriteback);
operand1UseWritebackWB <= (operand1WritebackDestMatch and doWritebackWriteback);
operand1Selector <= operand1Passthrough & operand1UseMemoryWB & operand1UseWritebackWB;

with operand1Selector select
    operand1 <=
        operand1DecodeStage when "100" | "101" | "110" | "111" | "000",
        memoryWritebackValue when "010" | "011",
        writebackWritebackValue when "001",
        operand1DecodeStage when others;

operand2MemoryDestMatch <= '1' when readReg2 = memoryWritebackDest else '0';
operand2WritebackDestMatch <= '1' when readReg2 = writebackWritebackDest else '0';
operand2UseMemoryWB <= (operand2MemoryDestMatch and doMemoryWriteback);
operand2UseWritebackWB <= (operand2WritebackDestMatch and doWritebackWriteback);
operand2Selector <= operand2Passthrough & operand2UseMemoryWB & operand2UseWritebackWB;

with operand2Selector select
    operand2 <=
        operand2DecodeStage when "100" | "101" | "110" | "111" | "000",
        memoryWritebackValue when "010" | "011",
        writebackWritebackValue when "001",
        operand2DecodeStage when others;


end Behavioral;