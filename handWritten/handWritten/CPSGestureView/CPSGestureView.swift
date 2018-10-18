//
//  CPSGestureView.swift
//  GestureView
//
//  Created by corepress on 2018/10/15.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class CPSGestureView: UIView {
    
    var starP : CGPoint = CGPoint.zero
    var moveP : CGPoint = CGPoint.zero
    
    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    //将签名截图传出去的闭包
    var callBack : ((_ image : UIImage)->Void)?
    
    init(frame: CGRect,callBack : @escaping (_ image : UIImage)->Void) {
        self.callBack = callBack
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        path.move(to: self.starP)
        path.addLine(to: self.moveP)
        
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeColor = UIColor.blue.cgColor
        layer.addSublayer(shapeLayer)
        shapeLayer.path = path.cgPath
        
        self.starP = self.moveP
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let touch = ((touches as NSSet).anyObject()) as! UITouch
        let starP = touch.location(in: self)
        self.starP = starP
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject()) as! UITouch
        let moveP = touch.location(in: self)
        self.moveP = moveP

        setNeedsDisplay()
    }
    
}

//MARK:事件监听
extension CPSGestureView {
    
     func clearBtn() {
        path.removeAllPoints()
        shapeLayer.removeFromSuperlayer()
    }
    
     func commetBtn() {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 1.0)
        let path = UIBezierPath(rect: self.bounds)
        path.addClip()
        let ctx = UIGraphicsGetCurrentContext()
        self.layer.render(in: ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.callBack!(image!)
        
    }
    
}
