module A7LITE_TEST (
    input                   CLK_50M,
    input                   RESET_N,
    input                   KEY1,
    input                   KEY2,
    output                  LED1,
    output                  LED2,
    input                   UART_RX,
    output                  UART_TX,
    output                  SD_CLK,
    output                  SD_CMD,
    output      [3:0]       SD_DATA,
    output                  HDMI_CLK_P,
    output                  HDMI_CLK_N,
    output      [2:0]       HDMI_DATA_P,
    output      [2:0]       HDMI_DATA_N,
    input                   HDMI_HPD_CON,
    inout       [15:0]      ddr3_dq,
    inout       [1:0]       ddr3_dqs_n,
    inout       [1:0]       ddr3_dqs_p,
    output      [14:0]      ddr3_addr,
    output      [2:0]       ddr3_ba,
    output                  ddr3_ras_n,
    output                  ddr3_cas_n,
    output                  ddr3_we_n,
    output                  ddr3_cke,
    output      [1:0]       ddr3_dm,
    output                  ddr3_odt,
    output                  ddr3_ck_p,
    output                  ddr3_ck_n,
    output                  ddr3_reset_n
);

wire    [7:0]       cpu_arlen;
wire    [2:0]       cpu_arsize;
wire    [1:0]       cpu_arburst;
wire    [31:0]      cpu_araddr;
wire                cpu_arready;
wire                cpu_arvalid;
wire    [7:0]       cpu_awlen;
wire    [2:0]       cpu_awsize;
wire    [1:0]       cpu_awburst;
wire    [31:0]      cpu_awaddr;
wire                cpu_awready;
wire                cpu_awvalid;
wire                cpu_rlast;
wire                cpu_rready;
wire                cpu_rvalid;
wire    [31:0]      cpu_rdata;
wire    [1:0]       cpu_rresp;
wire                cpu_wready;
wire                cpu_wvalid;
wire    [3:0]       cpu_wstrb;
wire    [31:0]      cpu_wdata;
wire                cpu_wlast;
wire                cpu_bvalid;
wire                cpu_bready;
wire    [1:0]       cpu_bresp;

wire    [3:0]       ddr_arid;
wire    [7:0]       ddr_arlen;
wire    [2:0]       ddr_arsize;
wire    [1:0]       ddr_arburst;
wire    [31:0]      ddr_araddr;
wire                ddr_arready;
wire                ddr_arvalid;
wire    [3:0]       ddr_awid;
wire    [7:0]       ddr_awlen;
wire    [2:0]       ddr_awsize;
wire    [1:0]       ddr_awburst;
wire    [31:0]      ddr_awaddr;
wire                ddr_awready;
wire                ddr_awvalid;
wire    [3:0]       ddr_rid;
wire                ddr_rlast;
wire                ddr_rready;
wire                ddr_rvalid;
wire    [31:0]      ddr_rdata;
wire    [1:0]       ddr_rresp;
wire                ddr_wready;
wire                ddr_wvalid;
wire    [3:0]       ddr_wstrb;
wire    [31:0]      ddr_wdata;
wire                ddr_wlast;
wire    [3:0]       ddr_bid;
wire                ddr_bvalid;
wire                ddr_bready;
wire    [1:0]       ddr_bresp;

wire    [3:0]       ram_arid;
wire    [7:0]       ram_arlen;
wire    [2:0]       ram_arsize;
wire    [1:0]       ram_arburst;
wire    [31:0]      ram_araddr;
wire                ram_arready;
wire                ram_arvalid;
wire    [3:0]       ram_awid;
wire    [7:0]       ram_awlen;
wire    [2:0]       ram_awsize;
wire    [1:0]       ram_awburst;
wire    [31:0]      ram_awaddr;
wire                ram_awready;
wire                ram_awvalid;
wire    [3:0]       ram_rid;
wire                ram_rlast;
wire                ram_rready;
wire                ram_rvalid;
wire    [31:0]      ram_rdata;
wire    [1:0]       ram_rresp;
wire                ram_wready;
wire                ram_wvalid;
wire    [3:0]       ram_wstrb;
wire    [31:0]      ram_wdata;
wire                ram_wlast;
wire    [3:0]       ram_bid;
wire                ram_bvalid;
wire                ram_bready;
wire    [1:0]       ram_bresp;

