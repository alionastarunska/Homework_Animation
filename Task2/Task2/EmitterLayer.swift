//
//  EmitterLayer.swift
//  Task2
//
//  Created by Aliona Starunska on 02.02.2021.
//

import UIKit

// MARK: -

public enum Content {
    case image(UIImage, UIColor?)
    case text(String)
}

class Layer: CAEmitterLayer {
    
    func configure(with contents: [Content]) {
        emitterCells = contents.map { content in
            let cell = CAEmitterCell()
            cell.contents = content.image.cgImage
            cell.lifetime = 20
            cell.birthRate = 50
            cell.blueRange = 0.15
            cell.alphaRange = 0.4
            cell.velocity = 30
            cell.velocityRange = 20
            cell.scale = 0.1
            cell.scaleRange = 0.3
            cell.emissionRange = CGFloat.pi / 2
            cell.emissionLongitude = CGFloat.pi
            cell.yAcceleration = 50
            cell.scaleSpeed = -0.05
            cell.alphaSpeed = -0.01
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
        emitterSize = bounds.size
        emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
    }
}

// MARK: - Content

extension Content {
    var color: UIColor? {
        switch self {
        case let .image(_, color?): return color
        default: return nil
        }
    }

    var image: UIImage {
        switch self {
        case let .image(image, _): return image
        case let .text(string):
            let defaultAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14.0)
            ]
            return NSAttributedString(string: "\(string)", attributes: defaultAttributes).image
        }
    }
}

fileprivate extension NSAttributedString {
    var image: UIImage {
        return UIGraphicsImageRenderer(size: size()).image { _ in
            self.draw(at: .zero)
        }
    }
}
