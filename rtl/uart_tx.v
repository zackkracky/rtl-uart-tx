module uart_tx #(
    parameter CLK_FREQ = 50_000_000;
    parameter BAUD_RATE = 115200
)(
    input wire  clk,
    input wire  rst_n,//active low
    input wire  tx_start,
    input wire  [7:0] tx_data,

    output reg  tx,
    output reg  busy,
    output reg  done
);

localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

endmodule