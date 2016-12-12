//
//  MainMenu.swift
//  SpritekitIntro
//
//  Created by Ahmad Alomary on 12/12/2016.
//  Copyright © 2016 Ahmad Alomary. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let game:GameScene = GameScene(fileNamed: "GameScene")!
		game.scaleMode = .aspectFill
		
		//let transition:SKTransition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
		//let transition1:SKTransition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
		let transition2:SKTransition = SKTransition.doorway(withDuration: 1.0)
		//let transition3:SKTransition = SKTransition.flipHorizontal(withDuration: 1.0)
		
		
		self.view?.presentScene(game, transition: transition2)
		
	}
}
