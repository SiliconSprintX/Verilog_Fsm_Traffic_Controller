module traffic_light_controller (
    input  wire clk,
    input  wire rst,

    output reg red,
    output reg yellow,
    output reg green
);

 
    // State Encoding
 

    localparam RED    = 2'b00;
    localparam GREEN  = 2'b01;
    localparam YELLOW = 2'b10;

    // Current state and next state
    reg [1:0] state;
    reg [1:0] next_state;


    // Counter
    

    reg [3:0] count;

    // Number of clock cycles for each light
    localparam RED_TIME    = 5;
    localparam GREEN_TIME  = 5;
    localparam YELLOW_TIME = 2;

  
    // 1. STATE REGISTER AND COUNTER

    //
    // This block is sequential.
    // It executes on every positive edge of clk.
    //
    // Reset:
    //     state = RED
    //     count = 0
    //
    // Normal operation:
    //     state changes to next_state
    //     counter increments
    

    always @(posedge clk or posedge rst) begin

        if (rst) begin

            state <= RED;
            count <= 4'd0;

        end
        else begin

            // Update state
            state <= next_state;

            // Reset counter whenever state changes
            if (state != next_state) begin
                count <= 4'd0;
            end
            else begin
                count <= count + 1'b1;
            end

        end

    end

    
    // 2. NEXT STATE LOGIC
    
    //
    // This is combinational logic.
    //
    // RED    -> GREEN after RED_TIME clocks
    // GREEN  -> YELLOW after GREEN_TIME clocks
    // YELLOW -> RED after YELLOW_TIME clocks
    //
  

    always @(*) begin

        // Default condition
        next_state = state;

        case (state)

         
            // RED STATE
        

            RED: begin

                if (count >= RED_TIME - 1) begin
                    next_state = GREEN;
                end
                else begin
                    next_state = RED;
                end

            end

          
            // GREEN STATE
            

            GREEN: begin

                if (count >= GREEN_TIME - 1) begin
                    next_state = YELLOW;
                end
                else begin
                    next_state = GREEN;
                end

            end

        
            // YELLOW STATE
          

            YELLOW: begin

                if (count >= YELLOW_TIME - 1) begin
                    next_state = RED;
                end
                else begin
                    next_state = YELLOW;
                end

            end

            // DEFAULT STATE
            

            default: begin
                next_state = RED;
            end

        endcase

    end

    //========================================================
    // 3. OUTPUT LOGIC
    //========================================================
    //
    // Only one light is ON at a time.
    //
    // RED state:
    //     red = 1
    //
    // GREEN state:
    //     green = 1
    //
    // YELLOW state:
    //     yellow = 1
    //
    //========================================================

    always @(*) begin

        // Default values
        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;

        case (state)

         
            // RED
            

            RED: begin
                red = 1'b1;
            end

         
            // GREEN
         

            GREEN: begin
                green = 1'b1;
            end

          
            // YELLOW
          

            YELLOW: begin
                yellow = 1'b1;
            end

          
            // DEFAULT
           

            default: begin
                red = 1'b1;
            end

        endcase

    end

endmodule
