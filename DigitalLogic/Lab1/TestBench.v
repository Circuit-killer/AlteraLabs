`include "Lab1.v"

module TestBench();

  reg [9:0] Switches;
  wire [9:0] Leds;

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    Switches <= 9'b000000000;

    #10

    Switches <= 9'b010101011;

    #10

    Switches <= 9'b0zzxx1111;

    #10
    $finish;
  end

  Lab1 Test(.SW(Switches), .LEDR(Leds));

endmodule
