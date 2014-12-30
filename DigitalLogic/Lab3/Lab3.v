/* Step 1 (Remove /* From line 7)
module Lab3(Clk, R, S, Q);
	
	input Clk, R, S;
	output Q;
	
	wire R_g, S_g, Qa, Qb /* synthesis keep *//*;
	and (R_g, R, Clk);
	and (S_g, S, Clk);
	nor (Qa, R_g, Qb);
	nor (Qb, S_g, Qa);
	
	assign Q = Qa;
	
endmodule
*/

/* Step 2 
module Lab3(SW, LEDR);
	
	input [9:0] SW;
	output [9:0] LEDR;
	
	D_Latch L0(.D(SW[0]), .Clk(SW[1]), .Q(LEDR[0]));
	
	assign LEDR[9:1] = 9'b0;
	
endmodule

module D_Latch(D, Clk, Q);

	input D, Clk;
	output Q;
	
	wire S, R, S_g, R_g, Qa, Qb /* synthesis keep *//*;
	
	assign S = D;
	assign R = ~D;
	
	assign S_g = ~(Clk & S);
	assign R_g = ~(Clk & R);
	
	assign Qa = ~(Qb & S_g);
	assign Qb = ~(Qa & R_g);
	
	assign Q = Qa;
	
endmodule
*/

/* Step 3
module Lab3(LEDR, SW);

	input [9:0] SW;
	output [9:0] LEDR;
	
	wire Qm;
	
	D_Latch(.D(SW[0]), .Clk(~SW[1]), .Q(Qm));
	D_Latch(.D(Qm), .Clk(SW[1]), .Q(LEDR[0]));
	
	assign LEDR[9:1] = 1'b0;
	
endmodule

module D_Latch(D, Clk, Q);

	input D, Clk;
	output Q;
	
	wire S, R, S_g, R_g, Qa, Qb /* synthesis keep *//*;
	
	assign S = D;
	assign R = ~D;
	
	assign S_g = ~(Clk & S);
	assign R_g = ~(Clk & R);
	
	assign Qa = ~(Qb & S_g);
	assign Qb = ~(Qa & R_g);
	
	assign Q = Qa;
	
endmodule
*/

/* Step 4 
module Lab3(LEDR, SW);

	input [9:0] SW;
	output [9:0] LEDR;
	
	D_Latch D0(.D(SW[0]), .Clk(SW[1]), .Q(LEDR[0]));
	D_FF D1(.D(SW[0]), .Clk(SW[1]), .Q(LEDR[1]));
	D_FF D2(.D(SW[0]), .Clk(~SW[1]), .Q(LEDR[2]));
	
  assign LEDR[9:3] = 7'b0000000;

endmodule

module D_Latch(D, Clk, Q);
	
	input D, Clk;
	output reg Q;
	
	always @ (D, Clk)
	begin	
		if(Clk)
		begin
			Q <= D;
		end
	end
	
endmodule

module D_FF(D, Clk, Q);

	input D, Clk;
	output reg Q;
	
	always @ (posedge Clk)
	begin
		Q <= D;
	end
	
endmodule
*/

/* Step 5
module Lab3(LEDR, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

  input [9:0] SW;
  output [9:0] LEDR;
  output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

  wire [7:0] A, B;
  wire [7:0] Ao;
  wire [8:0] Sum;

  assign LEDR [9:1] = 9'b0;
  assign A [7:0] = SW[9:2];
  assign B [7:0] = SW[9:2];

  D_FF F0(.D(A), .Clk(SW[1]), .R(SW[0]), .Q(Ao));
 
  Adder A0(.A(Ao), .B(B), .S(Sum));

  BCD_7seg Seg0(.Value(B[3:0]), .Display(HEX0[0:6]));
  BCD_7seg Seg1(.Value(B[7:4]), .Display(HEX1[0:6]));
  BCD_7seg Seg2(.Value(Ao[3:0]), .Display(HEX2[0:6]));
  BCD_7seg Seg3(.Value(Ao[7:4]), .Display(HEX3[0:6]));
  BCD_7seg Seg4(.Value(Sum[3:0]), .Display(HEX4[0:6]));
  BCD_7seg Seg5(.Value(Sum[7:4]), .Display(HEX5[0:6]));

  assign LEDR[0] = Sum[8];

endmodule

module D_FF(D, Clk, R, Q);

	input [7:0] D;
  input Clk, R;
	output reg [7:0] Q;
	
	always @ (posedge Clk or negedge R)
	begin
    if(~R)
    begin
      Q [7:0] <= 8'h00;
    end
    else
    begin
		  Q [7:0] <= D [7:0];
    end
  end
	
endmodule

module Adder(A, B, S);

  input [7:0] A, B;
  output [8:0] S;

  assign S [8:0] = {1'b0, A[7:0]} + {1'b0, B[7:0]};

endmodule

module BCD_7seg(Value, Display);
 
  input [3:0] Value;
  output [0:6] Display;
  
  assign Display[0] = (Value[3] & Value[0] & (Value[2] ^ Value[1])) | (~Value[3] & ~Value[1] & (Value[2] ^ Value[0]));
  assign Display[1] = (Value[3] & Value[2] & (Value[1] | ~Value[0])) | (Value[3] & Value[1] & Value[0]) | (~Value[3] & Value[2] & (Value[1] ^ Value[0]));
  assign Display[2] = (Value[3] & Value[2] & (Value[1] | ~Value[0])) | (~Value[3] & ~Value[2] & Value[1] & ~Value[0]);
  assign Display[3] = (Value[2] & Value[1] & Value[0]) | (~Value[2] & ~Value[1] & Value[0]) | (~Value[3] & Value[2] & ~Value[1] & ~Value[0]) | (Value[3] & ~Value[2] & Value[1] & ~Value[0]);
  assign Display[4] = (~Value[3] & Value[2] & (~Value[1] | Value[0])) | (~Value[2] & Value[0] & (~Value[3] | ~Value[1]));
  assign Display[5] = (~Value[3] & ~Value[2] & (Value[1] | Value[0])) | (~Value[3] & Value[0] & (~Value[2] | Value[1])) | (Value[3] & Value[2] & ~Value[1] & Value[0]);
  assign Display[6] = (~Value[3] & ~Value[2] & ~Value[1]) | (~Value[3] & Value[2] & Value[1] & Value[0]) | (Value[3] & Value[2] & ~Value[1] & ~Value[0]);
   
endmodule 
*/
