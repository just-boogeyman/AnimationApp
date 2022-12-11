//
//  ViewController.swift
//  AnimationApp
//
//  Created by Ярослав Кочкин on 11.12.2022.
//

import UIKit
import SpringAnimation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var springAnimationView: SpringView!
    @IBOutlet weak var infoTextView: UITextView!
    
    private var codeText: String = ""
    private var nextAnimate = AnimationPreset.allCases.first
    let animations = AnimationPreset.allCases
    let animationCurves = AnimationCurve.allCases
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewAnimate()
    }

    
    @IBAction func nextAnimation() {
        setupViewAnimate()
        nextButton.setTitle(nextAnimate?.rawValue, for: .normal)
        nextButton.titleLabel?.text = nextAnimate?.rawValue
    }
    
    
    private func setupViewAnimate() {
        setupAnimate()
        setupTextView()
    }
    
    func setupView() {
        springAnimationView.layer.cornerRadius = 10
        springAnimationView.layer.shadowColor = UIColor.black.cgColor
        springAnimationView.layer.shadowOpacity = 0.5
        springAnimationView.layer.shadowOffset = CGSize(width: -5.0, height: 20.0)
        springAnimationView.layer.shadowRadius = 10
    }
    
    private func setupAnimate() {
        guard let randomPreset = nextAnimate?.rawValue else { return }
        guard let randomCurves = animationCurves.shuffled().first?.rawValue else { return }
        
        springAnimationView.animation = randomPreset
        springAnimationView.curve = randomCurves
        springAnimationView.force = CGFloat.random(in: 0...10)
        springAnimationView.duration = CGFloat.random(in: 0...10)
        springAnimationView.delay = CGFloat.random(in: 0...0.6)
        springAnimationView.animate()
        
        nextAnimate = animations.shuffled().first
    }
    
    private func setupTextView() {
        codeText = ""
        if springAnimationView.animation != "" {
            codeText += "layer.animation = \"\(springAnimationView.animation)\"\n"
        }
        if springAnimationView.curve != "" {
            codeText += "layer.curve = \"\(springAnimationView.curve)\"\n"
        }
        codeText += String(format: "layer.force =  %.1f\n", Double(springAnimationView.force))
        codeText += String(format: "layer.duration =  %.1f\n", Double(springAnimationView.duration))
        codeText += String(format: "layer.delay =  %.1f\n", Double(springAnimationView.delay))
        infoTextView.text = codeText
    }
}

