//
//  DuckCardViewController.swift
//  Duck App
//
//  Created by Mark Gallagher Jr on 4/6/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import AVFoundation

class DuckCardViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var duckCardImageView: UIImageView!
    @IBOutlet weak var duckCardImageLabel: UILabel!
    @IBOutlet weak var duckCardAudioButton: UIButton!
    @IBOutlet weak var duckCardName: UILabel!
    @IBOutlet weak var duckCardScienceName: UILabel!
    
    @IBOutlet weak var duckCardDesc: UITextView!
    @IBOutlet weak var duckCardBehavior: UITextView!
    @IBOutlet weak var duckCardFood: UITextView!
    @IBOutlet weak var duckCardHabitat: UITextView!
    @IBOutlet weak var duckCardNesting: UITextView!
    @IBOutlet weak var duckCardConservation: UITextView!
    @IBOutlet weak var duckCardFunFacts: UITextView!
    
    var duckSound: AVAudioPlayer!
    
    // Stores the duck info object displayed on screen
    var duckInfo: DuckInfo?
    
    // Setup views for a Duck
    override func viewDidLoad() {
        super.viewDidLoad()
        duckCardAudioButton.setImage(#imageLiteral(resourceName: "PlayIcon"), for: UIControlState.normal)
        
        if let duck = duckInfo {
            duckCardImageView.image = duck.duckImage
            
            //duckCardAudioButton.setTitle(duck.duckAudioPath + " Audio File", for: .normal)
            
            duckCardName.text = duck.duckName
            duckCardScienceName.text = duck.duckScienceName
            
            duckCardDesc.text = duck.duckDesc
            duckCardBehavior.text = duck.duckBehavior
            duckCardFood.text = duck.duckFood
            duckCardHabitat.text = duck.duckHabitat
            duckCardNesting.text = duck.duckNesting
            duckCardConservation.text = duck.duckConservation
            duckCardFunFacts.text = duck.duckFunFacts
            resize()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if duckSound != nil {
            duckSound.stop()
            duckSound = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func audioButtonPressed(_ sender: Any) {
        if duckSound != nil {
            duckSound.stop()
            duckCardAudioButton.setImage(#imageLiteral(resourceName: "PlayIcon"), for: UIControlState.normal)
            duckSound = nil
        }
        else if let duck = duckInfo {
            duckSound = playSound(nameOfAudioFileInAssetCatalog: duck.duckAudioPath)
            duckCardAudioButton.setImage(#imageLiteral(resourceName: "PauseIcon"), for: UIControlState.normal)
        }
    }
    
    func resize(){
        let textView: Array<UITextView>! = [duckCardDesc, duckCardBehavior, duckCardFood, duckCardHabitat, duckCardNesting, duckCardConservation, duckCardFunFacts]
        for view in textView {
            let fixedWidth = view.frame.size.width
            let newSize = view.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            view.frame.size = CGSize(width: fixedWidth, height: newSize.height)
        }
    }
    
    func playSound(nameOfAudioFileInAssetCatalog: String) -> AVAudioPlayer? {
        var audioPlayer: AVAudioPlayer?
        if let sound = NSDataAsset(name: nameOfAudioFileInAssetCatalog) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
                audioPlayer!.play()
            } catch {
                print("error initializing AVAudioPlayer")
            }
        }
        return audioPlayer
    }

}
