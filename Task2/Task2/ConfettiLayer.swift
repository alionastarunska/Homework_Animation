//
//  ConfettiLayer.swift
//  Task2
//
//  Created by Aliona Starunska on 03.02.2021.
//

import UIKit

class ConfettiLayer: Layer {
    
    private var velocities = [100, 125, 150, 200]
    
    private var randomVelocity: Int {
        return velocities.randomElement() ?? 0
    }
    
    override init() {
        super.init()
        configure(with: [Content.image(UIImage(named: "confetti")!, .red),
                         Content.image(UIImage(named: "confetti")!, .green),
                         Content.image(UIImage(named: "confetti")!, .blue)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with contents: [Content]) {
        emitterCells = contents.map { content in
            let cell = CAEmitterCell()
            cell.contents = content.image.cgImage
            cell.birthRate = 20.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.scale = 0.1
            cell.scaleRange = 0.25
            cell.velocity = CGFloat(randomVelocity)
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            if let color = content.color {
                cell.color = color.cgColor
            }
            return cell
        }
    }

    // MARK: CALayer

    override func layoutSublayers() {
        super.layoutSublayers()
        emitterMode = .outline
        emitterShape = .line
        emitterSize = CGSize(width: frame.size.width / 4, height: 1)
        emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
    }
}
