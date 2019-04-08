//
//  BaikeViewController.swift
//  Yima3
//
//  Created by Dsssss on 2019/3/16.
//  Copyright © 2019年 Doubles. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import SnapKit
import Alamofire

class BaikeViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var baikeWebview: UIWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255,alpha: 1)
        //添加代理委托
        txtSearch.delegate = self
        baikeWebview.delegate = self
        
        txtSearch.leftView = UIImageView.init(image: #imageLiteral(resourceName: "sousuo"))
        txtSearch.contentMode = UIViewContentMode.center
        txtSearch.leftViewMode = UITextFieldViewMode.always
        txtSearch.clearButtonMode = UITextFieldViewMode.always
        // Do any additional setup after loading the view.
    }

    //加载请求的方法
    func loadUrl(url: String, web: UIWebView) {
        
        //载入输入的请求
        let aUrl = NSURL(string: ("https://" + url))
        let urlRequest = NSURLRequest(url: aUrl! as URL)
        web.loadRequest(urlRequest as URLRequest)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        loadUrl(url: txtSearch.text!, web: baikeWebview)
        //解除textField的第一响应者的注册资格，键盘消失；若没有这一步，键盘会一直留在屏幕内
        textField.resignFirstResponder()
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //轮圈开始转动
        loading.startAnimating()
        //状态栏的网络请求轮圈开始转动
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    //网页加载结束
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
