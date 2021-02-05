//
//  EmitterView.swift
//  Task2
//
//  Created by Aliona Starunska on 02.02.2021.
//

import UIKit

private let kAnimationLayerKey = "com.animationLayer"

public final class EmitterView: UIView {
    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isUserInteractionEnabled = false
    }

    // MARK: -
    
    func emit(with layer: Layer, for duration: TimeInterval = 3.0) {
        layer.frame = self.bounds
        layer.needsDisplayOnBoundsChange = true
        self.layer.addSublayer(layer)

        guard duration.isFinite else { return }

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CAEmitterLayer.birthRate))
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.values = [1, 0, 0]
        animation.keyTimes = [0, 0.5, 1]
        animation.isRemovedOnCompletion = false

        layer.beginTime = CACurrentMediaTime()
        layer.birthRate = 1.0

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            let transition = CATransition()
            transition.delegate = self
            transition.type = .fade
            transition.duration = 1
            transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
            transition.setValue(layer, forKey: kAnimationLayerKey)
            transition.isRemovedOnCompletion = false

            layer.add(transition, forKey: nil)

            layer.opacity = 0
        }
        layer.add(animation, forKey: nil)
        CATransaction.commit()
    }

    // MARK: UIView

    override public func willMove(toSuperview newSuperview: UIView?) {
        guard let superview = newSuperview else { return }
        frame = superview.bounds
        isUserInteractionEnabled = false
    }
}

// MARK: - CAAnimationDelegate

extension EmitterView: CAAnimationDelegate {
    public func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        if let layer = animation.value(forKey: kAnimationLayerKey) as? CALayer {
            layer.removeAllAnimations()
            layer.removeFromSuperlayer()
        }
    }
}

