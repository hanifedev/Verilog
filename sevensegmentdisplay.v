module sevensegment(HEX0,HEX1,HEX2);
		output [6:0] HEX2, HEX1, HEX0;
		assign HEX0[0] = 1;
		assign HEX0[1] = 0;
		assign HEX0[2] = 0;
		assign HEX0[3] = 0;
		assign HEX0[4] = 0;
		assign HEX0[5] = 1;
		assign HEX0[6] = 0;
		assign HEX1 = 7'b0001000;
		assign HEX2 = 7'b0000110;
endmodule
		
