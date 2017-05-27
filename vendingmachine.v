module vendingmachine(SW,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	reg[3:0] r1,r2,r3,r4;
	input [6:0] SW;
	output [3:0] LEDR,LEDG;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	always @* begin
	r1=4'b0001;
	r2=4'b0011;
	r3=4'b0101;
	r4=4'b1010;
	end

	wire sonuc1,sonuc2,sonuc3,sonuc4;
	mux_dort_bir MUX1(SW[0],SW[0],r1[0:0],r2[0:0], r3[0:0], r4[0:0], sonuc1 );
	mux_dort_bir MUX2(SW[0],SW[1],r1[1:1],r2[1:1], r3[1:1], r4[1:1], sonuc2 );
	mux_dort_bir MUX3(SW[1],SW[0],r1[2:2],r2[2:2], r3[2:2], r4[2:2], sonuc3 );
	mux_dort_bir MUX4(SW[1],SW[1],r1[2:2],r2[2:2], r3[2:2], r4[2:2], sonuc4 );
	assign LEDR[0] = sonuc1;
	assign LEDR[1] = sonuc2;
	assign LEDR[2] = sonuc3;
	assign LEDR[3] = sonuc4;

	
	//ürünün fiyatýný göster
	wire y0,y1,y2,y3,y4,y5,y6,y7;
	binarytobcd tb0 (SW[6], SW[5], SW[4], SW[3], SW[2],y0,y1,y2,y3,y4,y5,y6,y7); 
	b2d_7seg b01 (y0,y1,y2,y3,HEX4);
	b2d_7seg b11 (y4,y5,y6,0,HEX5);
	
	wire a0,a1,a2,a3,a4,a5,a6,a7;
	binarytobcd tb02 (SW[6], SW[5], SW[4], SW[3], SW[2],a0,a1,a2,a3,a4,a5,a6,a7); 
	b2d_7seg b02 (a0,a1,a2,a3,HEX0);
	b2d_7seg b12 (a4,a5,a6,a7,HEX1);

	
	
	//karþýlaþtýr modulu olcak tek çýktýsý olcak örnedðin durum 
	wire s0,s1,s2,s3,s4,b0,b1,b2,b3,b4,b5,b6,b7;
	bes_bit_cikarici b10 (SW[2], SW[3], SW[4], SW[5], SW[6], 0,0,0,0,0,s0,s1,s2,s3,s4);
	binarytobcd tb03 (s0,s1,s2,s3,s4,b0,b1,b2,b3,b4,b5,b6,b7);
	b2d_7seg b03 (b0,b1,b2,b3,HEX2);
	b2d_7seg b13 (b4,b5,b6,b7,HEX3);
	
	assign LEDG[0] = sonuc1;
	assign LEDG[1] = sonuc2;
	assign LEDG[2] = sonuc3;
	assign LEDG[3] = sonuc4;*/
	
	
	
endmodule

module mux_dort_bir(x,y,a,b,c,d,out);
	output out;
	input a;
	input b;
	input c;
	input d;
	input x;
	input y;
	assign out = ( a & (~x) & (~y) ) |
					 ( b & (~x) & y ) |
					 ( c & x & (~y) ) |
					 ( d & x & y );
endmodule

module bes_bit_cikarici(b0, b1, b2, b3, b4, a0, a1, a2, a3, a4,s0,s1,s2,s3,s4);
	input [9:0] b0, b1, b2, b3, b4, a0, a1, a2, a3, a4;
	output [4:0] s0,s1,s2,s3,s4;
	fullsubstractor fs1(b0,a0,0,s0,c0);
	fullsubstractor fs2(b1,a1,c0,s1,c1);
	fullsubstractor fs3(b2,a2,c1,s2,c2);
	fullsubstractor fs4(b3,a3,c2,s3,c3);
	fullsubstractor fs5(b4,a4,c3,s4,c4);

endmodule

module fullsubstractor(a,b,ci,s,co);
	input a,b,ci;
	output co,s;
	assign s = a^b^ci;
	assign co = ((~a)&b)+(b&ci)+(ci&(~a));
endmodule



module binarytobcd (a,b,c,d,e,y0,y1,y2,y3,y4,y5,y6,y7);
	input a,b,c,d,e;
	output y0,y1,y2,y3,y4,y5,y6,y7;
	
	assign y0 = e;
	assign y1 = (~a & ~b & d) | (~b & c & d) | (~a & b & c & ~d) | (a & ~b & ~c & ~d) | (a & b & ~c & d);
	assign y2 = (~a & ~b & c) | (~a & c & d) | (a & ~c & ~d) | (a & b & ~c);
	assign y3 = (~a & b & ~c & ~d) | (a & ~b & ~c & d) | (a & b & c & ~d);
	assign y4 = (~a & b & d) | (~a & b & c) | (a & ~b & ~c)| (b & c & d);  
	assign y5 = ((a & c) | (a & b));
	assign y6 = 0;
	assign y7=0;
	
endmodule

module b2d_7seg (x0,x1,x2,x3, SSD);
       input [3:0] x0,x1,x2,x3;
       output [0:6] SSD;
       assign SSD[0] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 &  x1 & ~x2 & ~x3));
       assign SSD[1] = ((~x0 &  x1 & ~x2 &  x3) | (~x0 &  x1 &  x2 & ~x3));
       assign SSD[2] =  (~x0 & ~x1 &  x2 & ~x3);
       assign SSD[3] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 &  x1 & ~x2 & ~x3) | (~x0 &  x1 & x2 & x3) | (x0 & ~x1 & ~x2 & x3));
       assign SSD[4] = ~((~x1 & ~x3) | (x2 & ~x3));
       assign SSD[5] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 & ~x1 &  x2 & ~x3) | (~x0 & ~x1 & x2 & x3) | (~x0 & x1 & x2 & x3));
       assign SSD[6] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 & ~x1 & ~x2 & ~x3) | (~x0 & x1 & x2 & x3));
endmodule
