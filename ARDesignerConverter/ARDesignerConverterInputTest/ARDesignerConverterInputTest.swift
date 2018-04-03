//
//  ARDesignerConverterInputTest.swift
//  ARDesignerConverterInputTest
//
//  Created by Иван on 02.04.2018.
//  Copyright © 2018 Ivan. All rights reserved.
//

import XCTest
@testable import ARDesignerConverter

class ARDesignerConverterInputTest: XCTestCase {
    let logic = SyncLogic()
    
    let pathToFolderWithTestModels = (Bundle.main.resourceURL?.appendingPathComponent("TestInput"))!
    let desktopFolder = URL(fileURLWithPath: DesktopFolder.outDirectory())
    
    var foldersArray1 = [String]()
    var foldersArray2 = [String]()
    var foldersArray3 = [String]()
    var foldersArray4 = [String]()
    var foldersArray5 = [String]()
    var foldersArray6 = [String]()
    
    override func setUp() {
        super.setUp()
        createDirectory()
        
        // Creating arrays with URLs
        foldersArray1 = ["ModelWithTexture1"]
        foldersArray2 = ["ModelWithoutTexture1"]
        foldersArray3 = ["ModelWithoutTexture1", "ModelWithTexture1", "ModelWithTexture2"]
        foldersArray4 = ["TwoDAE"]
        foldersArray5 = ["AllInRoot"]
        foldersArray6 = ["ModelWithTexture1", "ModelWithoutTexture1", "ModelWithTexture2", "TwoDAE", "AllInRoot"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // 1
    func testModelWithFolderContainingTextures() {
        logic.runCycle(urls: URLs(names: foldersArray1))
        XCTAssertEqual(appendARD(names: foldersArray1), contentsOfDirectory())
    }
    
    // 2
    func testModelWithoutFolderContainingTextures() {
        logic.runCycle(urls: URLs(names: foldersArray2))
        XCTAssertEqual(appendARD(names: foldersArray2), contentsOfDirectory())
    }
    
    // 3
    func testSeveralCorrectFolders() {
        logic.runCycle(urls: URLs(names: foldersArray3))
        XCTAssertEqual(appendARD(names: foldersArray3), contentsOfDirectory())
    }
    
    // 4
    func testTwoDAE() {
        logic.runCycle(urls: URLs(names: foldersArray4))
        XCTAssertNotEqual(appendARD(names: foldersArray4), contentsOfDirectory())
    }
    
    // 5
    func testAllInRoot() {
        logic.runCycle(urls: URLs(names: foldersArray5))
        XCTAssertNotEqual(appendARD(names: foldersArray5), contentsOfDirectory())
    }
    
    // 6
    func testSeveralRightAndSeveralWrong() {
        logic.runCycle(urls: URLs(names: foldersArray6))
        XCTAssertNotEqual(appendARD(names: foldersArray6), contentsOfDirectory())
    }
    
}

extension ARDesignerConverterInputTest {
    func createDirectory() {
        do {
            try FileManager.default.removeItem(atPath: DesktopFolder.outDirectory())
        } catch {
            print("Error")
        }
        
        do {
            try FileManager.default.createDirectory(atPath: DesktopFolder.outDirectory(), withIntermediateDirectories: false, attributes: nil)
        } catch {
            print("Error")
        }
        
    }
    
    func URLs(names: [String]) -> [URL] {
        var array = [URL]()
        for name in names {
            let path = pathToFolderWithTestModels.appendingPathComponent(name)
            array.append(path)
        }
        
        return array
    }
    
    func appendARD(names: [String]) -> [String] {
        var array = [String]()
        for name in names {
            array.append("\(name).ARD")
        }
        
        return array
    }
    
    func contentsOfDirectory() -> [String] {
        do {
            let out = try FileManager.default.contentsOfDirectory(atPath: DesktopFolder.outDirectory())
            createDirectory()
            return out
        } catch {
            createDirectory()
            return [String]()
        }
    }
}
