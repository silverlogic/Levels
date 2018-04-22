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
import VerticalSteppedSlider

final class ARFloodViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var sceneView: ARSCNView!
    @IBOutlet private weak var surgeLevelSlider: VSSlider!
    @IBOutlet private weak var surgeLevelLabel: UILabel!

    
    // Private Instance Attributes For AR
    private weak var lightNode: SCNNode!
    private weak var cameraLightNode: SCNNode!
    private var arSession: ARSession! {
        return sceneView?.session
    }
    private var groundPlaneNodes: [WaterNode] = []
    private let cloudinary = Cloudinary()
    
    
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


// MARK: - Navigation
extension ARFloodViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? SandbagCalculatorViewController else { return }
        controller.surgeHeight = Double(surgeLevelSlider.value)
        controller.at.transition = TrolleyTransition()
        controller.shareImageClosure = { [weak self] (info) in
            guard let strongSelf = self else { return }
            guard let view = UIApplication.shared.keyWindow else { return }
            let screenshot = view.asImage(0.0, afterScreenUpdates: false)
            guard let data = UIImageJPEGRepresentation(screenshot, 1.0) else { return }
            strongSelf.cloudinary.createUploader(data, sandbagInfo: info, completion: { (url, error) in
                guard let uploadUrl = url else { return }
                strongSelf.cloudinary.createDownloader(uploadUrl, completion: { (image, error) in
                    guard let downloadedImage = image else { return }
                    let shareImageVC = UIStoryboard.loadShareImageViewController()
                    shareImageVC.shareImage = downloadedImage
                    shareImageVC.at.transition = TrolleyTransition()
                    strongSelf.present(shareImageVC, animated: true, completion: nil)
                })
            })
        }
    }
}


// MARK: - IBActions
private extension ARFloodViewController {
    @IBAction func myFamilyButtonTapped(sender: UIButton) {
        let navigationController = UIStoryboard.loadIntialMyFamilyViewController()
        present(navigationController, animated: true, completion: nil)
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
            let plane = WaterNode(anchor: planeAnchor)
            groundPlaneNodes.append(plane)
            node.addChildNode(plane)
            print(planeAnchor.extent.x + planeAnchor.extent.z)
            if planeAnchor.extent.x + planeAnchor.extent.z < 1.5 { return }
            DispatchQueue.main.async { [weak self] in
                self?.surgeLevelSlider.thumbImage = UIImage(named: "icon-slider40-rotate")
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        if planeAnchor.alignment == .horizontal {
            guard let groundPlaneNode = groundPlaneNodes.first(where: { (node) -> Bool in
                return node.anchor.identifier == planeAnchor.identifier
            }) else { return }
            groundPlaneNode.update(anchor: planeAnchor)
            print(planeAnchor.extent.x + planeAnchor.extent.z)
            if planeAnchor.extent.x + planeAnchor.extent.z < 1.5 { return }
            DispatchQueue.main.async { [weak self] in
                self?.surgeLevelSlider.thumbImage = UIImage(named: "icon-slider40-rotate")
            }
        }
    }
}


// MARK: - IBActions
private extension ARFloodViewController {
    @IBAction func floodLevelSliderChanged(_ sender: VSSlider) {
        DispatchQueue.main.async { [weak self] in
            guard let level = self?.surgeLevelSlider.value else { return }
            self?.surgeLevelLabel.text = "\(Int(level)) ft"
        }
        groundPlaneNodes.forEach {
            $0.floodLevel = CGFloat(surgeLevelSlider.value)
        }
    }
}


// MARK: - Private Instance Methods
private extension ARFloodViewController {
    func setupScene() {
        surgeLevelSlider.thumbImage = UIImage(named: "icon-slider-inactive")
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
}