wire    [3:0]       uart_awid;
wire    [7:0]       uart_awlen;
wire    [2:0]       uart_awsize;
wire    [1:0]       uart_awburst;
wire    [31:0]      uart_awaddr;
wire                uart_awvalid;
wire                uart_awready;
wire    [3:0]       uart_wstrb;
wire    [31:0]      uart_wdata;
wire                uart_wlast;
wire                uart_wvalid;
wire                uart_wready;
wire    [1:0]       uart_bresp;
wire                uart_bvalid;
wire                uart_bready;
wire    [3:0]       uart_arid;
wire    [7:0]       uart_arlen;
wire    [2:0]       uart_arsize;
wire    [1:0]       uart_arburst;
wire    [31:0]      uart_araddr;
wire                uart_arvalid;
wire                uart_arready;
wire    [31:0]      uart_rdata;
wire    [1:0]       uart_rresp;
wire                uart_rvalid;
wire                uart_rready;

wire    [3:0]       gpio_awid;
wire    [7:0]       gpio_awlen;
wire    [2:0]       gpio_awsize;
wire    [1:0]       gpio_awburst;
wire    [31:0]      gpio_awaddr;
wire                gpio_awvalid;
wire                gpio_awready;
wire    [3:0]       gpio_wstrb;
wire    [31:0]      gpio_wdata;
wire                gpio_wlast;
wire                gpio_wvalid;
wire                gpio_wready;
wire    [1:0]       gpio_bresp;
wire                gpio_bvalid;
wire                gpio_bready;
wire    [3:0]       gpio_arid;
wire    [7:0]       gpio_arlen;
wire    [2:0]       gpio_arsize;
wire    [1:0]       gpio_arburst;
wire    [31:0]      gpio_araddr;
wire                gpio_arvalid;
wire                gpio_arready;
wire    [31:0]      gpio_rdata;
wire    [1:0]       gpio_rresp;
wire                gpio_rvalid;
wire                gpio_rready;

wire    [7:0]       hdmi_awlen;
wire    [2:0]       hdmi_awsize;
wire    [1:0]       hdmi_awburst;
wire    [31:0]      hdmi_awaddr;
wire                hdmi_awvalid;
wire                hdmi_awready;
wire    [3:0]       hdmi_wstrb;
wire    [31:0]      hdmi_wdata;
wire                hdmi_wlast;
wire                hdmi_wvalid;
wire                hdmi_wready;
wire    [1:0]       hdmi_bresp;
wire                hdmi_bvalid;
wire                hdmi_bready;
wire    [31:0]      hdmi_araddr;
wire    [7:0]       hdmi_arlen;
wire    [2:0]       hdmi_arsize;
wire    [1:0]       hdmi_arburst;
wire                hdmi_arvalid;
wire                hdmi_arready;
wire    [31:0]      hdmi_rdata;
wire    [1:0]       hdmi_rresp;
wire                hdmi_rlast;
wire                hdmi_rvalid;
wire                hdmi_rready;

wire                SysClk;
wire                ILAClk;
wire                UiClk;
wire                UiRst;
wire                ARESETn;
wire                FRstSync;
wire                VRstSync;
wire                PixelClk;
wire                SerialClk;
wire                VideoHSync;
wire                VideoVSync;
wire                VideoDE;
wire    [23:0]      VideoData;
wire                VideoReq;
wire    [11:0]      VideoXPos;
wire    [11:0]      VideoYPos;
wire    [23:0]      VideoDin;
wire                PixelFifoEmpty;

wire                uart_int;
wire    [31:0]      gpio_io;

TMDSClkGen U_TMDSClkGen (
    .clk_in1                (CLK_50M            ),
    .clk_out1               (PixelClk           ),
    .clk_out2               (SerialClk          ),
    .clk_out3               (SysClk             ),
    .clk_out4               (ILAClk             )
);

RstSync U_RstSync_A (
    .Clk                    (UiClk              ),
    .RstB                   (~UiRst             ),
    .RstSync                (ARESETn            )
);

RstSync U_RstSync_F (
    .Clk                    (PixelClk           ),
    .RstB                   (~UiRst             ),
    .RstSync                (FRstSync           )
);

