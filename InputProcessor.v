module InputProcessor (
    input clk,               
    input [2:0] switches,    
    input confirm_key1,       
input confirm_key2,
    input reset_key,       
    output reg [2:0] column, 
    output reg confirm1,       
output reg confirm2,
    output reg reset        
);

    always @(posedge clk) begin
        column <= switches; 
    end

    always @(posedge clk) begin
        confirm1 <= !confirm_key1; 
	confirm2 <= !confirm_key2;
        reset <= !reset_key;      
    end

endmodule
