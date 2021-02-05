//
//  SnowflakeLayer.swift
//  Task2
//
//  Created by Aliona Starunska on 03.02.2021.
//

import UIKit

class SnowflakeLayer: Layer {
    
    override init() {
        super.init()
        configure(with: [Content.image(UIImage(named: "snow")!, .white)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
