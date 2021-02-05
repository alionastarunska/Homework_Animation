//
//  FireworkLayer.swift
//  Task2
//
//  Created by Aliona Starunska on 04.02.2021.
//

import UIKit

class FireworkLayer: Layer {
    private let emitterCell = CAEmitterCell()
    private let trailCell = CAEmitterCell()
    private let fireworkCell = CAEmitterCell()
    
    override init() {
        super.init()
        setupEmitterCell()
        setupTrailCell()
        setupFireworkCell()
        emitterCell.emitterCells = [trailCell, fireworkCell]
        emitterCells = [emitterCell]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEmitterCell() {
        emitterCell.color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        emitterCell.redRange = 0.9
        emitterCell.greenRange = 0.9
        emitterCell.blueRange = 0.9
        emitterCell.lifetime = 2.5
        emitterCell.birthRate = 2
        emitterCell.velocity = 50
        emitterCell.velocityRange = 100
        emitterCell.emissionRange = CGFloat.pi / 3
        emitterCell.emissionLongitude = CGFloat.pi * 2
        emitterCell.yAcceleration = -100
    }
    
    private func setupTrailCell() {
        trailCell.contents = UIImage(named: "spark")?.cgImage
        trailCell.lifetime = 0.5
        trailCell.birthRate = 60
        trailCell.velocity = 80
        trailCell.scale = 0.1
        trailCell.alphaSpeed = -0.7
        trailCell.scaleSpeed = -0.1
        trailCell.scaleRange = 0.1
        trailCell.beginTime = 0.01
        trailCell.duration = 1.7
        trailCell.emissionRange = CGFloat.pi / 8
        trailCell.emissionLongitude = CGFloat.pi 
        trailCell.yAcceleration = 350;
    }
    
    private func setupFireworkCell() {
        fireworkCell.contents = UIImage(named: "tspark")?.cgImage
        fireworkCell.lifetime = 25
        fireworkCell.birthRate = 2000
        fireworkCell.velocity = 100
        fireworkCell.scale = 0.6
        fireworkCell.spin = 3
        fireworkCell.alphaSpeed = -0.2
        fireworkCell.scaleSpeed = -0.1
        fireworkCell.beginTime = 1.5
        fireworkCell.duration = 0.05
        fireworkCell.emissionRange = CGFloat.pi * 2
        fireworkCell.yAcceleration = -80
    }
    
    // MARK: CALayer

    override func layoutSublayers() {
        super.layoutSublayers()
        emitterMode = .outline
        emitterShape = .line
        renderMode = .additive
        emitterSize = CGSize(width: frame.size.width / 5, height: 1)
        emitterPosition = CGPoint(x: frame.size.width / 2.0, y: frame.size.height * 0.8)
    }
}
