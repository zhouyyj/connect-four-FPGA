module demo(input CLOCK_50, input [2:0]SW, input [2:0]KEY, output [6:0]HEX0, output [6:0]HEX2 );
wire [1:0] player;
wire [1:0] gameover;
wire [1:0] winner;
TopLevelModule top(CLOCK_50, SW[2:0],KEY[2], KEY[1], KEY[0], player, winner);
hex_decoder hex0(player, HEX0);
hex_decoder hex1(winner, HEX2);
endmodule

module hex_decoder(c, display);
	input[3:0] c;
	output[6:0] display;
	wire m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15;
	assign a = c[3];
	assign b = c[2];
	assign c1 = c[1];
	assign d = c[0];
	
	assign m0 = ~a & ~b & ~c1 & ~d;
	assign m1 = ~a & ~b & ~c1 & d;
	assign m2 = ~a & ~b & c1 & ~d;
	assign m3 = ~a & ~b & c1 & d;
	assign m4 = ~a & b & ~c1 & ~d;
	assign m5 = ~a & b & ~c1 & d;
	assign m6 = ~a & b & c1 & ~d;
	assign m7 = ~a & b & c1 & d;
	assign m8 = a & ~b & ~c1 & ~d;
	assign m9 = a & ~b & ~c1 & d;
	assign m10 = a & ~b & c1 & ~d;
	assign m11 = a & ~b & c1 & d;
	assign m12 = a & b & ~c1 & ~d;
	assign m13 = a & b & ~c1 & d;
	assign m14 = a & b & c1 & ~d;
	assign m15 = a & b & c1 & d;
	
	
	assign display[0] = m1 | m4 | m11 | m13;
	assign display[1] = m5 | m6 | m11 | m12 | m14 | m15;
	assign display[2] = m2 | m12 | m14 | m15;
	assign display[3] = m1 | m4 | m7 | m9 | m10 | m15;
	assign display[4] = m1 | m3 | m4 | m5 | m7 | m9;
	assign display[5] = m1 | m2 | m3 | m7 | m13;
	assign display[6] = m0 | m1 | m7 | m12;
endmodule