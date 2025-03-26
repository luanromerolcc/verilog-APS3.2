`timescale 1ns/1ps

module count8fsm ( output reg [7:0] CNT,
    input wire clk, res, EN, load,
    input wire [7:0] CNT_In);
    reg [7:0] proxestado, estadoatual;

// estado atual
    always @(posedge clk or negedge res) 
    begin
        if (!res)
            estadoatual <= 8'h00;
        else
            estadoatual <= proxestado;
    end
// prx estado
    always @(*) 
    begin
        if (!res)
            proxestado = 8'h00;
        else if (EN)
        begin
            if (load)
                proxestado = CNT_In;
            else
                proxestado = estadoatual + 1;
        end else
            proxestado = estadoatual;
    end

// saida
    always @(estadoatual) 
    begin
        CNT = estadoatual;
    end

endmodule