//
//  ViewController.swift
//  XJNetworkStatu
//
//  Created by 若水三千 on 15/8/8.
//  Copyright (c) 2015年 若水三千. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataNetworkType()

        // Do any additional setup after loading the view, typically from a nib.
    }
    /// 获取当前网络状态
    // 状态栏是由当前app控制的，首先获取当前app（其实在swift中第一层变遍历当前app上的所有itme都已地址化我没有拿不到可读的名字了。如果想要拿到还是先写OC的运行时代码获取拿到可读的字符串）再将代码还原成swift我想苹果只是封闭了第一层不会有类名改动所以碰碰运气还真的可以 这里我跳过了好几层itme的遍历
    //
    
    func dataNetworkType(){
        var type: AnyObject?
        var app = UIApplication.sharedApplication()
        var count:UInt32 = 0
        var ivars = class_copyIvarList(app.classForCoder, &count)
        var children: NSArray = ((app.valueForKeyPath("statusBar"))!.valueForKeyPath("foregroundView"))!.subviews!
        for child in children {
            // NSClassFromString()通过字符串能拿到系统的类 如果想要获取自己定义的类需要添加工程名等处理
            if child.isKindOfClass(NSClassFromString("UIStatusBarDataNetworkItemView")) {
                type = child.valueForKeyPath("dataNetworkType")
                if type!.isKindOfClass(NSNumber.classForCoder()){
                    
                    if type!.isEqualToNumber(5){ // wift
                        println("当前网络是wifi")
                    }else if type!.isEqualToNumber(1){// 当前网络是2G
                        println("当前网络是2G")
                        
                    }else if type!.isEqualToNumber(2){//当前网络是3G
                        println("当前网络是3G")
                        
                    }else if type!.isEqualToNumber(3){//当前网络是4G
                        println("当前网络是4G")
                        
                    }else{
                        println("网络访问失败")
                    }
                }
            }
        }
        if type == nil {//一定要做处理不然程序启动就挂了。他找不到UIStatusBarDataNetworkItemView更别说dataNetworkType（其他如当前的电池电量，时间 信号强度 都是可以拿到的。这里哦就不写了）
            
            println("当前无网络")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

