`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 02:52:42 PM
// Design Name: 
// Module Name: sequence_detector_mealy_20161311
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

module sequence_detector_mealy_20161311(
     input logic clk, 
    input logic rst_n,
    input logic [3:0] in_num,
    output logic detected
    );
    
    typedef enum logic [3:0] {
        S0,     // Initial state
        S1,     // "2" has been received
        S2,     // "20" has been received
        S3,     // "201" has been received
        S4,     // "2016" has been received
        S5,     // "20161" has been received
        S6,     // "201613" has been received
        S7,     // "2016131" has been received
        S8      // "20161311" has been received (final state)
     } state_t;  
    
    state_t current_state, next_state;
    
    // State machine transitions on clock edge and reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S0;  // Reset to the initial state
        else
            current_state <= next_state;  // Update to the next state
    end
    
    // Logic for state transitions and output determination (Mealy machine)
    always_comb begin
        next_state = current_state;
        detected = 0;
        
        case (current_state)
            S0: begin
                if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Stay in S0 if input is not 2
            end
            
            S1: begin
                if (in_num == 4'd0) next_state = S2;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 0 nor 2
            end
            
            S2: begin
                if (in_num == 4'd1) next_state = S3;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 1 nor 2
            end
            
            S3: begin
                if (in_num == 4'd6) next_state = S4;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 6 nor 2
            end
            
            S4: begin
                if (in_num == 4'd1) next_state = S5;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 1 nor 2
            end
            
            S5: begin
                if (in_num == 4'd3) next_state = S6;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 3 nor 2
            end
            
            S6: begin
                if (in_num == 4'd1) next_state = S7;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 1 nor 2
            end
            
            S7: begin
                if (in_num == 4'd1) next_state = S8;
                else if (in_num == 4'd2) next_state = S1;
                else next_state = S0;  // Go back to S0 if input is neither 1 nor 2
            end
            
            S8: begin
                detected = 1;  // Detect the complete sequence
                next_state = S0;  // After detection, go back to S0
            end
            
        endcase
    end
endmodule