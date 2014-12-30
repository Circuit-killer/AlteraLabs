`include "Lab3.v"

module TestBench();

  reg [9:0] S;
  wire [9:0] Led;

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    S[9:0] = 10'b0000000000;
    
    #10

    S[0] = 1;
    S[1] = 1;

    #10

    S[1] = 0;

    #10

    S[1] = 1;

    #10

    S[0] = 0;

    #10

    $finish;
  end

  Lab3 L0(.SW(S[9:0]), .LEDR(Led[9:0]));

endmodule
