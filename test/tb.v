`default_nettype none
`timescale 1ns / 1ps

module tb ();

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Instantiate your module
  tt_um_ppm_encoder ppm (
`ifdef GL_TEST
      .VPWR(1'b1),
      .VGND(1'b0),
`endif
      .ui_in   (ui_in),
      .uo_out  (uo_out),
      .uio_in  (uio_in),
      .uio_out (uio_out),
      .uio_oe  (uio_oe),
      .ena     (ena),
      .clk     (clk),
      .rst_n   (rst_n)
  );

  // Clock generation
  always #5 clk = ~clk;  // 100MHz clock

  initial begin
    clk = 0;
    rst_n = 0;
    ena = 1;
    ui_in = 8'd100;  // Example: Pulse at position 100
    uio_in = 0;

    #20;
    rst_n = 1;

    // Run for a few cycles to capture pulse
    #3000;

    $finish;
  end

endmodule
