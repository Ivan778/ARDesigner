//
//  ARDesignerConverterCheckFolderTests.swift
//  ARDesignerConverterCheckFolderTests
//
//  Created by Иван on 03.04.2018.
//  Copyright © 2018 Ivan. All rights reserved.
//

import XCTest
@testable import ARDesignerConverter

class ARDesignerConverterCheckFolderTests: XCTestCase {
    let logic = SyncLogic()
    
    let pathToFolderWithTestModels = (Bundle.main.resourceURL?.appendingPathComponent("TestInput"))!
    let desktopFolder = URL(fileURLWithPath: DesktopFolder.outDirectory())
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testModelWithTextures1() {
        XCTAssertTrue(logic.checkFolder(url: pathToFolderWithTestModels.appendingPathComponent("ModelWithTexture1")))
    }
    
    func testWithoutTextures1() {
        XCTAssertTrue(logic.checkFolder(url: pathToFolderWithTestModels.appendingPathComponent("ModelWithoutTexture1")))
    }
    
    func testModelWithTextures2() {
        XCTAssertTrue(logic.checkFolder(url: pathToFolderWithTestModels.appendingPathComponent("ModelWithTexture2")))
    }
    
    func testWithoutTextures2() {
        XCTAssertTrue(logic.checkFolder(url: pathToFolderWithTestModels.appendingPathComponent("ModelWithoutTexture2")))
    }
    
    func testAllInRoot() {
        XCTAssertFalse(logic.checkFolder(url: pathToFolderWithTestModels.appendingPathComponent("AllInRoot")))
    }
    
    func testTwoDAE() {
        XCTAssertFalse(logic.checkFolder(url: pathToFolderWithTestModels.appendingPathComponent("TwoDAE")))
    }
    
}
