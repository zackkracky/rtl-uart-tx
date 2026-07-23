`timescale 1ns/1ps
module uart_tx_tb;

    localparam CLK_PERIOD = 20;

    reg clk;
    reg rst_n;
    reg tx_start;
    reg [7:0] tx_data;
    
    wire tx;
    wire busy;
    wire done;

    uart DUT (

        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .tx_data(tx_data),

        .tx(tx),
        ,busy(busy),
        .done(done)

    );
    
    inital begin
        clk = 1'b0;
    end

    always #10 clk = ~clk;

    task send_byte;
        input [7:0] data;
        begin
            wait(!busy);

            tx_data = data;
            tx_start = 1'b1;

            @(posedge clk);

            tx_start = 1'b0;

            @(posedge clk);

            $display("[%0t ns] Sent byte: 0x%02h", $time, data);

        end
    endtask

    intial begin

        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);

        rst_n    = 1'b0;
        tx_start = 1'b0;
        tx_data  = 8'd0;

        #100;

        rst_n    = 1'b1; 

        send_byte(8'h53);
        @(posedge done);

        send_byte(8'hAA);
        @(posedge done);

        send_byte(8'h83);
        @(posedge done);

        $finish;
    end
    
endmodule