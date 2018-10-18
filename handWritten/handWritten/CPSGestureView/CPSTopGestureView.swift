//
//  CPSTopGestureView.swift
//  GestureView
//
//  Created by corepress on 2018/10/16.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenheigth = UIScreen.main.bounds.size.height

let contentHeight = ((screenWidth*(350))/(375))

class CPSTopGestureView: UIView {

    var tapView : UIButton?
    var gestureView : CPSGestureView?
    var contentView : UIView?
    //将签名截图传出去的闭包
    var callBack : ((_ image : UIImage)->Void)?
    
    init(frame: CGRect,callBack : @escaping (_ image : UIImage)->Void) {
        super.init(frame: frame)
        self.callBack = callBack
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:初始化UI
extension CPSTopGestureView {
    
    func setUpUI() {
        
        tapView = UIButton(type: .custom)
        let isX = self.isX()
        tapView?.frame = isX ? CGRect(x: 0, y: 44, width:screenWidth , height: screenheigth - 44 - 34) : CGRect(x: 0, y: 20, width:screenWidth , height: screenheigth-20)
        tapView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        tapView?.addTarget(self, action: #selector(CPSTopGestureView.tapViewTap(btn:)), for: .touchUpInside)
        addSubview(tapView!)
        
        let contentView = UIView(frame: CGRect(x: 0, y: tapView!.bounds.height - contentHeight, width: screenWidth, height: contentHeight))
        self.contentView = contentView
        contentView.backgroundColor = UIColor.white
        tapView?.addSubview(contentView)
        
        let title_lable = UILabel(frame: CGRect(x: 10, y: 5, width: 200, height: 20))
        title_lable.text = "请在此处手写签名确认"
        title_lable.textColor = UIColor.black
        contentView.addSubview(title_lable)
        
        
        let clearBtn = UIButton(type: .system)
        clearBtn.frame = CGRect(x: contentView.bounds.width-50-10, y: 0, width: 50, height: 30)
        clearBtn.setTitle("抹除", for: .normal)
        clearBtn.setTitleColor(UIColor.gray, for: .normal)
        clearBtn.addTarget(self, action: #selector(CPSTopGestureView.clearBtn(btn:)), for: .touchUpInside)
        contentView.addSubview(clearBtn)
        
        
        let gestureView = CPSGestureView(frame: CGRect(x: 0, y: 30, width: contentView.bounds.width, height: contentView.bounds.height - 30 - 44)) { (image) in
           self.callBack!(image)
        }
        self.gestureView = gestureView
        contentView.addSubview(gestureView)
        
        
        let commentBtn = UIButton(type: .system)
        commentBtn.frame = CGRect(x: 0, y: contentView.bounds.height - 44, width: contentView.bounds.width, height: 44)
        commentBtn.setTitle("提交", for: .normal)
        commentBtn.setTitleColor(UIColor.white, for: .normal)
        commentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        commentBtn.backgroundColor = UIColor.init(red: 0.1529, green: 0.7765, blue: 0.7765, alpha: 1.0)
        commentBtn.addTarget(self, action: #selector(CPSTopGestureView.commetBtn(btn:)), for: .touchUpInside)
        contentView.addSubview(commentBtn)
        
        contentView.transform = CGAffineTransform(translationX: 0, y: screenheigth)
        UIView.animate(withDuration: 0.5) {
            contentView.transform = CGAffineTransform.identity
        }
        
    }
    
    func isX() -> Bool {
        if UIScreen.main.bounds.height >= 812 {
            return true
        }
        return false
    }
    
    
}
//MARK:事件监听
extension CPSTopGestureView {

    @objc func tapViewTap(btn : UIButton) {
        hidden()
    }
    
    @objc func clearBtn(btn : UIButton) {
        
        self.gestureView?.clearBtn()
        
    }
    @objc func commetBtn(btn : UIButton) {
        self.gestureView?.commetBtn()
        hidden()
    }
    
    func hidden() {
       UIView.animate(withDuration: 0.5, animations: {
             self.contentView?.transform = CGAffineTransform.init(translationX: 0, y: screenheigth)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
