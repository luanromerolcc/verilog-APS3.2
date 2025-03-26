module Semaforo(
    input CAR, TIMEOUT, clk,
    output reg GRN, YLW, RED);

    parameter GREENSTATE   = 2'b00;
    parameter YELLOWSTATE  = 2'b01;
    parameter REDSTATE     = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk) 
    begin
        state <= next_state;
    end

    always @(*)
    begin
        case(state)
            GREENSTATE: begin
                if (CAR) next_state = YELLOWSTATE;
                else     next_state = GREENSTATE;
            end
            YELLOWSTATE: begin
                next_state = REDSTATE;
            end
            REDSTATE: begin
                if (TIMEOUT) next_state = GREENSTATE;
                else          next_state = REDSTATE;
            end
            default: next_state = GREENSTATE;
        endcase
    end

    always @(*) 
    begin
        case(state)
            GREENSTATE:
                begin
                    GRN = 1'b1;
                    YLW = 1'b0;
                    RED = 1'b0;
                end
            YELLOWSTATE:
                begin
                    GRN = 1'b0;
                    YLW = 1'b1;
                    RED = 1'b0;
                end
            REDSTATE:
                begin
                    GRN = 1'b0;
                    YLW = 1'b0;
                    RED = 1'b1;
                end
            default:
                begin
                    GRN = 1'b0;
                    YLW = 1'b0;
                    RED = 1'b0;
                end
        endcase
    end
endmodule
