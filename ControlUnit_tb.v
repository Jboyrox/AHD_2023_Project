`timescale 1ns / 1ps

module ControlUnitTestbench;
    reg clk;
    reg programCounterUpdated, instructionFetched;
    reg registerWrite, branchTaken, haltExecution;
    reg memoryWrite, memoryRead;
    reg decodeComplete, writeBackComplete;
    wire startDecode, programCounterWrite;
    wire startInstructionFetch, startWriteBack;

    // Instantiate the ControlUnit module
    ControlUnit controlUnit(
        .clk(clk),
        .programCounterUpdated(programCounterUpdated),
        .instructionFetched(instructionFetched),
        .registerWrite(registerWrite),
        .branchTaken(branchTaken),
        .haltExecution(haltExecution),
        .memoryWrite(memoryWrite),
        .memoryRead(memoryRead),
        .decodeComplete(decodeComplete),
        .writeBackComplete(writeBackComplete),
        .startDecode(startDecode),
        .programCounterWrite(programCounterWrite),
        .startInstructionFetch(startInstructionFetch),
        .startWriteBack(startWriteBack)
    );

    // Initialize a variable to track test status
    integer testFailures = 0;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Check test result
    task checkTestResult;
        input reg expected, actual;
        input reg [127:0] testName;
        begin
            if (expected !== actual) begin
                $display("Test %s failed: Expected %b, got %b", testName, expected, actual);
                testFailures = testFailures + 1;
            end
            else
                $display("Test %s passed", testName);
        end
    endtask

    // Test scenario
    initial begin
        // Initialize inputs
        programCounterUpdated = 0;
        instructionFetched = 0;
        registerWrite = 0;
        branchTaken = 0;
        haltExecution = 0;
        memoryWrite = 0;
        memoryRead = 0;
        decodeComplete = 0;
        writeBackComplete = 0;

        #10;

        // Test instruction fetch
        instructionFetched = 1;  
        #10;
        checkTestResult(1'b0, startInstructionFetch, "Instruction Fetch");
        instructionFetched = 0;

        // Test instruction decode
        decodeComplete = 1;      
        #10;
        checkTestResult(1'b0, startDecode, "Instruction Decode");
        decodeComplete = 0;

        // Test write back
        writeBackComplete = 1;   
        #10;
        checkTestResult(1'b0, startWriteBack, "Write Back");
        writeBackComplete = 0;

        // Test program counter update
        programCounterUpdated = 1;
        #10;
        checkTestResult(1'b0, programCounterWrite, "Program Counter Update");
        programCounterUpdated = 0;

        // Test halt execution
        haltExecution = 1;
        #10;
        checkTestResult(1'b0, startInstructionFetch, "Halt Execution");
        haltExecution = 0;

        // Check if any tests failed
        if (testFailures == 0)
            $display("All tests passed successfully.");
        else
            $display("%d test(s) failed.", testFailures);

        // Terminate the simulation
        $finish;
    end
endmodule
