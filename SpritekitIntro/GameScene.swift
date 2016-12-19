//
//  GameScene.swift
//  SpritekitIntro
//
//  Created by Ahmad Alomary on 05/12/2016.
//  Copyright © 2016 Ahmad Alomary. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var cannon:SKSpriteNode!
    var touchLocation:CGPoint = CGPoint.zero
	var myLabel:SKLabelNode!
	var ball:SKSpriteNode!
	let wallMask:UInt32 = 0x1 << 0 //1
	let ballMask:UInt32 = 0x1 << 1 //2
	let pegMask:UInt32 = 0x1 << 2 //4
	let squareMask:UInt32 = 0x1 << 3 //8
	let orangePegMask:UInt32 = 0x1 << 4 //16
    
    
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
   
    override func didMove(to view: SKView) {
        cannon = self.childNode(withName: "cannon_full") as! SKSpriteNode
		//ball = self.childNode(withName: "ball") as! SKSpriteNode
		
		self.physicsWorld.contactDelegate = self
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
		
		ball.physicsBody?.collisionBitMask = wallMask | ballMask | pegMask | orangePegMask
		ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask | squareMask
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
	
	func didBegin(_ contact: SKPhysicsContact) {
		let ball = (contact.bodyA.categoryBitMask == ballMask) ? contact.bodyA : contact.bodyB
		let other = (ball == contact.bodyA) ? contact.bodyB : contact.bodyA
		if other.categoryBitMask == pegMask || other.categoryBitMask == orangePegMask{
			self.didHitPeg(peg: other)
		}
		else if other.categoryBitMask == squareMask{
			print("hit square")
		}
		else if other.categoryBitMask == wallMask{
			print("hit wall")
		}
		else if other.categoryBitMask == ballMask{
			print("hit ball")
		}
	}
	
	func didHitPeg(peg: SKPhysicsBody){
		//let blue = UIColor(colorLiteralRed: 0.16, green: 0.73, blue: 0.78, alpha: 1.0)
		//let orange = UIColor(colorLiteralRed: 1.0, green: 0.45, blue: 0.0, alpha: 1.0)
		
		let spark:SKEmitterNode = SKEmitterNode(fileNamed: "Fire")!
		spark.position = peg.node!.position
		//if(peg.categoryBitMask == orangePegMask){
		//	spark.particleColor = orange
		//}
		self.addChild(spark)
		peg.node?.removeFromParent()
	}
}
