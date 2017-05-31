//
//  GMHUDMovableAnalogicControl.swift
//  GMHUDLayerTest
//
//  Created by Gabriel Rodrigues on 31/05/17.
//  Copyright © 2017 MatheusBispo. All rights reserved.
//

import Foundation
import SpriteKit

public class GMMovableAnalogicControl : GMAnalogicControl {
    
    init(analogicSize: CGSize, bigTexture: SKTexture, smallTexture: SKTexture, trackingArea: CGSize){
        
        super.init(analogicSize: analogicSize, bigTexture: bigTexture, smallTexture: smallTexture)
        
        self.size = trackingArea
        
        self.alpha = 0.1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        bigStickNode.position = (touches.first?.location(in: self))!
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        bigStickNode.touchesMoved(touches, with: event)
        
        self.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        bigStickNode.touchesEnded(touches, with: event)
        
        self.run(SKAction.fadeAlpha(to: 0.1, duration: 0.2))
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        bigStickNode.touchesCancelled(touches, with: event)
        
    }
}
