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
    localparam IDLE = 2'b00; 
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;

    reg [1:0] state;
    reg [15:0] baud_counter;
    reg [2:0] bit_counter;
    reg [7:0] shift_reg; 
    
    always @(posedge clk or negedge rst_n)begin

        if (!rst_n) begin
            state   <= IDLE;
            baud_counter <= 16'd0;
            bit_counter  <= 3'd0;
            shift_reg    <= 8'd0;

            tx   <= 1'b1;
            busy <= 1'b0;
            done <= 1'b0;

        end
        else begin

            done <= 1'b0;
            case(state)

                IDLE :begin
                    tx = 1'b1;
                    busy = 1'b0;
                    baud_counter <= 16'd0;
                    bit_counter <= 3'd0;

                    if (tx_start)begin
                        
                        shift_reg <= tx_data;
                        busy <= 1'b1;
                        state <= START;

                    end

                end
                START:begin
                
                end
                DATA :begin
                
                end
                STOP :begin

                end

            endcase

        end

    end

endmodule
