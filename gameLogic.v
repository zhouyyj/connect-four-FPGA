module gameLogic(
    input clk,                
    input reset,             
    input [2:0] column,      
    input player,             
    input confirm_move,       
    output reg [1:0] win,          
	 output reg [1:0] winner
);

    reg [1:0] grid[6:0][5:0]; 
reg token_placed;

    integer i, j;
    initial begin
        for (i = 0; i < 7;i = i + 1) begin
            for (j = 0; j < 6; j=j+1) begin
                grid[i][j] = 2'b00;
            end
        end
    end
	 
function automatic [1:0] checkWin(input [1:0] playerToken);
    integer col, row, count, i;
begin
    checkWin = 2'b00;

    for (row = 0; row < 6; row = row + 1) begin
        count = 0;
        for (col = 0; col < 7; col = col + 1) begin
            if (grid[col][row] == playerToken) begin
                count = count + 1;
                if (count == 4) begin
                    checkWin = 2'b01;
                end
            end else count = 0;
        end
    end

    for (col = 0; col < 7; col = col + 1) begin
        count = 0;
        for (row = 0; row < 6; row = row + 1) begin
            if (grid[col][row] == playerToken) begin
                count = count + 1;
                if (count == 4) begin
                    checkWin = 2'b01;
                end
            end else count = 0;
        end
    end

    for (row = 0; row < 3; row = row + 1) begin
        for (col = 0; col < 4; col = col + 1) begin
            count = 0;
            for (i = 0; i < 4; i = i + 1) begin
                if (grid[col + i][row + i] == playerToken) begin
                    count = count + 1;
                    if (count == 4) begin
                        checkWin = 2'b01;
                    end
                end else count = 0;
            end
        end
    end

    for (row = 3; row < 6; row = row + 1) begin
        for (col = 0; col < 4; col = col + 1) begin
            count = 0;
            for (i = 0; i < 4; i = i + 1) begin
                if (grid[col + i][row - i] == playerToken) begin
                    count = count + 1;
                    if (count == 4) begin
                        checkWin = 2'b01;
                    end
                end else count = 0;
            end
        end
end
    end
endfunction


    always @(posedge confirm_move or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 7;i = i + 1) begin
                for (j = 0; j < 6; j=j+1) begin
                    grid[i][j] = 2'b00;
                end
            end
            win <= 0;
				winner <=0;
        end else if (confirm_move) begin
        token_placed = 0;
        for (j = 0; j < 6 && !token_placed; j = j + 1) begin
            if (grid[column][j] == 2'b00) begin
                grid[column][j] = player ? 2'b01 : 2'b10;
                token_placed = 1; 
                win = checkWin(player ? 2'b01 : 2'b10);
					 winner = win[0]?(player ? 2'b01 : 2'b10):0;
            end
        end
    end
end

endmodule
