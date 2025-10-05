module TMDSEncoder (
    input               Clk,
    input               RstB,
    input       [7:0]   Din,
    input               C0,
    input               C1,
    input               DE,
    output  reg [9:0]   Dout
);

// Counting number of 1s and 0s for each incoming pixel
// component. Pipe line the result.
// Register Data Input so it matches the pipe lined adder output
reg [3:0] n1d; //number of 1s in din
reg [7:0] din_q;

always @ (posedge Clk)
begin
    n1d <= Din[0] + Din[1] + Din[2] + Din[3] + Din[4] + Din[5] + Din[6] + Din[7];
    din_q <= Din;
end

// Stage 1: 8 bit -> 9 bit
// Refer to DVI 1.0 Specification, page 29, Figure 3-5
wire decision1;

assign decision1 = (n1d > 4'h4) | ((n1d == 4'h4) & (din_q[0] == 1'b0));

wire [8:0] q_m;
assign q_m[0] = din_q[0];
assign q_m[1] = (decision1) ? (q_m[0] ^~ din_q[1]) : (q_m[0] ^ din_q[1]);
assign q_m[2] = (decision1) ? (q_m[1] ^~ din_q[2]) : (q_m[1] ^ din_q[2]);
assign q_m[3] = (decision1) ? (q_m[2] ^~ din_q[3]) : (q_m[2] ^ din_q[3]);
assign q_m[4] = (decision1) ? (q_m[3] ^~ din_q[4]) : (q_m[3] ^ din_q[4]);
assign q_m[5] = (decision1) ? (q_m[4] ^~ din_q[5]) : (q_m[4] ^ din_q[5]);
assign q_m[6] = (decision1) ? (q_m[5] ^~ din_q[6]) : (q_m[5] ^ din_q[6]);
assign q_m[7] = (decision1) ? (q_m[6] ^~ din_q[7]) : (q_m[6] ^ din_q[7]);
assign q_m[8] = (decision1) ? 1'b0 : 1'b1;

// Stage 2: 9 bit -> 10 bit
// Refer to DVI 1.0 Specification, page 29, Figure 3-5
reg [3:0] n1q_m, n0q_m; // number of 1s and 0s for q_m
always @ (posedge Clk)
begin
    n1q_m  <= q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7];
    n0q_m  <= 4'h8 - (q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7]);
end

parameter CTRLTOKEN0 = 10'b1101010100;
parameter CTRLTOKEN1 = 10'b0010101011;
parameter CTRLTOKEN2 = 10'b0101010100;
parameter CTRLTOKEN3 = 10'b1010101011;

reg [4:0] cnt; //disparity counter, MSB is the sign bit
wire decision2, decision3;

assign decision2 = (cnt == 5'h0) | (n1q_m == n0q_m);
assign decision3 = (~cnt[4] & (n1q_m > n0q_m)) | (cnt[4] & (n0q_m > n1q_m));

// pipe line alignment
reg       de_q, de_reg;
reg       c0_q, c1_q;
reg       c0_reg, c1_reg;
reg [8:0] q_m_reg;

always @ (posedge Clk)
begin
    de_q    <= DE;
    de_reg  <= de_q;

    c0_q    <= C0;
    c0_reg  <= c0_q;
    c1_q    <= C1;
    c1_reg  <= c1_q;

    q_m_reg <= q_m;
end

// 10-bit out
// disparity counter
always @ (posedge Clk or negedge RstB)
begin
    if(RstB == 1'b0) begin
        Dout <= 10'h0;
        cnt  <= 5'h0;
    end else begin
        if (de_reg) begin
            if(decision2) begin
                Dout[9]   <= ~q_m_reg[8];
                Dout[8]   <= q_m_reg[8];
                Dout[7:0] <= (q_m_reg[8]) ? q_m_reg[7:0] : ~q_m_reg[7:0];
                cnt <= (~q_m_reg[8]) ? (cnt + n0q_m - n1q_m) : (cnt + n1q_m - n0q_m);
            end else begin
                if(decision3) begin
                    Dout[9]   <= 1'b1;
                    Dout[8]   <= q_m_reg[8];
                    Dout[7:0] <= ~q_m_reg[7:0];
                    cnt <= cnt + {q_m_reg[8], 1'b0} + (n0q_m - n1q_m);
                end else begin
                    Dout[9]   <= 1'b0;
                    Dout[8]   <= q_m_reg[8];
                    Dout[7:0] <= q_m_reg[7:0];
                    cnt <= cnt - {~q_m_reg[8], 1'b0} + (n1q_m - n0q_m);
                end
            end
        end else begin
            case ({c1_reg, c0_reg})
              2'b00:   Dout <= CTRLTOKEN0;
              2'b01:   Dout <= CTRLTOKEN1;
              2'b10:   Dout <= CTRLTOKEN2;
              default: Dout <= CTRLTOKEN3;
            endcase
            cnt <= 5'h0;
        end
    end
end

endmodule
