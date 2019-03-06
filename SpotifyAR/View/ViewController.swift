//
//  ViewController.swift
//  SpotifyAR
//
//  Created by Cordova Putra on 26/02/19.
//  Copyright © 2019 Cordova Putra. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let viewInSpotifyButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        // Set the scene to the view
        sceneView.scene = scene
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
            print("No images available")
            return
        }
        
        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 1
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func viewInSpotify(){
        self.viewInSpotifyButton.frame = CGRect(x: 60, y: 400, width: 200, height: 50)
        self.viewInSpotifyButton.backgroundColor = UIColor(red: 46, green: 189, blue: 89, alpha: 1)
        self.viewInSpotifyButton.layer.cornerRadius = 20
        self.viewInSpotifyButton.layer.masksToBounds = true
        
        view.addSubview(viewInSpotifyButton)
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            //Detection Plane
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            
            let shipScene = SCNScene(named: "art.scnassets/soundcard.scn")!
            let shipNode = shipScene.rootNode.childNodes.first!
            shipNode.position = SCNVector3Zero
            shipNode.position.z = 0.20
            
            let material = SCNMaterial()
            DispatchQueue.main.async {
                //Clickable material
                let clickableElement = ClickableView(frame: CGRect(x: 0, y: 0, width: 50, height: 300))
                clickableElement.tag = 1
                material.diffuse.contents = clickableElement
            }
            shipNode.geometry?.firstMaterial = material
            
//            viewInSpotify()
            //Add Play music feature here
            
            
            
            planeNode.addChildNode(shipNode)
            node.addChildNode(planeNode)
        }
        return node
    }
}

extension SCNMaterial {
    convenience init(color: UIColor) {
        self.init()
        diffuse.contents = color
    }
    convenience init(image: UIImage) {
        self.init()
        diffuse.contents = image
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
