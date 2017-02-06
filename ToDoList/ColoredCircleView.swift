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
    static func getCircleView(coor: CGPoint, len: CGFloat, color: UIColor) -> UIView {
        let view = ColoredCircleView(coor: coor, len: len, color: color)
        return view
    }

    class ColoredCircleView: UIView {
        var fillColor: UIColor = UIColor.red
        var radius: CGFloat = 50
        var circleCenter: CGPoint = CGPoint(x: 0, y: 0)
        
        init(coor: CGPoint, len: CGFloat, color: UIColor) {
            let frame = CGRect(x: coor.x, y: coor.y, width: len, height: len)
            super.init(frame: frame)
            self.fillColor = color
            self.radius = len / 2
            self.circleCenter = CGPoint(x: len/2, y: len/2)
            self.backgroundColor = UIColor.clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double(2) * M_PI), clockwise: true)
            fillColor.setFill()
            path.fill()
        }
    }
    
}
