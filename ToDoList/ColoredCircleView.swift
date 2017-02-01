//
//  ColoredCircleView.swift
//  ToDoList
//
//  Created by Ling He on 1/31/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation
import UIKit

class ColoredCircle: UIView{
    static func getCircleView(frame: CGRect, circleCenter: CGPoint, color: UIColor, radius: CGFloat) -> UIView {
        let view = ColoredCircleView(frame: frame, circleCenter: circleCenter, color: color, radius: radius)
        return view
    }

    class ColoredCircleView: UIView {
        var fillColor: UIColor = UIColor.red
        var radius: CGFloat = 50
        var circleCenter: CGPoint = CGPoint(x: 0, y: 0)
        
        init(frame: CGRect, circleCenter: CGPoint, color: UIColor, radius: CGFloat) {
            super.init(frame: frame)
            self.fillColor = color
            self.radius = radius
            self.frame = frame
            self.circleCenter = circleCenter
            self.backgroundColor = UIColor.clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            //let shape = CAShapeLayer(layer: layer)
            let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double(2) * M_PI), clockwise: true)
            //shape.path = path.CGPath;
            fillColor.setFill()
            path.fill()
            //view.layer.mask = shape;
        }
    }
    
}