RstSync U_RstSync_V (
    .Clk                    (PixelClk                   ),
    .RstB                   (~UiRst & ~PixelFifoEmpty   ),
    .RstSync                (VRstSync                   )
);

/*
ILA U_ILA (
    .clk                    (ILAClk             ),
    .probe0                 (cpu_araddr         ),
    .probe1                 (cpu_rdata          ),
    .probe2                 (cpu_awaddr         ),
    .probe3                 (cpu_wdata          ),
    .probe4                 (cpu_arready        ),
    .probe5                 (cpu_arvalid),
    .probe6                 (cpu_rready         ),
    .probe7                 (cpu_rvalid         ),
    .probe8                 (cpu_awready        ),
    .probe9                 (cpu_awvalid        ),
    .probe10                (cpu_wready         ),
    .probe11                (cpu_wvalid         )
); */

//--------------------------------------------------------------------------------------------------
uriscv_axi_top U_RISCV (
    .clk                    (UiClk              ),
    .rst_n                  (ARESETn            ),
    .intr_i                 (uart_int           ),
    .awlen                  (cpu_awlen          ),
    .awsize                 (cpu_awsize         ),
    .awburst                (cpu_awburst        ),
    .awaddr                 (cpu_awaddr         ),
    .awvalid                (cpu_awvalid        ),
    .awready                (cpu_awready        ),
    .wdata                  (cpu_wdata          ),
    .wstrb                  (cpu_wstrb          ),
    .wlast                  (cpu_wlast          ),
    .wvalid                 (cpu_wvalid         ),
    .wready                 (cpu_wready         ),
    .bresp                  (cpu_bresp          ),
    .bvalid                 (cpu_bvalid         ),
    .bready                 (cpu_bready         ),
    .arlen                  (cpu_arlen          ),
    .arsize                 (cpu_arsize         ),
    .arburst                (cpu_arburst        ),
    .araddr                 (cpu_araddr         ),
    .arvalid                (cpu_arvalid        ),
    .arready                (cpu_arready        ),
    .rdata                  (cpu_rdata          ),
    .rlast                  (cpu_rlast          ),
    .rresp                  (cpu_rresp          ),
    .rvalid                 (cpu_rvalid         ),
    .rready                 (cpu_rready         )
);

