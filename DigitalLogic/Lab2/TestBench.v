`include "Lab2.v"

module TestBench();

  reg [9:0] Switches;
  wire [9:0] Leds;
  wire [0:6] Disp0, Disp1;

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    Switches[9:0] <= 10'b0000111111;

    #10

    $finish;
  end

  Lab2 Test(.SW(Switches), .LEDR(Leds), .HEX0(Disp0), .HEX1(Disp1));

endmodule
