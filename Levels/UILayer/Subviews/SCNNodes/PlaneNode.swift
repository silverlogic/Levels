//
//  PlaneNode.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import QuartzCore
import Foundation
import SceneKit
import ARKit

final class PlaneNode: SCNNode {
    
    // MARK: - Public Instance Methods
    var anchor :ARPlaneAnchor
    var planeGeometry :SCNPlane!
    
    
    // MARK: - Initializers
    init(anchor :ARPlaneAnchor, color: UIColor) {
        self.anchor = anchor
        super.init()
        setup(color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Public Instance Methods
extension PlaneNode {
    func update(anchor :ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.extent.x);
        self.planeGeometry.height = CGFloat(anchor.extent.z);
        self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
    }
}


// MARK: - Private Instance Methods
extension PlaneNode {
    private func setup(color: UIColor) {
        self.planeGeometry = SCNPlane(width: CGFloat(self.anchor.extent.x), height: CGFloat(self.anchor.extent.z))
        var frames: [SKTexture] = []
        for i in 0...9 {
            frames.append(SKTexture(imageNamed: "frame_0\(i)_delay-0.1s"))
        }
        let waterSpriteNode = SKSpriteNode(texture: frames[0])
        waterSpriteNode.position = CGPoint(x: waterSpriteNode.size.width / 2, y: waterSpriteNode.size.height / 2)
        let runAction = SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.1))
        waterSpriteNode.run(runAction)
        let waterScene = SKScene(size: waterSpriteNode.size)
        waterScene.backgroundColor = .clear
        waterScene.addChild(waterSpriteNode)
        let material = SCNMaterial()
        material.transparency = 0.85
        material.diffuse.contents = waterScene
        self.planeGeometry.materials = [material]
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, anchor.center.y, anchor.center.z);
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0);
        self.addChildNode(planeNode)
    }
}
