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

final class WaterNode: SCNNode {
    
    // MARK: - Public Instance Methods
    var anchor: ARPlaneAnchor
    var boxGeometry: SCNBox!
    var floodLevel: CGFloat = 0 {
        didSet {
            updateBoxHeight()
        }
    }
    
    
    // MARK: - Initializers
    init(anchor :ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Public Instance Methods
extension WaterNode {
    func update(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        boxGeometry.width = CGFloat(anchor.extent.x)
        updateBoxHeight()
        boxGeometry.length = CGFloat(anchor.extent.z)
        self.position = SCNVector3Make(anchor.center.x, anchor.center.y, anchor.center.z);
    }
}


// MARK: - Private Instance Methods
private extension WaterNode {
    func setup() {
        boxGeometry = SCNBox(width: CGFloat(self.anchor.extent.x), height: 0, length: CGFloat(self.anchor.extent.z), chamferRadius: 0)
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
        boxGeometry.materials = [material]
        let planeNode = SCNNode(geometry: self.boxGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, anchor.center.y, anchor.center.z);
        self.addChildNode(planeNode)
    }
    
    func updateBoxHeight() {
        //SCNTransaction.animationDuration = 1.0
        boxGeometry.height = 0.0435 * floodLevel
    }
}
