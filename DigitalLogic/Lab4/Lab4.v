module Lab4(KEY0, SW, HEX0, HEX1, LEDR);

  input [9:0] SW;
  input KEY0;
  output [0:6] HEX0, HEX1;
  output [9:0] LEDR;

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

  Hex_Disp H0(.Value(Qo[3:0]), .Disp(HEX0[0:6]));
  Hex_Disp H1(.Value(Qo[7:4]), .Disp(HEX1[0:6]));

  assign LEDR[9:0] = 10'b0;

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

module Hex_Disp(Value, Disp);

  input [3:0] Value;
  output reg [0:6] Disp;

  always @ *
  begin
    case (Value)
      4'h0 : Disp = 7'b0000001;
      4'h1 : Disp = 7'b1001111;
      4'h2 : Disp = 7'b0010010;
      4'h3 : Disp = 7'b0000110;
      4'h4 : Disp = 7'b1001100;
      4'h5 : Disp = 7'b0100100;
      4'h6 : Disp = 7'b0100000;
      4'h7 : Disp = 7'b0001111;
      4'h8 : Disp = 7'b0000000;
      4'h9 : Disp = 7'b0001100;
      4'hA : Disp = 7'b0001000;
      4'hB : Disp = 7'b1100000;
      4'hC : Disp = 7'b0110001;
      4'hD : Disp = 7'b1000010;
      4'hE : Disp = 7'b0110000;
      4'hF : Disp = 7'b0111000;
    endcase
  end

endmodule
