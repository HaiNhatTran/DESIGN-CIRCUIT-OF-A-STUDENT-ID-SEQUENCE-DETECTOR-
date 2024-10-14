`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 03:33:58 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb();
    // Inputs
    logic clk;
    logic rst_n;
    logic [3:0] in_num;

    // Outputs
    logic detected;

    // Instantiate the Unit Under Test (UUT)
    sequence_detector_mealy_20161311 uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .in_num(in_num), 
        .detected(detected)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 100 MHz clock (period = 10ns)
    end

    // Initialize signals
    initial begin
        // Initialize clock and reset
        clk = 0;
        rst_n = 0;
        in_num = 4'd0;

        // Apply reset
        #10 rst_n = 1;  // Release reset after 10 ns

        // Test case 1: Correct sequence '20161311'
        $display("Test case 1: Correct sequence 20161311");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd1;  // S2 -> S3
        #10 in_num = 4'd6;  // S3 -> S4
        #10 in_num = 4'd1;  // S4 -> S5
        #10 in_num = 4'd3;  // S5 -> S6
        #10 in_num = 4'd1;  // S6 -> S7
        #10 in_num = 4'd1;  // S7 -> S0, detected = 1

        // Test case 2: Shorter sequence, wrong at step 4
        $display("Test case 2: Sequence wrong at step 4");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd1;  // S2 -> S3
        #10 in_num = 4'd3;  // S3 -> S0 (wrong input)
        #10 in_num = 4'd0;  // No further detection
        #10 in_num = 4'd1;

        // Test case 3: Sequence wrong at step 2
        $display("Test case 3: Sequence wrong at step 2");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd1;  // S1 -> S0 (wrong input)

        // Test case 4: Sequence wrong at step 3
        $display("Test case 4: Sequence wrong at step 3");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd3;  // S2 -> S0 (wrong input)

        // Test case 5: Sequence wrong at step 6
        $display("Test case 5: Sequence wrong at step 6");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd1;  // S2 -> S3
        #10 in_num = 4'd6;  // S3 -> S4
        #10 in_num = 4'd1;  // S4 -> S5
        #10 in_num = 4'd2;  // S5 -> S0 (wrong input)
        #10 in_num = 4'd1;

        // Test case 6: Sequence wrong at step 7
        $display("Test case 6: Sequence wrong at step 7");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd1;  // S2 -> S3
        #10 in_num = 4'd6;  // S3 -> S4
        #10 in_num = 4'd1;  // S4 -> S5
        #10 in_num = 4'd3;  // S5 -> S6
        #10 in_num = 4'd2;  // S6 -> S0 (wrong input)

        // Test case 7: Sequence wrong at step 1
        $display("Test case 7: Sequence wrong at step 1");
        #10 in_num = 4'd1;  // S0 -> S0 (wrong input)

        // Test case 8: Invalid input
        $display("Test case 8: Invalid input sequence");
        #10 in_num = 4'd5;  // S0 -> S0 (wrong input)
        #10 in_num = 4'd7;  // S0 -> S0 (wrong input)

        // Test case 9: Another incorrect sequence with extra digits
        $display("Test case 9: Incorrect sequence 20161");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd1;  // S2 -> S3
        #10 in_num = 4'd6;  // S3 -> S4
        #10 in_num = 4'd1;  // S4 -> S5
        #10 in_num = 4'd2;  // S5 -> S0 (wrong input)


        // Test case 10: Correct sequence '20161311'
        $display("Test case 1: Correct sequence 20161311");
        #10 in_num = 4'd2;  // S0 -> S1
        #10 in_num = 4'd0;  // S1 -> S2
        #10 in_num = 4'd1;  // S2 -> S3
        #10 in_num = 4'd6;  // S3 -> S4
        #10 in_num = 4'd1;  // S4 -> S5
        #10 in_num = 4'd3;  // S5 -> S6
        #10 in_num = 4'd1;  // S6 -> S7
        #10 in_num = 4'd1;  // S7 -> S0, detected = 1
        // End the simulation
        #20 $finish;
    end

    // Monitor the detected signal
    initial begin
        $monitor("Time: %0t, Detected: %b, in_num: %d", $time, detected, in_num);
    end

endmodule
