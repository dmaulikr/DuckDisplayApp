//
//  DuckCardViewController.swift
//  Duck App
//
//  Created by Mark Gallagher Jr on 4/6/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit

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
    
    // Stores the duck info object displayed on screen
    var duckInfo: DuckInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup views for a Duck
        if let duck = duckInfo {
            duckCardImageView.image = duck.duckImage
            duckCardImageLabel.text = duck.duckImageLabel
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(){
        var i = 1
        var textView: Array<UITextView>! = [duckCardDesc, duckCardBehavior, duckCardFood, duckCardHabitat, duckCardNesting, duckCardConservation, duckCardFunFacts]
        while (i <= 6){
        let fixedWidth = textView[i].frame.size.width
        textView[i].sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView[i].sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView[i].frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView[i].frame = newFrame
        i = i + 1
        }
    }


}
