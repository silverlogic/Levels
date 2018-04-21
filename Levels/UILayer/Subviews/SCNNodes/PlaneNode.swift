//
//  PlaneNode.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

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
        let material = SCNMaterial()
        material.diffuse.contents = color
        let transparentMaterial = SCNMaterial()
        transparentMaterial.diffuse.contents = [UIColor.init(white: 1.0, alpha: 0.0)]
        self.planeGeometry.materials = [material,transparentMaterial,transparentMaterial,transparentMaterial,transparentMaterial,transparentMaterial]
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, anchor.center.y, anchor.center.z);
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0);
        self.addChildNode(planeNode)
    }
}
