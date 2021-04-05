//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code

/*:
# **START**
 
 GOAL: Using the Command, Drop the Box.
 
 1.Find the position What you want.
 
 2.Input **DropBox(to:)** to drop the box
 
 3.Press Play Button
 
 */
import UIKit
import BookCore
import PlaygroundSupport
import SpriteKit
let controller = GameViewController()
// Instantiate a new instance of the live view from BookCore and pass it to PlaygroundSupport.
PlaygroundPage.current.liveView = controller
PlaygroundPage.current.needsIndefiniteExecution = true

let str = "Hello, playground"
