//
//  BKAnalogic.swift
//  FazendoAnalogico
//
//  Created by Matheus Bispo on 21/05/17.
//  Copyright © 2017 MatheusBispo. All rights reserved.
//

import GameplayKit

public struct AnalogicData{
    public var velocity = CGPoint.zero
    public var angle = CGFloat(0)
}

public protocol GMAnalogicDataDelegate: class {
    func analogicDataUpdated(analogicData: AnalogicData)
}

public class GMAnalogicControl: SKSpriteNode {
    
    internal var bigStickNode : GMBigStickNode!
    public var data = AnalogicData()

    public weak var delegate: GMAnalogicDataDelegate?
    
    public init(analogicSize: CGSize, bigTexture: SKTexture, smallTexture: SKTexture) {
        
        super.init(texture: SKTexture(), color: UIColor.clear, size: analogicSize)
        
        bigStickNode = GMBigStickNode(size: analogicSize, bigTexture: bigTexture, smallTexture: smallTexture)
        
        bigStickNode.delegate = self
        
        self.addChild(bigStickNode)
    }
    
    public convenience init(analogicSize: CGSize, bigTexture: SKTexture, smallTexture: SKTexture, trackingArea: CGSize) {
        
        self.init(analogicSize: analogicSize, bigTexture: bigTexture, smallTexture: smallTexture)
        
       // self.alpha = 0
        
        self.size = trackingArea
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        self.setup()
    }
    
    func setup() {
        guard let sizeValue : Double = self.userData?.value(forKey: "Size") as? Double else{
            fatalError("The Value for key 'Size' can't be casted for Double type")
        }
        
        guard let bigTextureValue : String = self.userData?.value(forKey: "BigTexture") as? String else{
            fatalError("The Value for key 'BigTexture' can't be casted for String type")
        }
        
        guard let smallTextureValue : String = self.userData?.value(forKey: "SmallTexture") as? String else{
            fatalError("The Value for key 'SmallTexture' can't be casted for String type")
        }
        
        let bigTexture = SKTexture(imageNamed: bigTextureValue)
        let smallTexture = SKTexture(imageNamed: smallTextureValue)
        
        let size = CGSize(width: sizeValue, height: sizeValue)
        
        bigStickNode = GMBigStickNode(size: size, bigTexture: bigTexture, smallTexture: smallTexture)
    
        bigStickNode.delegate = self
        
        self.addChild(bigStickNode)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.bigStickNode.position = (touches.first?.location(in: self))!
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        bigStickNode.touchesMoved(touches, with: event)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        bigStickNode.touchesEnded(touches, with: event)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        bigStickNode.touchesCancelled(touches, with: event)
    }

    
}

extension GMAnalogicControl : AnalogJoystickNodeDelegate{
    func analogDidMoved(analog: GMBigStickNode, xValue: Float, yValue: Float) {
        data.velocity = CGPoint(x: CGFloat(xValue), y: CGFloat(yValue))
        data.angle = CGFloat(-atan2(xValue, yValue))
        
        delegate?.analogicDataUpdated(analogicData: data)
    }
}
