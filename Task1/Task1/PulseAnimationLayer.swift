//
//  PulseAnimation.swift
//  Task1
//
//  Created by Aliona Starunska on 04.02.2021.
//

import Foundation
import UIKit

class PulseAnimationLayer: CALayer {

    private var animationGroup = CAAnimationGroup()
    private var animationDuration: TimeInterval = 0
    private var delay: TimeInterval = 0
    private var radius: CGFloat = 0
    private var numberOfPulse: Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(numberOfPulse: Float = Float.infinity,
         radius: CGFloat,
         postion: CGPoint,
         duration: TimeInterval,
         delay: TimeInterval) {
        super.init()
        self.animationDuration = duration
        self.backgroundColor = UIColor.red.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulse = numberOfPulse
        self.position = postion
        self.bounds = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        self.cornerRadius = radius
        self.delay = delay

        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
           }
        }
    }
    
    private func scaleAnimation() -> CABasicAnimation {
        let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimaton.fromValue = NSNumber(value: 0)
        scaleAnimaton.toValue = NSNumber(value: 1)
        scaleAnimaton.duration = animationDuration
        scaleAnimaton.timingFunction = CAMediaTimingFunction(name: .easeOut)
        return scaleAnimaton
    }
    
    private func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimiation.duration = animationDuration
        opacityAnimiation.values = [0.4,0.8,0]
        opacityAnimiation.keyTimes = [0,0.3,1]
        return opacityAnimiation
    }
    
    private func setupAnimationGroup() {
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = numberOfPulse
        animationGroup.beginTime = CACurrentMediaTime() + delay
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animationGroup.timingFunction = defaultCurve
        animationGroup.animations = [scaleAnimation(),createOpacityAnimation()]
    }
}
