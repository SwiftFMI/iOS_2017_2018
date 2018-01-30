//
//  ViewController.swift
//  ARDemo
//
//  Created by Emil Atanasov on 19.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//
// For more info: https://developer.apple.com/videos/play/wwdc2017/602/
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(ViewController.handleTap(recogniser:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(recogniser: UITapGestureRecognizer) {
        guard let currentFrame = sceneView.session.currentFrame else {
            return
        }
        
        
        let imgPlane = SCNPlane(width: sceneView.bounds.width / 600, height: sceneView.bounds.width / 600)
        imgPlane.firstMaterial?.diffuse.contents = sceneView.snapshot()
        imgPlane.firstMaterial?.lightingModel = .constant
        
        
        let plane = SCNNode(geometry: imgPlane)
        sceneView.scene.rootNode.addChildNode(plane)
        
        var transition = matrix_identity_float4x4
        transition.columns.3.z = -0.1
        plane.simdTransform = matrix_multiply(currentFrame.camera.transform, transition)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
