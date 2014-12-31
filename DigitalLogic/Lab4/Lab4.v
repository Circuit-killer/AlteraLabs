module Lab4(KEY0, SW, LEDR);

  input [9:0] SW;
  output [9:0] LEDR;
  input KEY0;
  wire [7:0] Qo, T;

  T_FF F0(.En(SW[1]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[0]));

  assign T[0] = SW[1] & Qo[0];
  T_FF F1(.En(T[0]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[1]));
  
  assign T[1] = T[0] & Qo[1];
  T_FF F2(.En(T[1]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[2]));
  
  assign T[2] = T[1] & Qo[2];
  T_FF F3(.En(T[2]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[3]));

  assign T[3] = T[2] & Qo[3];
  T_FF F4(.En(T[3]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[4]));

  assign T[4] = T[3] & Qo[4];
  T_FF F5(.En(T[4]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[5]));

  assign T[5] = T[4] & Qo[5];
  T_FF F6(.En(T[5]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[6]));

  assign T[6] = T[5] & Qo[6];
  T_FF F7(.En(T[6]), .Clk(KEY0), .Clr(SW[0]), .Q(Qo[7]));

  assign LEDR[9:8] = 2'b0;
  assign LEDR[7:0] = Qo[7:0];

endmodule

module T_FF(En, Clk, Clr, Q);

  input En, Clk, Clr;
  output reg Q;

  always @ (posedge Clk)
  begin
    if(~Clr)
    begin
      Q = 1'b0;
    end
    else if(En)
    begin
      Q = ~Q;
    end
  end

endmodule
