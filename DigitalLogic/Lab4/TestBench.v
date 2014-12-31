`include "Lab4.v"

module TestBench();

  reg [9:0] S;
  wire [0:6] H0, H1;
  wire [9:0] Led;
  reg Key;

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    S[9:0] = 10'b0;
    Key = 1'b0;

    #5

    S[1:0] = 2'b11;

    #10

    S[0] = 1'b0;

    #10

    S[0] = 1'b1;

    #40

    $finish;

  end

  always #1 Key = ~Key;

  Lab4 L0(.KEY0(Key), .SW(S), .HEX0(H0), .HEX1(H1), .LEDR(Led));

endmodule
