#include "board.h"

int main(void)
{
    int st = 0;
    uint32_t pixel[8] = {0xFFFFFF, 0xFFFF00, 0x00FFFF, 0x00FF00, 0xFF00FF, 0xFF0000, 0x0000FF, 0x000000};

    p_func boot_main=(p_func)(AXI_DDR_BASE);

    iowr(AXI_PIO_BASE, 0x1);

    // UART 115200 8N1
    uart_puts("RISC-V CPU Boot\r\n");

    // HDMI Color Bar
    for (uint32_t y = 0; y < 1080; y++) {
        for (uint32_t x = 0; x < 1920; x++) {
            iowr(AXI_HDMI_BASE + ((1920*y + x) << 2), pixel[(x/240)]);
        }
    }

    uart_puts("Receive File Via Xmodem\r\n");

    st = xmodemReceive((unsigned char *)(AXI_DDR_BASE), 256*1024*1024);

    if(st < 0) {
        uart_puts("Xmodem Receive FAIL.\r\n");
        while(1) {
            iowr(AXI_PIO_BASE, 0x1);
            mdelay(500);
            iowr(AXI_PIO_BASE, 0x2);
            mdelay(500);
        }
    } else {
        uart_puts("\rBooting @ AXI_DDR_BASE\r\n");
        boot_main();
    }

    return 0;
}

