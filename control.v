module control(
    input clk,                 
    input reset,               
    input [2:0] column_select, 
    input confirm_move1,
    input confirm_move2,       
    output reg [1:0] current_player, 
    output reg game_over,      
	 output [1:0] winner
);

    parameter IDLE_STATE = 3'b000,
              PLAYER1_TURN = 3'b001,
              PLAYER2_TURN = 3'b010,
              CHECK_MOVE = 3'b011,
				  win_state = 3'b100;
    reg [2:0] state = IDLE_STATE; 
wire confirm_move = (current_player==2'b01)?confirm_move1:confirm_move2;
    wire [1:0]win;
    gameLogic game_logic(
        .clk(clk),
        .reset(reset),
        .column(column_select),
        .player(current_player == 2'b01), 
        .confirm_move(confirm_move),
        .win(win),
		  .winner(winner)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE_STATE;
            current_player <= 2'b01;  
            game_over <= 0;
        end
        else begin
            case (state)
                IDLE_STATE: begin
                    if (confirm_move) begin
                        state <= CHECK_MOVE;
                    end
                end
                PLAYER1_TURN: begin
                    if (confirm_move) begin
                        state <= CHECK_MOVE;
                    end
                end
                PLAYER2_TURN: begin
                    if (confirm_move) begin
                        state <= CHECK_MOVE;
                    end
                end
                CHECK_MOVE: begin
                    if (win) begin
                        state <= win_state; 
                    end else begin
                        current_player <= (current_player == 2'b01) ? 2'b10 : 2'b01;
                        state <= (current_player == 2'b01) ? PLAYER1_TURN : PLAYER2_TURN;
                    end
                end
					 
					 win_state: begin
					 game_over <= 1; 
					 end
					 
                default: state <= IDLE_STATE;
            endcase
        end
    end

endmodule