axi_crossbar #(
    .S_COUNT                (2                                  ),
    .M_COUNT                (4                                  ),
    .S_ID_WIDTH             (3                                  ),
    .M_ID_WIDTH             (4                                  ),
    .M_REGIONS              (1                                  ),
    .M_BASE_ADDR            (0                                  ),
    .M_ADDR_WIDTH           ({32'd24, 32'd24, 32'd24, 32'd29}   )
) U_AXI_CROSSBAR (
    .clk                    (UiClk                  ),
    .rst                    (UiRst                  ),
    .s_axi_awid             ({2'h0, 2'h0}),
    .s_axi_awaddr           ({32'h0, cpu_awaddr}),
    .s_axi_awlen            ({8'h0, cpu_awlen}),
    .s_axi_awsize           ({3'h0, cpu_awsize}),
    .s_axi_awburst          ({2'h1, cpu_awburst}),
    .s_axi_awlock           ({1'b0, 1'b0}),
    .s_axi_awcache          ({4'h0, 4'h0}),
    .s_axi_awprot           ({3'h0, 3'h0}),
    .s_axi_awqos            ({4'h0, 4'h0}),
    .s_axi_awuser           ({1'b0, 1'h0}),
    .s_axi_awvalid          ({1'b0, cpu_awvalid}),
    .s_axi_awready          ({hdmi_awready, cpu_awready}),
    .s_axi_wdata            ({32'h0, cpu_wdata}),
    .s_axi_wstrb            ({4'h0, cpu_wstrb}),
    .s_axi_wlast            ({1'b1, cpu_wlast}),
    .s_axi_wuser            ({1'h0, 1'h0}),
    .s_axi_wvalid           ({1'b0, cpu_wvalid}),
    .s_axi_wready           ({hdmi_wready, cpu_wready}),
    .s_axi_bid              (),
    .s_axi_bresp            ({hdmi_bresp, cpu_bresp}),
    .s_axi_buser            (),
    .s_axi_bvalid           ({hdmi_bvalid, cpu_bvalid}),
    .s_axi_bready           ({1'b1, cpu_bready}),
    .s_axi_arid             ({2'h0, 2'h0}),
    .s_axi_araddr           ({hdmi_araddr, cpu_araddr}),
    .s_axi_arlen            ({hdmi_arlen, cpu_arlen}),
    .s_axi_arsize           ({hdmi_arsize, cpu_arsize}),
    .s_axi_arburst          ({hdmi_arburst, cpu_arburst}),
    .s_axi_arlock           ({1'b0, 1'b0}),
    .s_axi_arcache          ({4'h0, 4'h0}),
    .s_axi_arprot           ({3'h0, 3'h0}),
    .s_axi_arqos            ({4'h0, 4'h0}),
    .s_axi_aruser           ({1'h0, 1'h0}),
    .s_axi_arvalid          ({hdmi_arvalid, cpu_arvalid}),
    .s_axi_arready          ({hdmi_arready, cpu_arready}),
    .s_axi_rid              (),
    .s_axi_rdata            ({hdmi_rdata, cpu_rdata}),
    .s_axi_rresp            ({hdmi_rresp, cpu_rresp}),
    .s_axi_rlast            ({hdmi_rlast, cpu_rlast}),
    .s_axi_ruser            (),
    .s_axi_rvalid           ({hdmi_rvalid, cpu_rvalid}),
    .s_axi_rready           ({hdmi_rready, cpu_rready}),
    .m_axi_awid             ({gpio_awid, uart_awid, ram_awid, ddr_awid}),
    .m_axi_awaddr           ({gpio_awaddr, uart_awaddr, ram_awaddr, ddr_awaddr}),
    .m_axi_awlen            ({gpio_awlen, uart_awlen, ram_awlen, ddr_awlen}),
    .m_axi_awsize           ({gpio_awsize, uart_awsize, ram_awsize, ddr_awsize}),
    .m_axi_awburst          ({gpio_awburst, uart_awburst, ram_awburst, ddr_awburst}),
    .m_axi_awlock           (),
    .m_axi_awcache          (),
    .m_axi_awprot           (),
    .m_axi_awqos            (),
    .m_axi_awregion         (),
    .m_axi_awuser           (),
    .m_axi_awvalid          ({gpio_awvalid, uart_awvalid, ram_awvalid, ddr_awvalid}),
    .m_axi_awready          ({gpio_awready, uart_awready, ram_awready, ddr_awready}),
    .m_axi_wdata            ({gpio_wdata, uart_wdata, ram_wdata, ddr_wdata}),
    .m_axi_wstrb            ({gpio_wstrb, uart_wstrb, ram_wstrb, ddr_wstrb}),
    .m_axi_wlast            ({gpio_wlast, uart_wlast, ram_wlast, ddr_wlast}),
    .m_axi_wuser            (),
    .m_axi_wvalid           ({gpio_wvalid, uart_wvalid, ram_wvalid, ddr_wvalid}),
    .m_axi_wready           ({gpio_wready, uart_wready, ram_wready, ddr_wready}),
    .m_axi_bid              ({4'd0, 4'd0, ram_bid, ddr_bid}),
    .m_axi_bresp            ({gpio_bresp, uart_bresp, ram_bresp, ddr_bresp}),
    .m_axi_buser            ({1'h0, 1'h0, 1'h0, 1'h0}),
    .m_axi_bvalid           ({gpio_bvalid, uart_bvalid, ram_bvalid, ddr_bvalid}),
    .m_axi_bready           ({gpio_bready, uart_bready, ram_bready, ddr_bready}),
    .m_axi_arid             ({gpio_arid, uart_arid, ram_arid, ddr_arid}),
    .m_axi_araddr           ({gpio_araddr, uart_araddr, ram_araddr, ddr_araddr}),
    .m_axi_arlen            ({gpio_arlen, uart_arlen, ram_arlen, ddr_arlen}),
    .m_axi_arsize           ({gpio_arsize, uart_arsize, ram_arsize, ddr_arsize}),
    .m_axi_arburst          ({gpio_arburst, uart_arburst, ram_arburst, ddr_arburst}),
    .m_axi_arlock           (),
    .m_axi_arcache          (),
    .m_axi_arprot           (),
    .m_axi_arqos            (),
    .m_axi_arregion         (),
    .m_axi_aruser           (),
    .m_axi_arvalid          ({gpio_arvalid, uart_arvalid, ram_arvalid, ddr_arvalid}),
    .m_axi_arready          ({gpio_arready, uart_arready, ram_arready, ddr_arready}),
    .m_axi_rid              ({4'h0, 4'h0, ram_rid, ddr_rid}),
    .m_axi_rdata            ({gpio_rdata, uart_rdata, ram_rdata, ddr_rdata}),
    .m_axi_rlast            ({1'b1, 1'b1, ram_rlast, ddr_rlast}),
    .m_axi_ruser            ({1'b0, 1'b0, 1'b0, 1'b0}),
    .m_axi_rresp            ({gpio_rresp, uart_rresp, ram_rresp, ddr_rresp}),
    .m_axi_rvalid           ({gpio_rvalid, uart_rvalid, ram_rvalid, ddr_rvalid}),
    .m_axi_rready           ({gpio_rready, uart_rready, ram_rready, ddr_rready})
);

MIG_DDR3 U_MIG_DDR3 (
    .sys_clk_i              (SysClk             ),
    .sys_rst                (RESET_N            ),
    .aresetn                (ARESETn            ),
    .mmcm_locked            (),
    .device_temp            (),
    .init_calib_complete    (),
    .ui_clk                 (UiClk              ),
    .ui_clk_sync_rst        (UiRst              ),
    .app_sr_req             (1'b0               ),
    .app_ref_req            (1'b0               ),
    .app_zq_req             (1'b0               ),
    .app_sr_active          (),
    .app_ref_ack            (),
    .app_zq_ack             (),
    .s_axi_awid             (ddr_awid           ),
    .s_axi_awlen            (ddr_awlen          ),
    .s_axi_awaddr           (ddr_awaddr[28:0]   ),
    .s_axi_awsize           (ddr_awsize         ),
    .s_axi_awburst          (ddr_awburst        ),
    .s_axi_awlock           (1'b0               ),
    .s_axi_awcache          (4'h0               ),
    .s_axi_awprot           (3'h0               ),
    .s_axi_awqos            (4'h0               ),
    .s_axi_awvalid          (ddr_awvalid        ),
    .s_axi_awready          (ddr_awready        ),
    .s_axi_wdata            (ddr_wdata          ),
    .s_axi_wstrb            (ddr_wstrb          ),
    .s_axi_wlast            (ddr_wlast          ),
    .s_axi_wvalid           (ddr_wvalid         ),
    .s_axi_wready           (ddr_wready         ),
    .s_axi_bready           (ddr_bready         ),
    .s_axi_bid              (ddr_bid            ),
    .s_axi_bresp            (ddr_bresp          ),
    .s_axi_bvalid           (ddr_bvalid         ),
    .s_axi_arid             (ddr_arid           ),
    .s_axi_arlen            (ddr_arlen          ),
    .s_axi_araddr           (ddr_araddr[28:0]   ),
    .s_axi_arsize           (ddr_arsize         ),
    .s_axi_arburst          (ddr_arburst        ),
    .s_axi_arlock           (1'b0               ),
    .s_axi_arcache          (4'h0               ),
    .s_axi_arprot           (3'h0               ),
    .s_axi_arqos            (4'h0               ),
    .s_axi_arvalid          (ddr_arvalid        ),
    .s_axi_arready          (ddr_arready        ),
    .s_axi_rready           (ddr_rready         ),
    .s_axi_rid              (ddr_rid            ),
    .s_axi_rdata            (ddr_rdata          ),
    .s_axi_rresp            (ddr_rresp          ),
    .s_axi_rlast            (ddr_rlast          ),
    .s_axi_rvalid           (ddr_rvalid         ),
    .ddr3_dq                (ddr3_dq            ),
    .ddr3_dqs_n             (ddr3_dqs_n         ),
    .ddr3_dqs_p             (ddr3_dqs_p         ),
    .ddr3_addr              (ddr3_addr          ),
    .ddr3_ba                (ddr3_ba            ),
    .ddr3_ras_n             (ddr3_ras_n         ),
    .ddr3_cas_n             (ddr3_cas_n         ),
    .ddr3_we_n              (ddr3_we_n          ),
    .ddr3_cke               (ddr3_cke           ),
    .ddr3_dm                (ddr3_dm            ),
    .ddr3_odt               (ddr3_odt           ),
    .ddr3_ck_p              (ddr3_ck_p          ),
    .ddr3_ck_n              (ddr3_ck_n          ),
    .ddr3_reset_n           (ddr3_reset_n       )
);

/*
axi_ram U_RAM (
    .clk                    (UiClk              ),
    .rst_n                  (ARESETn            ),
    .s_axi_awid             (ram_awid           ),
    .s_axi_awlen            (ram_awlen          ),
    .s_axi_awsize           (ram_awsize         ),
    .s_axi_awburst          (ram_awburst        ),
    .s_axi_awaddr           (ram_awaddr[12:0]   ),
    .s_axi_awvalid          (ram_awvalid        ),
    .s_axi_awready          (ram_awready        ),
    .s_axi_wdata            (ram_wdata          ),
    .s_axi_wstrb            (ram_wstrb          ),
    .s_axi_wlast            (ram_wlast          ),
    .s_axi_wvalid           (ram_wvalid         ),
    .s_axi_wready           (ram_wready         ),
    .s_axi_bid              (ram_bid            ),
    .s_axi_bresp            (ram_bresp          ),
    .s_axi_bvalid           (ram_bvalid         ),
    .s_axi_bready           (ram_bready         ),
    .s_axi_arid             (ram_arid           ),
    .s_axi_arlen            (ram_arlen          ),
    .s_axi_arsize           (ram_arsize         ),
    .s_axi_arburst          (ram_arburst        ),
    .s_axi_araddr           (ram_araddr[12:0]   ),
    .s_axi_arvalid          (ram_arvalid        ),
    .s_axi_arready          (ram_arready        ),
    .s_axi_rid              (ram_rid            ),
    .s_axi_rdata            (ram_rdata          ),
    .s_axi_rresp            (ram_rresp          ),
    .s_axi_rlast            (ram_rlast          ),
    .s_axi_rvalid           (ram_rvalid         ),
    .s_axi_rready           (ram_rready         )
); */

axiram2048x32 U_RAM (
    .s_aclk                 (UiClk              ),
    .s_aresetn              (ARESETn            ),
    .s_axi_awid             (ram_awid           ),
    .s_axi_awlen            (ram_awlen          ),
    .s_axi_awsize           (ram_awsize         ),
    .s_axi_awburst          (ram_awburst        ),
    .s_axi_awaddr           (ram_awaddr         ),
    .s_axi_awvalid          (ram_awvalid        ),
    .s_axi_awready          (ram_awready        ),
    .s_axi_wdata            (ram_wdata          ),
    .s_axi_wstrb            (ram_wstrb          ),
    .s_axi_wlast            (ram_wlast          ),
    .s_axi_wvalid           (ram_wvalid         ),
    .s_axi_wready           (ram_wready         ),
    .s_axi_bid              (ram_bid            ),
    .s_axi_bresp            (ram_bresp          ),
    .s_axi_bvalid           (ram_bvalid         ),
    .s_axi_bready           (ram_bready         ),
    .s_axi_arid             (ram_arid           ),
    .s_axi_arlen            (ram_arlen          ),
    .s_axi_arsize           (ram_arsize         ),
    .s_axi_arburst          (ram_arburst        ),
    .s_axi_araddr           (ram_araddr         ),
    .s_axi_arvalid          (ram_arvalid        ),
    .s_axi_arready          (ram_arready        ),
    .s_axi_rid              (ram_rid            ),
    .s_axi_rdata            (ram_rdata          ),
    .s_axi_rresp            (ram_rresp          ),
    .s_axi_rlast            (ram_rlast          ),
    .s_axi_rvalid           (ram_rvalid         ),
    .s_axi_rready           (ram_rready         )
);

AxiUartLite U_UART (
    .s_axi_aclk             (UiClk              ),
    .s_axi_aresetn          (ARESETn            ),
    .interrupt              (uart_int           ),
    .s_axi_awaddr           (uart_awaddr[3:0]   ),
    .s_axi_awvalid          (uart_awvalid       ),
    .s_axi_awready          (uart_awready       ),
    .s_axi_wdata            (uart_wdata         ),
    .s_axi_wstrb            (uart_wstrb         ),
    .s_axi_wvalid           (uart_wvalid        ),
    .s_axi_wready           (uart_wready        ),
    .s_axi_bresp            (uart_bresp         ),
    .s_axi_bvalid           (uart_bvalid        ),
    .s_axi_bready           (uart_bready        ),
    .s_axi_araddr           (uart_araddr[3:0]   ),
    .s_axi_arvalid          (uart_arvalid       ),
    .s_axi_arready          (uart_arready       ),
    .s_axi_rdata            (uart_rdata         ),
    .s_axi_rresp            (uart_rresp         ),
    .s_axi_rvalid           (uart_rvalid        ),
    .s_axi_rready           (uart_rready        ),
    .rx                     (UART_RX            ),
    .tx                     (UART_TX            )
);

AxiGPIO U_PIO (
    .s_axi_aclk             (UiClk              ),
    .s_axi_aresetn          (ARESETn            ),
    .s_axi_awaddr           (gpio_awaddr[8:0]   ),
    .s_axi_awvalid          (gpio_awvalid       ),
    .s_axi_awready          (gpio_awready       ),
    .s_axi_wdata            (gpio_wdata         ),
    .s_axi_wstrb            (gpio_wstrb         ),
    .s_axi_wvalid           (gpio_wvalid        ),
    .s_axi_wready           (gpio_wready        ),
    .s_axi_bresp            (gpio_bresp         ),
    .s_axi_bvalid           (gpio_bvalid        ),
    .s_axi_bready           (gpio_bready        ),
    .s_axi_araddr           (gpio_araddr[8:0]   ),
    .s_axi_arvalid          (gpio_arvalid       ),
    .s_axi_arready          (gpio_arready       ),
    .s_axi_rdata            (gpio_rdata         ),
    .s_axi_rresp            (gpio_rresp         ),
    .s_axi_rvalid           (gpio_rvalid        ),
    .s_axi_rready           (gpio_rready        ),
    .gpio_io_o              (gpio_io            )
);

AxiMemRdCtrl U_AxiMemRdCtrl (
    .ACLK                   (UiClk              ),
    .ARESETn                (ARESETn            ),
    .ARADDR                 (hdmi_araddr        ),
    .ARLEN                  (hdmi_arlen         ),
    .ARSIZE                 (hdmi_arsize        ),
    .ARBURST                (hdmi_arburst       ),
    .ARVALID                (hdmi_arvalid       ),
    .ARREADY                (hdmi_arready       ),
    .RDATA                  (hdmi_rdata         ),
    .RRESP                  (hdmi_rresp         ),
    .RLAST                  (hdmi_rlast         ),
    .RVALID                 (hdmi_rvalid        ),
    .RREADY                 (hdmi_rready        ),
    .FifoEmpty              (PixelFifoEmpty     ),
    .VideoClk               (PixelClk           ),
    .VideoRstB              (FRstSync           ),
    .VideoReq               (VideoReq           ),
    .VideoData              (VideoDin           )
);

VGACtrlTop U_VGACtrl (
    .PixelClk               (PixelClk           ),
    .RstB                   (VRstSync           ),
    .VideoDin               (VideoDin           ),
    .VideoDE                (VideoDE            ),
    .VideoHS                (VideoHSync         ),
    .VideoVS                (VideoVSync         ),
    .VideoReq               (VideoReq           ),
    .VideoXPos              (VideoXPos          ),
    .VideoYPos              (VideoYPos          ),
    .VideoDout              (VideoData          )
);

TMDSCtrlTop U_TMDSCtrl (
    .PixelClk               (PixelClk           ),
    .SerialClk              (SerialClk          ),
    .RstB                   (VRstSync           ),
    .VideoDin               (VideoData          ),
    .VideoDE                (VideoDE            ),
    .VideoHSync             (VideoHSync         ),
    .VideoVSync             (VideoVSync         ),
    .TMDSClk_P              (HDMI_CLK_P         ),
    .TMDSClk_N              (HDMI_CLK_N         ),
    .TMDSData_P             (HDMI_DATA_P        ),
    .TMDSData_N             (HDMI_DATA_N        )
);

assign LED1 = gpio_io[0];
assign LED2 = gpio_io[1];

endmodule

