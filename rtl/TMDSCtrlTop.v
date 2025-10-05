module TMDSCtrlTop (
    input               PixelClk,
    input               SerialClk,
    input               RstB,
    input   [23:0]      VideoDin,
    input               VideoDE,
    input               VideoHSync,
    input               VideoVSync,
    output              TMDSClk_P,
    output              TMDSClk_N,
    output  [2:0]       TMDSData_P,
    output  [2:0]       TMDSData_N
);

wire    [9:0]   PixelRed;
wire    [9:0]   PixelGreen;
wire    [9:0]   PixelBlue;

// TMDS 8B 10B Encoder
TMDSEncoder U_TMDSEncRed (
    .Clk            (PixelClk           ),
    .RstB           (RstB               ),
    .Din            (VideoDin[23:16]    ),
    .C0             (1'b0               ),
    .C1             (1'b0               ),
    .DE             (VideoDE            ),
    .Dout           (PixelRed           )
);

TMDSEncoder U_TMDSEncGreen (
    .Clk            (PixelClk           ),
    .RstB           (RstB               ),
    .Din            (VideoDin[15:8]     ),
    .C0             (1'b0               ),
    .C1             (1'b0               ),
    .DE             (VideoDE            ),
    .Dout           (PixelGreen         )
);

TMDSEncoder U_TMDSEncBlue (
    .Clk            (PixelClk           ),
    .RstB           (RstB               ),
    .Din            (VideoDin[7:0]      ),
    .C0             (VideoHSync         ),
    .C1             (VideoVSync         ),
    .DE             (VideoDE            ),
    .Dout           (PixelBlue          )
);

// TMDS Clock Serdes
TMDSOutputSerdes U_TMDSClk (
    .PixelClk       (PixelClk           ),
    .SerialClk      (SerialClk          ),
    .RstB           (RstB               ),
    .DataOut        (10'b11111_00000    ),
    .DataOut_P      (TMDSClk_P          ),
    .DataOut_N      (TMDSClk_N          )
);

// TMDS Data Serdes
TMDSOutputSerdes U_TMDSDataRed (
    .PixelClk       (PixelClk           ),
    .SerialClk      (SerialClk          ),
    .RstB           (RstB               ),
    .DataOut        (PixelRed           ),
    .DataOut_P      (TMDSData_P[2]      ),
    .DataOut_N      (TMDSData_N[2]      )
);

TMDSOutputSerdes U_TMDSDataGreen (
    .PixelClk       (PixelClk           ),
    .SerialClk      (SerialClk          ),
    .RstB           (RstB               ),
    .DataOut        (PixelGreen         ),
    .DataOut_P      (TMDSData_P[1]      ),
    .DataOut_N      (TMDSData_N[1]      )
);

TMDSOutputSerdes U_TMDSDataBlue (
    .PixelClk       (PixelClk           ),
    .SerialClk      (SerialClk          ),
    .RstB           (RstB               ),
    .DataOut        (PixelBlue          ),
    .DataOut_P      (TMDSData_P[0]      ),
    .DataOut_N      (TMDSData_N[0]      )
);

endmodule

