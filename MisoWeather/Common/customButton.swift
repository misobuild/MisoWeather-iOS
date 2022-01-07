//
//  customButton.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/05.
//

import UIKit

class customButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setBackgroundImage(UIImage(named: "next_button"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public enum CSButtonType {
        case rect
        case circle
    }
    
    convenience init(type: CSButtonType){
        self.init()
        
        switch type {
        case.rect:
            self.backgroundColor = .black
            self.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
            self.setTitleColor(.white, for: .normal)
            self.setTitleColor(.gray, for: .highlighted)
            self.backgroundColor = .orange
            self.layer.cornerRadius = 10
        case.circle:
            self.backgroundColor = .black
            self.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
            self.setTitleColor(.white, for: .normal)
            self.setTitleColor(.gray, for: .highlighted)
            self.backgroundColor = .orange
            self.layer.cornerRadius = 10
        }
    }
    var style: CSButtonType = .rect {
          didSet {
              switch style {
              case .rect:
                  self.backgroundColor = .black
                  self.layer.borderColor = UIColor.black.cgColor
                  self.layer.borderWidth = 2
                  self.layer.cornerRadius = 0
                  self.setTitleColor(.white, for: .normal)
                  self.setTitle("Rect button", for: .normal)
                  
              case .circle:
                  self.backgroundColor = .red
                  self.layer.borderColor = UIColor.blue.cgColor
                  self.layer.borderWidth = 2
                  self.layer.cornerRadius = 50
                  self.setTitle("Circle Button", for: .normal)
              }
          }
      }
//    // ViewController.swift
//       override func viewDidLoad() {
//           super.viewDidLoad()
//           let btn = CSButton(type: .circle)
//           btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
//           btn.style = .rect
//           self.view.addSubview(btn)
//       }

}
