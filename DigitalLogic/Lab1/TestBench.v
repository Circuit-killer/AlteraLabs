`include "Lab1.v"

module TestBench();

  reg [9:0] Switches;
  wire [9:0] Leds;
  wire [0:6] Disp0, Disp1, Disp2, Disp3, Disp4, Disp5;

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    Switches[9:0] = 9'b0;
    #10

    Switches[9:7] = 3'b001;
    #10

    Switches[9:7] = 3'b010;
    #10

    Switches[9:7] = 3'b011;
    #10

    Switches[9:7] = 3'b100;
    #10

    Switches[9:7] = 3'b101;
    #10

    $finish;
  end

  Lab1 Test(.SW(Switches), .LEDR(Leds), .HEX0(Disp0), .HEX1(Disp1), .HEX2(Disp2), .HEX3(Disp3), .HEX4(Disp4), .HEX5(Disp5));

endmodule
