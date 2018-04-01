//
//  LinearLightsOut.swift
//  LightsOut
//
//  Created by Praneet Chakraborty on 3/20/18.
//  Copyright © 2018 Praneet CSSE484. All rights reserved.
//

import Foundation

import UIKit
class LinearLightsOutGame: CustomStringConvertible {
    var lightStates: [Bool]
    var moves: Int
    private var solved: Bool
    
    init(numLights: Int) {
        self.moves = 0
        self.solved = false
        self.lightStates = [Bool](repeating: true, count: numLights)
        for i in 0..<numLights {
            let n = Int(arc4random_uniform(2))
            if n == 0 {
                self.lightStates[i] = true
            }
            else {
                self.lightStates[i] = false
            }
        }
    }
    
    var description: String {
        var lightString: String = ""
        for i in 0..<lightStates.count {
            if lightStates[i] {
                lightString += "1"
            }
            else {
                lightString += "0"
            }
        }
        return "Lights: \(lightString) Moves: \(moves)"
    }
    
    func pressedLightAtIndex(_ index: Int) -> Bool{
        if !solved {
            moves += 1
            if lightStates[index] { //if selected light has true/on light
                lightStates[index] = false
                flipLights(index)
            }
            else { //if selected light has false/off light
                lightStates[index] = true
                flipLights(index)
            }
            for i in 0..<lightStates.count {
                if lightStates[i] {
                    return false;
                }
            }
            solved = true
            return true;
        }
        return true
    }
    
    private func flipLights(_ index: Int) {
        if index == 0 { //flips second light if first light is flipped
            if lightStates[1] {
                lightStates[1] = false
            }
            else {
                lightStates[1] = true
            }
        }
        else if index == lightStates.count-1 { //flips second to last light if last light is flipped
            if lightStates[lightStates.count-2] {
                lightStates[lightStates.count-2] = false
            }
            else {
                lightStates[lightStates.count-2] = true
            }
        }
        else { //if any middle light is selected
            if lightStates[index+1] { //takes care of one directly after
                lightStates[index+1] = false
            }
            else {
                lightStates[index+1] = true
            }
            
            if lightStates[index-1] { //takes care of one directly before
                lightStates[index-1] = false
            }
            else {
                lightStates[index-1] = true
            }
        }
    }
}
