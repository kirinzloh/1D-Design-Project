/*
   This file was generated automatically by the Mojo IDE version B1.3.4.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module boolean_mod_9 (
    input [5:0] alufn,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] boole_output
  );
  
  
  
  always @* begin
    
    case (alufn[0+3-:4])
      4'h8: begin
        boole_output[0+7-:8] = a[0+7-:8] & b[0+7-:8];
      end
      4'he: begin
        boole_output[0+7-:8] = a[0+7-:8] | b[0+7-:8];
      end
      4'h6: begin
        boole_output[0+7-:8] = a[0+7-:8] ^ b[0+7-:8];
      end
      4'ha: begin
        boole_output[0+7-:8] = a[0+7-:8];
      end
      default: begin
        boole_output[0+7-:8] = a[0+7-:8];
      end
    endcase
  end
endmodule
