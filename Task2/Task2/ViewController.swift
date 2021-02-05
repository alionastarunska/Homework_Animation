//
//  ViewController.swift
//  Task2
//
//  Created by Aliona Starunska on 02.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var snowflakeView: EmitterView!
    @IBOutlet private weak var confettiView: EmitterView!
    @IBOutlet private weak var firewolkView: EmitterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        snowflakeView.emit(with: SnowflakeLayer(), for: .infinity)
        confettiView.emit(with: ConfettiLayer(), for: .infinity)
        firewolkView.emit(with: FireworkLayer(), for: .infinity)
    }
}
