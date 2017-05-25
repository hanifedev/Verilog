module sevensegment(SW, HEX0, HEX1, HEX2, HEX3);
       input [17:0] SW;
       output [0:6] HEX0, HEX1, HEX2, HEX3;
       b2d_7seg B0(SW[3:0], HEX0);
       b2d_7seg B1(SW[7:4], HEX1);
       b2d_7seg B2(SW[11:8], HEX2);
       b2d_7seg B3(SW[15:12], HEX3);
endmodule


module b2d_7seg (x,x0,x1,x2,x3, SSD);
       input [3:0] x,x0,x1,x2,x3;
       output [6:0] SSD;
       assign SSD[0] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 &  x1 & ~x2 & ~x3));
       assign SSD[1] = ((~x0 &  x1 & ~x2 &  x3) | (~x0 &  x1 &  x2 & ~x3));
       assign SSD[2] =  (~x0 & ~x1 &  x2 & ~x3);
       assign SSD[3] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 &  x1 & ~x2 & ~x3) | (~x0 &  x1 & x2 & x3) | (x0 & ~x1 & ~x2 & x3));
       assign SSD[4] = ~((~x1 & ~x3) | (x2 & ~x3));
       assign SSD[5] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 & ~x1 &  x2 & ~x3) | (~x0 & ~x1 & x2 & x3) | (~x0 & x1 & x2 & x3));
       assign SSD[6] = ((~x0 & ~x1 & ~x2 &  x3) | (~x0 & ~x1 & ~x2 & ~x3) | (~x0 & x1 & x2 & x3));
endmodule
