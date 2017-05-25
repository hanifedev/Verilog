module dort_bit_toplam(SW, LEDR);
      input [7:0] SW;
      output [4:0] LEDR;
      full_adder fa1(SW[0], SW[4], 0, s1, c1);
      full_adder fa2(SW[1], SW[5], c1, s2, c2);
      full_adder fa3(SW[2], SW[6], C2, S3, C3);
      full_adder fa4(SW[3], SW[7], c3, s4, c4);
      assign LEDR[0]=s1;
      assign LEDR[1]=s2;
      assign LEDR[2]=s3;
      assign LEDR[3]=s4;
      assign LEDR[4]=c4;
endmodule

module full_adder(a,b,ci,s,co);
      input a,b,ci;
      output co,s;
      wire d;
      assign d=a^b;
      assign s=d^ci;
      assign co=(b&~d) | (d&ci);
endmodule
