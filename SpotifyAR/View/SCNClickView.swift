//
//  ARButton.swift
//  SpotifyAR
//
//  Created by Cordova Putra on 26/02/19.
//  Copyright © 2019 Cordova Putra. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

var music = AVAudioPlayer()

class ClickableView: UIButton{
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addTarget(self, action: #selector(objectTapped), for: .touchUpInside)
        
        let image = UIImage(named: "soundcardtexture") as UIImage?
//        self.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
        self.setImage(image, for: .normal)
        
//        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func textLabelTest(){
//        let label = UILabel(frame: CGRect(x: 120, y: 100, width: 300, height: 150))
//        label.text = "The playlist is clicked"
//        label.textColor = UIColor.white
//
//        self.addSubview(label)
//    }
    
    @objc func objectTapped(){
        print("Object with tag \(tag)")
//        textLabelTest()
        do {
            music = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
            music.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        music.play()
    }
}
