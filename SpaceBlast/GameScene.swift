//
//  GameScene.swift
//  SpaceBlast
//
//  Created by Bobby Towers on 2/9/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

/*
- add asteroids to the moon as child, outside the moons radius... they should have a physics body
+ add health points to ship (health = 100)
- listen for collision with ship... ship looses 20 health, if health = 0... ship explodes
*/

import SpriteKit

class Spaceship: SKSpriteNode {
    
    var health = 100
    
//    Spaceship.physicsBody = SKPhysicsBody(rectangleOfSize: Spaceship.size)
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var screenCenter: CGPoint!
    
    let ship = Spaceship(imageNamed: "spaceship")
    
    override func didMoveToView(view: SKView) {

        screenCenter = view.center
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        createMoon()
        
        createShip()
        
        // add gestures up and down to move ship
        
        // make sound "pfft"
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            // shoot ship beams
            
            // make sound "pew, pew"
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if ship.health <= 0 {
            ship.removeFromParent()
        }
    }
    
    func createShip() {
    
        ship.position = screenCenter
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.size)
//        ship.physicsBody.categoryBitMask = PhysicsCategory.Spaceship
//        ship.physicsBody.contactTestBitMask = PhysicsCategory.Asteroid
        self.addChild(ship)
        
    }
    
    func createMoon() {
        
        let moon = SKShapeNode(ellipseOfSize: CGSizeMake(500, 500))
        
        moon.strokeColor = SKColor.clearColor()
        moon.fillColor = SKColor(white: 0.9, alpha: 1.0)
        moon.position = CGPointMake(screenCenter.x, -350)
        moon.xScale = 2.5
        moon.yScale = 2.5
        
        self.addChild(moon)
        
        // array of tuples
        let craters: [(CGPoint, CGFloat)] = [
            
            // position in a tuple, and then size
            (CGPointMake(40, 50), 50),
            (CGPointMake(180, 100), 30),
            (CGPointMake(100, -50), 20),
            (CGPointMake(120, -80), 10),
            (CGPointMake(-40, -150), 10),
            (CGPointMake(-140, -100), 45),
            (CGPointMake(-180, -50), 38),
            (CGPointMake(-10, -50), 20)
            
        ]
        
        for (p, s) in craters {
            
            let crater = SKShapeNode(ellipseOfSize: CGSizeMake(s, s))
            crater.fillColor = SKColor(white: 0.8, alpha: 1.0)
            crater.position = p
            
            moon.addChild(crater)
            
        }
        
        // our asteroids
        let asteroids: [(CGPoint, CGFloat)] = [
            
            (CGPointMake(300, 300), 60),
            (CGPointMake(350, 120), 30),
            (CGPointMake(-270, 283), 40),
            (CGPointMake(-150, 320), 20),
            (CGPointMake(100, 260), 10),
//            (CGPointMake(300, 300), 60),
//            (CGPointMake(300, 300), 60),
//            (CGPointMake(300, 300), 60),
//            (CGPointMake(300, 300), 60),
            
        
        ]
        
        for (p, s) in asteroids {
            
            let asteroid = SKShapeNode(ellipseOfSize: CGSizeMake(s, s))
            asteroid.fillColor = SKColor(white: 0.8, alpha: 1.0)
            asteroid.position = p
            
//            asteroid.physicsBody = SKPhysicsBody(rectangleOfSize: asteroid.size)
//            asteroid.physicsBody.categoryBitMask = PhysicsCategory.Asteroid
//            asteroid.physicsBody.contactTestBitMask = PhysicsCategory.Spaceship
            
            
            moon.addChild(asteroid)
        }
        
        
        // moon rotation action
        let moonRotation = SKAction.rotateByAngle(CGFloat(M_PI), duration: 20)
        moon.runAction(SKAction.repeatActionForever(moonRotation))

    }
}
