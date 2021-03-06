//
//  ViewController.swift
//  testHMSegmentedControl
//
//  Created by home on 2019/01/13.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit
import HMSegmentedControl

class ViewController: UIViewController {
    // メニューを表示するView
    @IBOutlet weak var headerView: UIView!
    // メニューごとのViewを表示するScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    private lazy var segmentedControls: HMSegmentedControl = {
        // headerViewに合わせてsegmentedControlsのサイズを指定
        let statusbarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let segmentedControls = HMSegmentedControl(frame: CGRect(x: 0, y: statusbarHeight, width: self.view.frame.size.width, height:self.headerView.frame.size.height))
        // メニューのタイトル
        segmentedControls.sectionTitles = ["Menu1", "Menu2", "Menu3"]
        // インジケータのスタイルを指定
        segmentedControls.selectionIndicatorLocation =  HMSegmentedControlSelectionIndicatorLocation.down
        segmentedControls.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        // インジケータの色を指定
        segmentedControls.selectionIndicatorColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0)
        // インジケータの高さ（太さ）を指定
        segmentedControls.selectionIndicatorHeight = 2.0
        // segmentedControlsで選択中の文字の色
        segmentedControls.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0),
            NSAttributedString.Key.font: UIFont(name: "HiraginoSans-W6", size: 16)!
        ]
        // segmentedControlsで非選択中の文字の色
        segmentedControls.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont(name: "HiraginoSans-W6", size: 16)!
        ]
        
        // メニューで選択したタイトルに合わせてScrollViewの表示を変更する
        let blockVariable: IndexChangeBlock =  {(index: Int) -> Void in
            let frame = CGRect(x: self.scrollView.frame.size.width * CGFloat(index), y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            self.scrollView.scrollRectToVisible(frame, animated: true)
        }
        segmentedControls.indexChangeBlock = blockVariable
        
        return segmentedControls
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        // メニュー単位のスクロールを可能にする
        scrollView.isPagingEnabled = true
        // 水平方向のスクロールインジケータを非表示にする
        scrollView.showsHorizontalScrollIndicator = false
        // scrollViewのサイズを指定（幅は1メニューに表示するViewの幅×メニュー数）
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.scrollView.frame.size.height)
        
        // segmentedControlsを追加
        self.view.addSubview(self.segmentedControls)
        
        // 各メニューに表示するViewを追加
        let menu1: UIView = {
            let menu1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
            menu1.backgroundColor = UIColor.cyan
            return menu1
        }()
        self.scrollView.addSubview(menu1)
        
        let menu2: UIView = {
            let menu2 = UIView(frame: CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
            menu2.backgroundColor = UIColor.red
            return menu2
        }()
        self.scrollView.addSubview(menu2)
        
        let menu3: UIView = {
            let menu3 = UIView(frame: CGRect(x: self.view.frame.size.width * 2, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
            menu3.backgroundColor = UIColor.green
            return menu3
        }()
        self.scrollView.addSubview(menu3)
    }
}

// ScrollViewの横スクロールに合わせてメニューのインジケータを移動する
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        segmentedControls.selectedSegmentIndex = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
    }
}

