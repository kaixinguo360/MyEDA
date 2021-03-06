LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

Entity MY_LIGHT is
	port(
		EN, RES, CLK: IN std_logic;
		A_NUM10: OUT std_logic_vector(3 downto 0);
		A_NUM1: OUT std_logic_vector(3 downto 0);
		A_LIGHT: OUT std_logic_vector(2 downto 0);
		B_NUM10: OUT std_logic_vector(3 downto 0);
		B_NUM1: OUT std_logic_vector(3 downto 0);
		B_LIGHT: OUT std_logic_vector(2 downto 0)
	);
End MY_LIGHT;

Architecture behave of MY_LIGHT is
signal COUNT: Integer range 0 to 50;
signal A_NUM: Integer range 0 to 25;
signal B_NUM: Integer range 0 to 25;
begin
	process(EN, RES, CLK) -- COUNTER50
	begin
		if(CLK'event and CLK='1') then
			if(RES = '1') then
				COUNT <= 0;
			elsif(EN = '1') then
				if(COUNT < 50) then
					COUNT <= COUNT + 1;
				else
					COUNT <= 0;
				end if;
			end if;
		end if;
	end process;
	
	process(COUNT) -- LIGHT
	begin
		if(COUNT < 20) then
			A_LIGHT <= "001";
			A_NUM <= 20 - COUNT;
			B_LIGHT <= "100";
			B_NUM <= 25 - COUNT;
		elsif(COUNT < 25) then
			A_LIGHT <= "010";
			A_NUM <= 25 - COUNT;
			B_LIGHT <= "100";
			B_NUM <= 25 - COUNT;
		elsif(COUNT < 45) then
			A_LIGHT <= "100";
			A_NUM <= 50 - COUNT;
			B_LIGHT <= "001";
			B_NUM <= 45 - COUNT;
		elsif(COUNT < 50) then
			A_LIGHT <= "100";
			A_NUM <= 50 - COUNT;
			B_LIGHT <= "010";
			B_NUM <= 50 - COUNT;
		end if;
	end process;
	
	process(A_NUM) -- A_NUM
	begin
		if(A_NUM >= 20) then
			A_NUM10 <= "0010";
			A_NUM1 <= CONV_STD_LOGIC_VECTOR(A_NUM - 20, 4);
		elsif(A_NUM >= 10) then
			A_NUM10 <= "0001";
			A_NUM1 <= CONV_STD_LOGIC_VECTOR(A_NUM - 10, 4);
		else
			A_NUM10 <= "0000";
			A_NUM1 <= CONV_STD_LOGIC_VECTOR(A_NUM, 4);
		end if;
	end process;
	
	process(B_NUM) -- B_NUM
	begin
		if(B_NUM >= 20) then
			B_NUM10 <= "0010";
			B_NUM1 <= CONV_STD_LOGIC_VECTOR(B_NUM - 20, 4);
		elsif(B_NUM >= 10) then
			B_NUM10 <= "0001";
			B_NUM1 <= CONV_STD_LOGIC_VECTOR(B_NUM - 10, 4);
		else
			B_NUM10 <= "0000";
			B_NUM1 <= CONV_STD_LOGIC_VECTOR(B_NUM, 4);
		end if;
	end process;
End Architecture behave;