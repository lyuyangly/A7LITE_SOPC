module TMDSOutputSerdes (
    input               PixelClk,
    input               SerialClk,
    input               RstB,
    input   [9:0]       DataOut,
    output              DataOut_P,
    output              DataOut_N
);

wire            DataOutS;
wire    [1:0]   SlvShiftOut;

OBUFDS # (
    .IOSTANDARD ("TMDS_33"  )
) U_OutputBUFDS (
    .I          (DataOutS   ),
    .O          (DataOut_P  ),
    .OB         (DataOut_N  )
);

OSERDESE2 #(
    .DATA_RATE_OQ   ("DDR"      ),
    .DATA_RATE_TQ   ("SDR"      ),
    .DATA_WIDTH     (10         ),
    .TRISTATE_WIDTH (1          ),
    .TBYTE_CTL      ("FALSE"    ),
    .TBYTE_SRC      ("FALSE"    ),
    .SERDES_MODE    ("MASTER"   )
) U_SerializerMaster (
    .CLK        (SerialClk      ),
    .CLKDIV     (PixelClk       ),
    .RST        (~RstB          ),
    .TCE        (1'b0           ),
    .OCE        (1'b1           ),
    .T1         (1'b0           ),
    .T2         (1'b0           ),
    .T3         (1'b0           ),
    .T4         (1'b0           ),
    .TBYTEIN    (1'b0           ),
    .TBYTEOUT   (),
    .TQ         (),
    .TFB        (),
    .SHIFTIN1   (SlvShiftOut[0] ),
    .SHIFTIN2   (SlvShiftOut[1] ),
    .SHIFTOUT1  (),
    .SHIFTOUT2  (),
    .D1         (DataOut[0]     ),
    .D2         (DataOut[1]     ),
    .D3         (DataOut[2]     ),
    .D4         (DataOut[3]     ),
    .D5         (DataOut[4]     ),
    .D6         (DataOut[5]     ),
    .D7         (DataOut[6]     ),
    .D8         (DataOut[7]     ),
    .OQ         (DataOutS       ),
    .OFB        ()
);

OSERDESE2 #(
    .DATA_RATE_OQ   ("DDR"      ),
    .DATA_RATE_TQ   ("SDR"      ),
    .DATA_WIDTH     (10         ),
    .TRISTATE_WIDTH (1          ),
    .TBYTE_CTL      ("FALSE"    ),
    .TBYTE_SRC      ("FALSE"    ),
    .SERDES_MODE    ("SLAVE"    )
) U_SerializerSlave (
    .CLK        (SerialClk      ),
    .CLKDIV     (PixelClk       ),
    .RST        (~RstB          ),
    .TCE        (1'b0           ),
    .OCE        (1'b1           ),
    .T1         (1'b0           ),
    .T2         (1'b0           ),
    .T3         (1'b0           ),
    .T4         (1'b0           ),
    .TBYTEIN    (1'b0           ),
    .TBYTEOUT   (),
    .TQ         (),
    .TFB        (),
    .SHIFTIN1   (1'b0           ),
    .SHIFTIN2   (1'b0           ),
    .SHIFTOUT1  (SlvShiftOut[0] ),
    .SHIFTOUT2  (SlvShiftOut[1] ),
    .D1         (1'b0           ),
    .D2         (1'b0           ),
    .D3         (DataOut[8]     ),
    .D4         (DataOut[9]     ),
    .D5         (1'b0           ),
    .D6         (1'b0           ),
    .D7         (1'b0           ),
    .D8         (1'b0           ),
    .OQ         (),
    .OFB        ()
);

endmodule
