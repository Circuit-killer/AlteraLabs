`include "Lab4.v"

module TestBench();

  reg [9:0] S;
  wire [0:6] H0;
  reg CLK;

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    S[9:0] = 10'b0;
    CLK = 0;

    #5

    S[0] = 1'b1;

    #100

    $finish;

  end

  always #1 CLK = ~CLK;

  Lab4 L0(.SW(S[9:0]), .HEX0(H0[0:6]), .CLOCK_50(CLK));

endmodule
