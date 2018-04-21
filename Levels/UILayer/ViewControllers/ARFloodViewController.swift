//
//  ViewController.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AlertTransition

class ARFloodViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var sceneView: ARSCNView!

    
    // Private Instance Attributes For AR
    private weak var lightNode: SCNNode!
    private weak var cameraLightNode: SCNNode!
    private var arSession: ARSession! {
        return sceneView?.session
    }
    private var groundPlaneNodes: [WaterNode] = []
    private var buildingPlaneNodes: [WaterNode] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupARSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}


// MARK: - Public Instance Methods
extension ARFloodViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.at.transition = TrolleyTransition()
    }
}


// MARK: - ARSCNViewDelegate
extension ARFloodViewController: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("Error with session: \(error)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("Session has been interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("Need reset")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        if planeAnchor.alignment == .horizontal {
            let plane = WaterNode(anchor: planeAnchor, color: UIColor(red: CGFloat(arc4random() % 255) / 255.0, green: 0.7, blue: 0.7, alpha: 1.0))
            groundPlaneNodes.append(plane)
            node.addChildNode(plane)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        if planeAnchor.alignment == .horizontal {
            guard let groundPlaneNode = groundPlaneNodes.first(where: { (node) -> Bool in
                return node.anchor.identifier == planeAnchor.identifier
            }) else { return }
            print("Update: \(planeAnchor.extent) UUID: \(planeAnchor.identifier)")
            groundPlaneNode.update(anchor: planeAnchor)
        }
    }
}


// MARK: - Private Instance Methods
private extension ARFloodViewController {
    func setupScene() {
        sceneView.delegate = self
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    func setupARSession() {
        sceneView.session = ARSession()
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        configuration.planeDetection = [.horizontal, .vertical]
        arSession.run(configuration)
    }

    func showCalculatorPanel() {

    }
}
