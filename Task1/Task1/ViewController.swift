//
//  ViewController.swift
//  Task1
//
//  Created by Aliona Starunska on 04.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var circleView: UIView!
    @IBOutlet private weak var circleImageView: UIImageView!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func showAnimation() {
        [0, 0.35, 0.7, 1.0, 1.3].forEach {
            let pulse = PulseAnimationLayer(radius: 70, postion: circleImageView.center, duration: 1.7, delay: $0)
            view.layer.insertSublayer(pulse, at: 0)
        }
    }
    
    @IBAction private func startAction(_ sender: UIButton) {
        showAnimation()
    }
    
    @IBAction private func stopAction(_ sender: UIButton) {
        view.layer.sublayers?.compactMap({ $0 as? PulseAnimationLayer }).forEach({ $0.removeFromSuperlayer() })
    }
}

