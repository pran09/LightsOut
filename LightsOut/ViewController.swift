//
//  ViewController.swift
//  LightsOut
//
//  Created by CSSE Department on 3/20/18.
//  Copyright © 2018 Praneet CSSE484. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameStateLabel: UILabel!
    @IBOutlet weak var gameStateNavBar: UINavigationBar!
    @IBOutlet var gameButtons: [UIButton]!

    var game = LinearLightsOut(numLights: 13)
    var solved: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStateNavBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        solved = false
        randomizeGameBoard()
        gameStateLabel.text = "Turn all the lights off!"
        gameStateNavBar.topItem?.title = "Turn all the lights off!"
        updateView()
    }

    @IBAction func pressedNewGame(_ sender: Any) {
        game = LinearLightsOut(numLights: 13)
        viewDidLoad()
    }
    
    @IBAction func pressedGameButton(_ sender: Any) {
        if !solved {
            let gameBoardButton = sender as! UIButton
            print(gameBoardButton.tag)
			if(!game!.pressedLight(at: gameBoardButton.tag)){ //if game is not solved yet
                updateView()
                var allOff: Bool = true
                for i in 0..<13{
                    let thisButtonImage = gameButtons[i].backgroundImage(for: UIControlState.normal)
                    if(thisButtonImage == #imageLiteral(resourceName: "light_on")){
                        allOff = false
                    }
                }
                if (allOff){
                    solved = true
                    displayWin()
                }
            } else {
                solved = true;
                if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact) {
                    gameStateLabel.text = "You win! Total moves: \(game!.movesTaken)"
                } else {
                    gameStateNavBar.topItem?.title = "You win! Total moves: \(game!.movesTaken)"
                }
            }
        }
    }
    
    func displayWin() {
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact) {
            gameStateLabel.text = "You win! Total moves: \(game!.movesTaken)"
        } else {
            gameStateNavBar.topItem?.title = "You win! Total moves: \(game!.movesTaken)"
        }
    }
    
    func updateView() {
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact) {
            gameStateLabel.text = "Moves: \(game!.movesTaken)"
        } else {
            gameStateNavBar.topItem?.title = "Moves: \(game!.movesTaken)"
        }
        for i in 0..<13 {
            let button = gameButtons[i]
			
            if game!.getLightStates(i) {
                button.setBackgroundImage(#imageLiteral(resourceName: "light_off"), for: UIControlState.normal)
			}
			else {
				button.setBackgroundImage(#imageLiteral(resourceName: "light_on"), for: UIControlState.normal)
			}
        }
    }
    
    func randomizeGameBoard() {
        for i in 0..<13 {
            let number = arc4random_uniform(2)
            let doubleNumber = Double(number)
            if(doubleNumber < 0.5){
                gameButtons[i].setBackgroundImage(#imageLiteral(resourceName: "light_off"), for: UIControlState.normal)
            } else {
                gameButtons[i].setBackgroundImage(#imageLiteral(resourceName: "light_on"), for: UIControlState.normal)
            }
        }
    }
}


