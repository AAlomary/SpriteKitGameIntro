//
//  GameScene.swift
//  SpritekitIntro
//
//  Created by Ahmad Alomary on 05/12/2016.
//  Copyright © 2016 Ahmad Alomary. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var cannon:SKSpriteNode!
    var touchLocation:CGPoint = CGPoint.zero
	var myLabel:SKLabelNode!
	var ball:SKSpriteNode!
    
    
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
   
    override func didMove(to view: SKView) {
        cannon = self.childNode(withName: "cannon_full") as! SKSpriteNode
		//ball = self.childNode(withName: "ball") as! SKSpriteNode
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		touchLocation = touches.first!.location(in: self)
		
		//ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		let ball:SKSpriteNode = SKScene(fileNamed: "Ball")!.childNode(withName: "ball")! as! SKSpriteNode
		ball.removeFromParent()
		self.addChild(ball)
		ball.zPosition = 0
		ball.position = cannon.position
		let angleInRadians = Float(cannon.zRotation)
		let speed = CGFloat(10.0)
		let vx:CGFloat = CGFloat(cosf(angleInRadians)) * speed
		let vy:CGFloat = CGFloat(sinf(angleInRadians)) * speed
		ball.physicsBody?.applyImpulse(CGVector(dx: vx, dy: vy))
	}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		//to remove an obkect call the object and remove from parent 
		//myLabel.removeFromParent()
        touchLocation = touches.first!.location(in: self)
		
	}
	
	override func update(_ currentTime: TimeInterval) {
		let percent = touchLocation.x / size.width
		let newAngle = percent * 180 - 90
		cannon.zRotation = CGFloat(newAngle) * CGFloat(M_PI) / 180
		//ball.physicsBody?.applyForce(CGVector(dx: 0, dy: 25))
	}
}
