module icebreaker_top
#(parameter DEBUG_LEVEL = 0)
(
input  wire CLK_12M,
input  wire UART_RX,
output wire UART_TX,
input  wire USER_BTN_N,
output wire LEDR_N,
output wire LEDG_N,
output wire LED_RED_N,
output wire LED_GRN_N,
output wire LED_BLU_N,
inout  wire FLASH_SCK,
inout  wire FLASH_SSB,
inout  wire FLASH_IO0,
inout  wire FLASH_IO1,
inout  wire FLASH_IO2,
inout  wire FLASH_IO3,
inout  wire PMOD1A_1,
inout  wire PMOD1A_2,
inout  wire PMOD1A_3,
inout  wire PMOD1A_4,
inout  wire PMOD1A_7,
inout  wire PMOD1A_8,
inout  wire PMOD1A_9,
inout  wire PMOD1A_10,
inout  wire PMOD1B_1,
inout  wire PMOD1B_2,
inout  wire PMOD1B_3,
inout  wire PMOD1B_4,
inout  wire PMOD1B_7,
inout  wire PMOD1B_8,
inout  wire PMOD1B_9,
inout  wire PMOD1B_10,
inout  wire PMOD2_1,
inout  wire PMOD2_2,
inout  wire PMOD2_3,
inout  wire PMOD2_4,
inout  wire PMOD2_8,
inout  wire PMOD2_9,
inout  wire PMOD2_10
);

// PLL for external CLK (12 MHz).
// PLL output frequency for FEEDBACK_PATH = "SIMPLE" is
// F_PLLOUTx = (F_REFERENCECLK * (DIVF + 1)) / (2^DIVQ * (DIVR + 1))
// To get F_PLLOUTx = 96 MHz: DIVF=7, DIVQ=0, DIVR=0.
/**
SB_PLL40_CORE #(
    .FEEDBACK_PATH("SIMPLE"),
    .DELAY_ADJUSTMENT_MODE_FEEDBACK("FIXED"),
    .FDA_FEEDBACK(0),
    .DELAY_ADJUSTMENT_MODE_RELATIVE("FIXED"),
    .FDA_RELATIVE(0),
    .SHIFTREG_DIV_MODE(0),
    .PLLOUT_SELECT("GENCLK"),
    .DIVR(0),
    .DIVF(7),
    .DIVQ(0),
    .FILTER_RANGE(1),
    .ENABLE_ICEGATE(0)
) pll (
    .REFERENCECLK(CLK_12M),
    .RESETB(1'b1),
    .BYPASS(1'b0),
    .EXTFEEDBACK(1'b0),
    .DYNAMICDELAY(7'b0000000),
    .LATCHINPUTVALUE(1'b0),
    .LOCK(lock),
    .PLLOUTGLOBAL(plloutglobal),
    .PLLOUTCORE(plloutcore));
**/
assign clk = CLK_12M;

// On-chip 10 kHz oscillator (100000 ppm).
wire clk_10K;

SB_LFOSC osc_10K_inst (
    .CLKLFPU(1'b1),
    .CLKLFEN(1'b1),
    .CLKLF(clk_10K));

// On-chip 48 MHz oscillator (100000 ppm).
wire clk_48M;

SB_HFOSC osc_48M_inst (
    .CLKHFPU(1'b1),
    .CLKHFEN(1'b1),
    .CLKHF(clk_48M));

// Blink LED timers.
reg [23:0] cntra = 'd0;
reg leda;

always @ (posedge clk_10K)
begin
    if (cntra == 24'd0) begin
        cntra <= 10000/2;
        leda <= ~leda;
    end else begin
        cntra <= cntra - 1;
    end
end

reg [23:0] cntrb = 'd0;
reg ledb;

always @ (posedge clk_48M)
begin
    if (cntrb == 24'd0) begin
        cntrb <= 48000000/2;
        ledb <= ~ledb;
    end else begin
        cntrb <= cntrb - 1;
    end
end

reg [23:0] cntrc = 'd0;
reg ledc;

always @ (posedge clk)
begin
    if (cntrc == 24'd0) begin
        cntrc <= 96000000/2;
        ledc <= ~ledc;
    end else begin
        cntrc <= cntrc - 1;
    end
end

assign LEDR_N = (USER_BTN_N == 1'b1) ? leda : ledb;
assign LEDG_N = ledc;

endmodule
