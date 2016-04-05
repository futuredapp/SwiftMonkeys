//
//  SwiftMonkeys.swift
//  SwiftMonkeys
//
//  Created by Jakub Knejzlik on 05/04/16.
//  Copyright © 2016 Funtasty Digital. All rights reserved.
//

import XCTest

enum SwiftMonkeyActionType: Int {
    case RotateDevice = 0
    case TapElement = 1
    static var count: Int { return SwiftMonkeyActionType.TapElement.rawValue + 1 }
}

private class SwiftMonkeyAction {
    
    typealias SwiftMonkeyActionBlock = (Void) -> Void
    
    let action: SwiftMonkeyActionBlock
    
    init(action: SwiftMonkeyActionBlock) {
        self.action = action
    }
    
    func run() {
        self.action()
    }
}

@available(iOS 9.0, *)
public class SwiftMonkeys {
    
    let app: XCUIApplication
    
    public init(app: XCUIApplication) {
        self.app = app
    }
    
    public func start(stepCount: Int = -1) {
        var stepsLeft = stepCount
        while true {
            let action = self.getRandomAction()
            if stepsLeft > 0 {
                stepsLeft = stepsLeft - 1
            }
            if action == nil || stepsLeft == 0 {
                break
            }
            action?.run()
        }
    }
    
    // MARK: - Element methods
    
    private func getRandomAction() -> SwiftMonkeyAction? {
        if let action = SwiftMonkeyActionType(rawValue: Int(arc4random_uniform(UInt32(SwiftMonkeyActionType.count)))) {
            switch action {
            case .RotateDevice:
                return SwiftMonkeyAction(action: { [unowned self] () in
                    XCUIDevice.sharedDevice().orientation = self.getRandomOrientation()
                    })
            case .TapElement:
                if let element = self.getRandomHittableElement() {
                    return SwiftMonkeyAction(action: { () in
                        element.tap()
                    })
                }
            }
        }
        return nil
    }
    
    private func getRandomOrientation() -> UIDeviceOrientation {
        switch XCUIDevice.sharedDevice().orientation {
        case .Portrait:
            return .LandscapeRight
        case .LandscapeRight:
            return .PortraitUpsideDown
        case .PortraitUpsideDown:
            return .LandscapeLeft
        default:
            return .Portrait
        }
    }
    
    private func getRandomHittableElement() -> XCUIElement? {
        if let elm = self.getRandomHittableElement(self.app.buttons) {
            return elm
        }
        if let elm = self.getRandomHittableElement(self.app.cells) {
            return elm
        }
        return nil
    }
    
    private func getRandomHittableElement(query: XCUIElementQuery) -> XCUIElement? {
        var hittableElements: [XCUIElement] = []
        
        for element in query.allElementsBoundByIndex {
            if element.hittable {
                hittableElements.append(element)
            }
        }
        
        let count = hittableElements.count
        if count == 0 {
            return nil
        }
        
        let rand = Int(arc4random_uniform(UInt32(count)))
        return hittableElements[rand]
    }
}