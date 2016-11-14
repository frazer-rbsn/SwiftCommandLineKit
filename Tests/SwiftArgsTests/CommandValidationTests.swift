//
//  CommandValidationTests.swift
//  SwiftArgs
//
//  Created by Frazer Robinson on 10/11/2016.
//
//

import XCTest
@testable import SwiftArgs

class CommandValidationTests: XCTestCase {
    
    
    // MARK: Valid scenarios
    
    func testAddValidCommand() {
        let cmd = MockCommandWithOptions(name: "mockcommandFOO", helptext: "Blah blah!",
                              options: [MockOption(), MockOptionWithArgument()], arguments: [MockArgument()])
        let parser = CommandParser()
        try! parser.addCommand(cmd)
        XCTAssert(parser.commands.contains(where: { $0 == cmd }))
    }
    
    func testAddValidCommandWithTwoOptions() {
        let cmd = MockCommandWithOptions(name: "mockcommand", helptext: "Blah blah!",
                              options: [MockOption(name:"op1"),
                                        MockOption(name:"op2")])
        let parser = CommandParser()
        try! parser.addCommand(cmd)
        XCTAssert(parser.commands.contains(where: { $0 == cmd }))
    }
    
    func testAddValidCommandWithTwoArgs() {
        let cmd = MockCommand(name: "mockcommand", helptext: "Blah blah!",
                              arguments: [MockArgument(name:"mockarg1"), MockArgument(name:"mockarg2")])
        let parser = CommandParser()
        try! parser.addCommand(cmd)
        XCTAssert(parser.commands.contains(where: { $0 == cmd }))
    }
    
    func testAddValidCommandWithOneOptionAndOneOptionWithArgAndOneArg() {
        let cmd = MockCommandWithOptions(name: "mockcommand", helptext: "Blah blah!",
                              options: [MockOption(name:"op"),
                                        MockOptionWithArgument(name:"opwitharg")],
                                      arguments: [MockArgument(name:"mockarg")])
        let parser = CommandParser()
        try! parser.addCommand(cmd)
        XCTAssert(parser.commands.contains(where: { $0 == cmd }))
    }
    
    
    // MARK: Invalid scenarios
    
    func testAddCommandNameWithSpaceThrows() {
        let cmd = MockCommand(name: "gener ate")
        let parser = CommandParser()
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testAddEmptyCommandNameThrows() {
        let cmd = MockCommand(name: "")
        let parser = CommandParser()
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testDuplicateCommandNameThrows() {
        let cmd1 = MockCommand(name: "generate")
        let cmd2 = MockCommand(name: "generate")
        let parser = CommandParser()
        try! parser.addCommand(cmd1)
        AssertThrows(expectedError: ParserError.duplicateCommand,
                     try parser.addCommand(cmd2))
    }
    
    func testEmptyOptionNameThrows() {
        let parser = CommandParser()
        let op1 = MockOption(name:"")
        let cmd = MockCommandWithOptions(options: [op1])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testEmptyArgumentNameThrows() {
        let parser = CommandParser()
        let arg1 = MockArgument(name:"")
        let cmd = MockCommand(arguments: [arg1])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testDuplicateOptionNamesThrows() {
        let parser = CommandParser()
        let op1 = MockOption(name:"option")
        let op2 = MockOption(name:"option")
        let cmd = MockCommandWithOptions(options: [op1, op2])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testDuplicateArgumentNamesThrows() {
        let parser = CommandParser()
        let arg1 = MockArgument(name:"arg")
        let arg2 = MockArgument(name:"arg")
        let cmd = MockCommand(arguments: [arg1, arg2])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testOptionNameWithSpaceThrows() {
        let parser = CommandParser()
        let op1 = MockOption(name:"op tion")
        let cmd = MockCommandWithOptions(options: [op1])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testArgumentNameWithSpaceThrows() {
        let parser = CommandParser()
        let arg1 = MockArgument(name:"arg ument")
        let cmd = MockCommand(arguments: [arg1])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testOptionNameWithHyphenThrows() {
        let parser = CommandParser()
        let op1 = MockOption(name:"op-tion")
        let cmd = MockCommandWithOptions(options: [op1])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
    
    func testArgumentNameWithHyphenThrows() {
        let parser = CommandParser()
        let arg1 = MockArgument(name:"arg-ument")
        let cmd = MockCommand(arguments: [arg1])
        AssertThrows(expectedError:  CommandModelError.invalidCommand,
                     try parser.addCommand(cmd))
    }
}