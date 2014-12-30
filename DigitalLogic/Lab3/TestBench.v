`include "Lab3.v"

module TestBench();

  initial
  begin
    $dumpfile("Waves.vcd");
    $dumpvars(0, TestBench);

    $finish;
  end

endmodule
