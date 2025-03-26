`include "SEMAFORO.v"

module tb_Semaforo;

    
    reg CAR;
    reg TIMEOUT;
    reg clk;
    

    wire GRN;
    wire YLW;
    wire RED;

  
    Semaforo uut (
        .CAR(CAR),
        .TIMEOUT(TIMEOUT),
        .clk(clk),
        .GRN(GRN),
        .YLW(YLW),
        .RED(RED)
    );

   
    always begin
        #5 clk = ~clk; 
    end

    initial begin
  
        clk = 0;
        CAR = 0;
        TIMEOUT = 0;
        $dumpfile("semaforo.vcd"); 
        $dumpvars(0, tb_Semaforo);

 
        $display("Iniciando a simulação");

        #10;
        $display("Estado inicial: GRN = %b, YLW = %b, RED = %b", GRN, YLW, RED);

        // Teste 2: Ativando o CAR e verificando transição para amarelo
        CAR = 1; // Detector de carro ativado
        #10;
        $display("Após CAR ativado: GRN = %b, YLW = %b, RED = %b", GRN, YLW, RED);

        // Teste 3: Semáforo deve transitar para vermelho
        CAR = 0;
        #10;
        $display("Após transição para VERMELHO: GRN = %b, YLW = %b, RED = %b", GRN, YLW, RED);

        // Teste 4: Semáforo em vermelho
        #10;
        $display("Semáforo em VERMELHO: GRN = %b, YLW = %b, RED = %b", GRN, YLW, RED);

        // Teste 5: Timeout ativado, semáforo deve voltar para verde
        TIMEOUT = 1; // Timeout após 15 segundos
        #10;
        $display("Após TIMEOUT: GRN = %b, YLW = %b, RED = %b", GRN, YLW, RED);

        // Teste 6: Semáforo deve ficar verde
        #10;
        $display("Semáforo em VERDE: GRN = %b, YLW = %b, RED = %b", GRN, YLW, RED);

        // Finaliza a simulação
        $finish;
    end

endmodule

