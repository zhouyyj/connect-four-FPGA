module TopLevelModule(
    input clk,                    
    input [2:0] switches,        
    input confirm_key1,   
input confirm_key2,     
    input reset_key,            
    output [1:0] player_led,     
    output [1:0] winner_led           
);

    wire [2:0] column_select;
    wire confirm_move1;
wire confirm_move2;
    wire reset_game;
    wire [1:0] current_player;
    wire game_over;

    InputProcessor input_proc(
        .clk(clk),
        .switches(switches),
        .confirm_key1(confirm_key1),
        .confirm_key2(confirm_key2),
        .reset_key(reset_key),
        .column(column_select),
        .confirm1(confirm_move1),
.confirm2(confirm_move2),
        .reset(reset_game)
    );

    control control_unit(
        .clk(clk),
        .reset(reset_game),
        .column_select(column_select),
        .confirm_move1(confirm_move1),
        .confirm_move2(confirm_move2),
        .current_player(current_player),
        .game_over(game_over), .winner(winner_led)
    );

    assign player_led = current_player;

endmodule
