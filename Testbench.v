// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module traffic_light_controller_tb;

    // Testbench signals
    reg clk;
    reg rst;

    wire red;
    wire yellow;
    wire green;

 
    // DUT Instantiation
   

    traffic_light_controller dut (
        .clk    (clk),
        .rst    (rst),
        .red    (red),
        .yellow (yellow),
        .green  (green)
    );

  
    // Clock Generation
  

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end

 
    // Reset and Simulation
    

    initial begin

        // Start with reset
        rst = 1;

        #20;

        // Release reset
        rst = 0;

        // Run simulation
        #200;

        $finish;

    end

   
    // Monitor
    

    initial begin

        $monitor(
            "Time = %0t | Reset = %b | RED = %b | YELLOW = %b | GREEN = %b",
            $time,
            rst,
            red,
            yellow,
            green
        );

    end

    
    // Waveform Dump
    

    initial begin

        $dumpfile("traffic_light_controller.vcd");
        $dumpvars(0, traffic_light_controller_tb);

    end

endmodule
