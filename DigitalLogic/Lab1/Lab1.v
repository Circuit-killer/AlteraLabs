/* Step 1
module Lab1 (SW, LEDR);
	
	input [9:0] SW; // slide switches
	output [9:0] LEDR; // red LEDs
	assign LEDR = SW;
	
endmodule
*/

/* Step 2
module Lab1(SW, LEDR);

	input [9:0] SW;
	output [9:0] LEDR;
	wire [3:0] X;
	wire [3:0] Y;
	wire m0, m1, m2, m3;
	wire s;
	
	assign X = SW [3:0];
	assign Y = SW [7:4];
	assign s = SW[9];
	assign m0 = (~s & X[0]) | (s & Y[0]);
	assign m1 = (~s & X[1]) | (s & Y[1]);
	assign m2 = (~s & X[2]) | (s & Y[2]);
	assign m3 = (~s & X[3]) | (s & Y[3]);
	
	assign LEDR [8:4] = 5'b00000;
	assign LEDR [0] = m0;
	assign LEDR [1] = m1;
	assign LEDR [2] = m2;
	assign LEDR [3] = m3;
	assign LEDR [9] = s;
	
endmodule
*/

/* Step 3
module Lab1(SW, LEDR);
	
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire [1:0] u;
	wire [1:0] v;
	wire [1:0] w;
	wire [1:0] s;
	wire m0, m1;
	
	assign u = SW[5:4];
	assign v = SW[3:2];
	assign w = SW[1:0];
	assign s[1:0] = SW[9:8];
	
	assign m0 = (s[1] & w[0]) | (~s[1] & ~s[0] & u[0]) | (~s[1] & s[0] & v[0]);
	assign m1 = (s[1] & w[1]) | (~s[1] & ~s[0] & u[1]) | (~s[1] & s[0] & v[1]);
	
	assign LEDR[9:2] = 2'h00;
	assign LEDR[0] = m0;
	assign LEDR[1] = m1;
	
endmodule
*/

/* Step 4
module Lab1(SW, HEX0, LEDR);
	
	input [9:0] SW;
	output [0:6] HEX0;
	output [9:0] LEDR;
	
	wire [1:0] c;
	wire [0:6] display;
	
	assign c [1:0] = SW[1:0];
	
  assign display [0:6] = (7'b1111111 & {7{c[0] & c[1]}}) | (7'b1001111 & {7{~c[0] & c[1]}}) | (7'b0110000 & {7{c[0] & ~c[1]}}) | (7'b1000010 & {7{~c[0] & ~c[1]}});
	
	assign HEX0 [0:6] = display;
	
	assign LEDR [9:0] = 10'b0;
endmodule

/* Step 5
module Lab1(HEX0, HEX1, HEX2, LEDR, SW);

	input [9:0] SW;
	output [0:6] HEX0, HEX1, HEX2;
	output [9:0] LEDR;
	wire [1:0] M0, M1, M2;
	
	three_to_one Mux2(.s(SW[9:8]), .u(SW[1:0]), .v(SW[5:4]), .w(SW[3:2]), .m(M0));
	three_to_one Mux1(.s(SW[9:8]), .u(SW[3:2]), .v(SW[1:0]), .w(SW[5:4]), .m(M1));
	three_to_one Mux0(.s(SW[9:8]), .u(SW[5:4]), .v(SW[3:2]), .w(SW[1:0]), .m(M2));
	
	char_7seg C0(.c(M0), .display(HEX0));
	char_7seg C1(.c(M1), .display(HEX1));
	char_7seg C2(.c(M2), .display(HEX2));
	
	assign LEDR [9:0] = 1'b0;
	
endmodule

module three_to_one(s, u, v, w, m);

	input [1:0] s, u, v, w;
	output [1:0] m;
	
	assign m[0] = (s[1] & w[0]) | (~s[1] & ~s[0] & u[0]) | (~s[1] & s[0] & v[0]);
	assign m[1] = (s[1] & w[1]) | (~s[1] & ~s[0] & u[1]) | (~s[1] & s[0] & v[1]);
	
endmodule

module char_7seg(c, display);
		
	input [1:0] c;
	output [0:6] display;
		
  assign display [0:6] = (7'b1111111 & {7{c[0] & c[1]}}) | (7'b1001111 & {7{~c[0] & c[1]}}) | (7'b0110000 & {7{c[0] & ~c[1]}}) | (7'b1000010 & {7{~c[0] & ~c[1]}});

endmodule
*/

/* Step 6 
module Lab1(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW);

	input [9:0] SW;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	wire [2:0] s;
	
	assign s [2:0] = SW [9:7];
	assign LEDR [9:0] = 1'b0;

	assign HEX0 [0:6] = ({7{~s[2] & ~s[1] & ~s[0]}} & 7'b1001111) | ({7{s[2] & ~s[1] & s[0]}} & 7'b0110000) | ({7{s[2] & ~s[1] & ~s[0]}} & 7'b1000010) | ({7{~s[2] & s[1] | ~s[2] & s[0]}} & 7'b1111111);
	assign HEX1 [0:6] = ({7{~s[2] & ~s[1] & s[0]}} & 7'b1001111) | ({7{~s[2] & ~s[1] & ~s[0]}} & 7'b0110000) | ({7{s[2] & ~s[1] & s[0]}} & 7'b1000010) | ({7{~s[2] & s[1] | s[2] & ~s[1] & ~s[0]}} & 7'b1111111);
	assign HEX2 [0:6] = ({7{~s[2] & s[1] & ~s[0]}} & 7'b1001111) | ({7{~s[2] & ~s[1] & s[0]}} & 7'b0110000) | ({7{~s[2] & ~s[1] & ~s[0]}} & 7'b1000010) | ({7{s[2] & ~s[1] | s[0] & (s[1] ^ s[2])}} & 7'b1111111);
	assign HEX3 [0:6] = ({7{~s[2] & s[1] & s[0]}} & 7'b1001111) | ({7{~s[2] & s[1] & ~s[0]}} & 7'b0110000) | ({7{~s[2] & ~s[1] & s[0]}} & 7'b1000010) | ({7{s[2] & ~s[1] | ~s[1] & ~s[0]}} & 7'b1111111);
	assign HEX4 [0:6] = ({7{s[2] & ~s[1] & ~s[0]}} & 7'b1001111) | ({7{~s[2] & s[1] & s[0]}} & 7'b0110000) | ({7{~s[2] & s[1] & ~s[0]}} & 7'b1000010) | ({7{~s[2] & ~s[1] | ~s[1] & s[0]}} & 7'b1111111);
	assign HEX5 [0:6] = ({7{s[2] & ~s[1] & s[0]}} & 7'b1001111) | ({7{s[2] & ~s[1] & ~s[0]}} & 7'b0110000) | ({7{~s[2] & s[1] & s[0]}} & 7'b1000010) | ({7{~s[2] & ~s[1] | ~s[2] & ~s[0]}} & 7'b1111111);
	
endmodule
*/
