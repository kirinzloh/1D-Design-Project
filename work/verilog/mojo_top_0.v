/*
   This file was generated automatically by the Mojo IDE version B1.3.4.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input cclk,
    output reg spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output reg [3:0] spi_channel,
    input avr_tx,
    output reg avr_rx,
    input avr_rx_busy,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  wire [7-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [16-1:0] M_seg_values;
  multi_seven_seg_2 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  reg [28:0] M_counter_d, M_counter_q = 1'h0;
  localparam IDLE_state = 5'd0;
  localparam NORMAL_ADDITION_state = 5'd1;
  localparam ADDITION_OVERFLOW_state = 5'd2;
  localparam NORMAL_SUBTRACTION_state = 5'd3;
  localparam SUBTRACTION_OVERFLOW_state = 5'd4;
  localparam ZERO_SIGNAL_state = 5'd5;
  localparam ADDER_ERROR_TEST_state = 5'd6;
  localparam ADDER_ERROR_state = 5'd7;
  localparam BOOLEAN_AND_state = 5'd8;
  localparam BOOLEAN_OR_state = 5'd9;
  localparam BOOLEAN_XOR_state = 5'd10;
  localparam BOOLEAN_A_state = 5'd11;
  localparam BOOLEAN_ERROR_TEST_state = 5'd12;
  localparam BOOLEAN_ERROR_state = 5'd13;
  localparam COMPARE_CMPEQT_state = 5'd14;
  localparam COMPARE_CMPEQF_state = 5'd15;
  localparam COMPARE_CMPLTT_state = 5'd16;
  localparam COMPARE_CMPLTF_state = 5'd17;
  localparam COMPARE_CMPLTETE_state = 5'd18;
  localparam COMPARE_CMPLTETL_state = 5'd19;
  localparam COMPARE_CMPLEF_state = 5'd20;
  localparam COMPARE_ERROR_TEST_state = 5'd21;
  localparam COMPARE_ERROR_state = 5'd22;
  localparam SHIFT_LEFT_state = 5'd23;
  localparam SHIFT_RIGHT_state = 5'd24;
  localparam ARITHMETIC_SHIFT_RIGHT_state = 5'd25;
  localparam SHIFT_ERROR_TEST_state = 5'd26;
  localparam SHIFT_ERROR_state = 5'd27;
  localparam END_state = 5'd28;
  
  reg [4:0] M_state_d, M_state_q = IDLE_state;
  
  reg [5:0] alufn;
  
  reg [7:0] a;
  
  reg [7:0] b;
  
  reg [7:0] alu_output;
  
  localparam DELAY = 5'h1c;
  
  wire [1-1:0] M_alu_sub_overflow;
  wire [1-1:0] M_alu_z;
  wire [1-1:0] M_alu_v;
  wire [1-1:0] M_alu_n;
  wire [8-1:0] M_alu_alu_output;
  reg [6-1:0] M_alu_alufn;
  reg [8-1:0] M_alu_a;
  reg [8-1:0] M_alu_b;
  alu_mod_3 alu (
    .alufn(M_alu_alufn),
    .a(M_alu_a),
    .b(M_alu_b),
    .sub_overflow(M_alu_sub_overflow),
    .z(M_alu_z),
    .v(M_alu_v),
    .n(M_alu_n),
    .alu_output(M_alu_alu_output)
  );
  
  always @* begin
    M_state_d = M_state_q;
    M_counter_d = M_counter_q;
    
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    led[1+5-:6] = 6'h00;
    led[7+0-:1] = M_alu_v;
    led[0+0-:1] = M_alu_sub_overflow;
    io_seg = ~M_seg_seg;
    io_sel = ~M_seg_sel;
    M_seg_values = 16'hdddd;
    a = io_dip[0+7-:8];
    b = io_dip[8+7-:8];
    alufn = io_dip[16+0+5-:6];
    M_alu_alufn = alufn;
    M_alu_a = a;
    M_alu_b = b;
    alu_output = M_alu_alu_output;
    io_led[0+7-:8] = io_dip[0+7-:8];
    io_led[8+7-:8] = io_dip[8+7-:8];
    io_led[16+7-:8] = alu_output;
    
    case (M_state_q)
      IDLE_state: begin
        M_counter_d = 1'h0;
        if (io_button[1+0-:1] == 1'h1) begin
          M_state_d = NORMAL_ADDITION_state;
        end
      end
      NORMAL_ADDITION_state: begin
        M_alu_alufn = 6'h00;
        M_alu_a = 8'h04;
        M_alu_b = 8'h06;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h04;
        io_led[8+7-:8] = 8'h06;
        M_seg_values = 16'hddda;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h0a && io_button[2+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = ADDITION_OVERFLOW_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h0a && io_button[2+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = ADDER_ERROR_state;
          end
        end
      end
      ADDITION_OVERFLOW_state: begin
        M_alu_alufn = 6'h00;
        M_alu_a = 8'h40;
        M_alu_b = 8'h40;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h40;
        io_led[8+7-:8] = 8'h40;
        M_seg_values = 16'hddda;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h80 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = NORMAL_SUBTRACTION_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h80 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = ADDER_ERROR_state;
          end
        end
      end
      NORMAL_SUBTRACTION_state: begin
        M_alu_alufn = 6'h01;
        M_alu_a = 8'h10;
        M_alu_b = 8'h08;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h10;
        io_led[8+7-:8] = 8'h08;
        M_seg_values = 16'hddda;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h08 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SUBTRACTION_OVERFLOW_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h08 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = ADDER_ERROR_state;
          end
        end
      end
      SUBTRACTION_OVERFLOW_state: begin
        M_alu_alufn = 6'h01;
        M_alu_a = 8'hbf;
        M_alu_b = 8'h40;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'hbf;
        io_led[8+7-:8] = 8'h40;
        M_seg_values = 16'hddda;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h7f && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = ZERO_SIGNAL_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h7f && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = ADDER_ERROR_state;
          end
        end
      end
      ZERO_SIGNAL_state: begin
        M_alu_a = 8'h00;
        M_alu_b = 8'h00;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h00;
        io_led[8+7-:8] = 8'h00;
        M_seg_values = 16'hddda;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h00 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = ADDER_ERROR_TEST_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h00 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = ADDER_ERROR_state;
          end
        end
      end
      ADDER_ERROR_TEST_state: begin
        M_alu_alufn = 6'h00;
        M_alu_a = 8'h04;
        M_alu_b = 8'h06;
        alu_output = M_alu_alu_output + 1'h1;
        io_led[0+7-:8] = 8'h04;
        io_led[8+7-:8] = 8'h06;
        M_seg_values = 16'hddda;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h0a && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = BOOLEAN_AND_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h0a && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = ADDER_ERROR_state;
          end
        end
      end
      ADDER_ERROR_state: begin
        M_seg_values = 16'hceea;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = BOOLEAN_AND_state;
        end
      end
      BOOLEAN_AND_state: begin
        M_alu_alufn = 6'h18;
        M_alu_a = 8'h93;
        M_alu_b = 8'he2;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'he2;
        M_seg_values = 16'hddd8;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h82 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = BOOLEAN_OR_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h82 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = BOOLEAN_ERROR_state;
          end
        end
      end
      BOOLEAN_OR_state: begin
        M_alu_alufn = 6'h1e;
        M_alu_a = 8'h93;
        M_alu_b = 8'he2;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'he2;
        M_seg_values = 16'hddd8;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'hf3 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = BOOLEAN_XOR_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'hf3 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = BOOLEAN_ERROR_state;
          end
        end
      end
      BOOLEAN_XOR_state: begin
        M_alu_alufn = 6'h16;
        M_alu_a = 8'h93;
        M_alu_b = 8'he2;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'he2;
        M_seg_values = 16'hddd8;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h71 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = BOOLEAN_A_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h71 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = BOOLEAN_ERROR_state;
          end
        end
      end
      BOOLEAN_A_state: begin
        M_alu_alufn = 6'h16;
        M_alu_a = 8'h93;
        M_alu_b = 8'he2;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'he2;
        M_seg_values = 16'hddd8;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h93 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SHIFT_LEFT_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h93 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = BOOLEAN_ERROR_state;
          end
        end
      end
      BOOLEAN_ERROR_TEST_state: begin
        M_alu_alufn = 6'h18;
        M_alu_a = 8'h93;
        M_alu_b = 8'h00;
        alu_output = M_alu_alu_output + 1'h1;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h00;
        M_seg_values = 16'hddd8;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h00 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SHIFT_LEFT_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h00 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = BOOLEAN_ERROR_state;
          end
        end
      end
      BOOLEAN_ERROR_state: begin
        M_seg_values = 16'hcee8;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SHIFT_LEFT_state;
        end
      end
      SHIFT_LEFT_state: begin
        M_alu_alufn = 6'h20;
        M_alu_a = 8'h0f;
        M_alu_b = 8'h04;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h0f;
        io_led[8+7-:8] = 8'h04;
        M_seg_values = 16'hddd5;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'hf0 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SHIFT_RIGHT_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'hf0 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = SHIFT_ERROR_state;
          end
        end
      end
      SHIFT_RIGHT_state: begin
        M_alu_alufn = 6'h21;
        M_alu_a = 8'hf0;
        M_alu_b = 8'h02;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'hf0;
        io_led[8+7-:8] = 8'h02;
        M_seg_values = 16'hddd5;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h3c && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = ARITHMETIC_SHIFT_RIGHT_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h3c && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = SHIFT_ERROR_state;
          end
        end
      end
      ARITHMETIC_SHIFT_RIGHT_state: begin
        M_alu_alufn = 6'h23;
        M_alu_a = 8'hb0;
        M_alu_b = 8'h02;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'hb0;
        io_led[8+7-:8] = 8'h02;
        M_seg_values = 16'hddd5;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'hec && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SHIFT_ERROR_TEST_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'hec && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = SHIFT_ERROR_state;
          end
        end
      end
      SHIFT_ERROR_TEST_state: begin
        M_alu_alufn = 6'h21;
        M_alu_a = 8'h68;
        M_alu_b = 8'h02;
        alu_output = M_alu_alu_output + 1'h1;
        io_led[0+7-:8] = 8'h68;
        io_led[8+7-:8] = 8'h02;
        M_seg_values = 16'hddd5;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h1a && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = SHIFT_ERROR_TEST_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h1a && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = SHIFT_ERROR_state;
          end
        end
      end
      SHIFT_ERROR_state: begin
        M_seg_values = 16'hcee5;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPEQT_state;
        end
      end
      COMPARE_CMPEQT_state: begin
        M_alu_alufn = 6'h33;
        M_alu_a = 8'h93;
        M_alu_b = 8'h93;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h93;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h01 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPEQF_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h01 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_CMPEQF_state: begin
        M_alu_alufn = 6'h33;
        M_alu_a = 8'h93;
        M_alu_b = 8'h92;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h92;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h00 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPLTT_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h00 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_CMPLTT_state: begin
        M_alu_alufn = 6'h35;
        M_alu_a = 8'h93;
        M_alu_b = 8'h97;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h97;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h01 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPLTF_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h01 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_CMPLTF_state: begin
        M_alu_alufn = 6'h35;
        M_alu_a = 8'h93;
        M_alu_b = 8'h92;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h92;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h00 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPLTETE_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h00 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_CMPLTETE_state: begin
        M_alu_alufn = 6'h37;
        M_alu_a = 8'h93;
        M_alu_b = 8'h93;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h93;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h01 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPLTETL_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h01 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_CMPLTETL_state: begin
        M_alu_alufn = 6'h37;
        M_alu_a = 8'h93;
        M_alu_b = 8'h97;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h97;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h01 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_CMPLEF_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h01 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_CMPLEF_state: begin
        M_alu_alufn = 6'h37;
        M_alu_a = 8'h93;
        M_alu_b = 8'h92;
        alu_output = M_alu_alu_output;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h92;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h00 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = COMPARE_ERROR_TEST_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h00 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_ERROR_TEST_state: begin
        M_alu_alufn = 6'h33;
        M_alu_a = 8'h93;
        M_alu_b = 8'h93;
        alu_output = M_alu_alu_output + 1'h1;
        io_led[0+7-:8] = 8'h93;
        io_led[8+7-:8] = 8'h93;
        M_seg_values = 16'hdddb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && alu_output == 8'h01 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = END_state;
        end else begin
          if (M_counter_q[28+0-:1] == 1'h1 && alu_output != 8'h01 && io_button[4+0-:1] == 1'h1) begin
            M_counter_d = 1'h0;
            M_state_d = COMPARE_ERROR_state;
          end
        end
      end
      COMPARE_ERROR_state: begin
        M_seg_values = 16'hceeb;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = END_state;
        end
      end
      END_state: begin
        M_seg_values = 16'hcf0d;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[28+0-:1] == 1'h1 && io_button[4+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          M_state_d = IDLE_state;
        end
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_counter_q <= 1'h0;
      M_state_q <= 1'h0;
    end else begin
      M_counter_q <= M_counter_d;
      M_state_q <= M_state_d;
    end
  end
  
endmodule