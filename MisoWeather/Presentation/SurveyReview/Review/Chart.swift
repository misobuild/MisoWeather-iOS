//
//  Chart.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//
import UIKit

class Chart: UIView {
    
    // 참고: https://github.com/p41155a/PathProject
    
    var percent = 0 // 넣는 값에 따라 달라짐
    var color = UIColor.subColor!.cgColor
    
    override func draw(_ rect: CGRect) {
        let graphBarScorePath = scorePath(width: self.frame.width - 10, height: self.frame.height) // 설정한 너비, 높이
        let graphBarScoreLayer = scoreLayer(path: graphBarScorePath, score: CGFloat(percent), color: color, lineWidth: 15)
        self.layer.addSublayer(graphBarScoreLayer)
        scoreAnimation(layer: graphBarScoreLayer, score: CGFloat(percent))
    }
    
    private func scorePath(width: CGFloat, height: CGFloat) -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 7)) // 시작 점
        path.addLine(to: CGPoint(x: width, y: 7)) // 직선 그림
        return path.cgPath
    }
    
    private func scoreLayer(path: CGPath, score: CGFloat, color: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = path
        layer.strokeEnd = score * 0.01
        layer.strokeColor = color
        layer.lineCap = .round
        layer.lineWidth = lineWidth
        layer.fillColor = nil
        return layer
    }
    
    private func scoreAnimation(layer: CAShapeLayer, score: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = score * 0.01
        animation.duration = 1.5
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "scoreAnimation")
    }
}
