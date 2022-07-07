//
//  Pie.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/7.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: center.x + CGFloat(cos(startAngle.radians)),
                            y: center.y + CGFloat(sin(startAngle.radians)))
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockwise)     // 座標起始點在左上角，不反向的話結果會剛好相反
        p.addLine(to: center)
        
        return p
    }
}
