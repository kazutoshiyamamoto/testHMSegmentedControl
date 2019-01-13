//
//  ViewController.swift
//  testHMSegmentedControl
//
//  Created by home on 2019/01/13.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit
import HMSegmentedControl

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var segmentedControls: HMSegmentedControl!
    
    var statusbarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // headerViewに合わせてsegmentedControlsのサイズを指定
        self.segmentedControls = HMSegmentedControl(frame: CGRect(x: 0, y: statusbarHeight, width: self.view.frame.size.width, height:self.headerView.frame.size.height))
        // メニューのタイトル
        self.segmentedControls.sectionTitles = ["Menu1", "Menu2", "Menu3"]
        // インジケータのスタイルを指定
        self.segmentedControls.selectionIndicatorLocation =  HMSegmentedControlSelectionIndicatorLocation.down
        self.segmentedControls.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        // インジケータの色を指定
        self.segmentedControls.selectionIndicatorColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0)
        // インジケータの高さ（太さ）を指定
        self.segmentedControls.selectionIndicatorHeight = 2.0
        // segmentedControlsで選択中の文字の色
        self.segmentedControls.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "HiraginoSans-W6", size: 16)!
        ]
        // segmentedControlsで非選択中の文字の色
        self.segmentedControls.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont(name: "HiraginoSans-W6", size: 16)!
        ]
        
        self.view.addSubview(segmentedControls)
        
        let blockVariable: IndexChangeBlock =  {(index: Int) -> Void in
            let frame = CGRect(x: self.scrollView.frame.size.width * CGFloat(index), y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            self.scrollView.scrollRectToVisible(frame, animated: true)
        }
        
        segmentedControls.indexChangeBlock = blockVariable
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.scrollView.frame.size.height)
        scrollView.delegate = self
        
        let menu1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
        menu1.backgroundColor = UIColor.cyan
        self.scrollView.addSubview(menu1)
        
        let menu2 = UIView(frame: CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
        menu2.backgroundColor = UIColor.red
        self.scrollView.addSubview(menu2)
        
        let menu3 = UIView(frame: CGRect(x: self.view.frame.size.width * 2, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
        menu3.backgroundColor = UIColor.green
        self.scrollView.addSubview(menu3)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        segmentedControls.selectedSegmentIndex = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
    }
}

