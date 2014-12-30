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
