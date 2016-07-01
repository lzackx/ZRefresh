//
//  ZRefreshView.swift
//  Pixcial
//
//  Created by Zack on 27/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import UIKit

public class ZRefreshView: UIView {

    weak var sv: UIScrollView!;
    weak var pan: UIPanGestureRecognizer!;
    var labelTitle: UILabel!;
    var labelDate: UILabel!;
    var svInsetOriginal: UIEdgeInsets!;
    var contextZRefresh: ZRefreshContext!;
    var percentPulling: Float!;
    
    var isZRefreshing: Bool = false;
    var closureZRefreshing : (() -> Void) = {};
    
    init(frame: CGRect, sv: UIScrollView, state: ZRefreshState) {
        super.init(frame: frame);
        self.sv = sv;
        self.pan = self.sv.panGestureRecognizer;
        self.svInsetOriginal = self.sv.contentInset;
        self.contextZRefresh = ZRefreshContext(state: state);
        self.percentPulling = 1.0;
        observeScrollViewObserver();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func observeScrollViewObserver() {
        self.sv.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil);
        self.sv.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil);
    }
    
    func observePanGestureRecognizer() {
        self.pan.addObserver(self, forKeyPath: "state", options: NSKeyValueObservingOptions.New, context: nil);
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == "contentSize") {
            svContentSizeDidChange(change);
        }
        if (keyPath == "contentOffset") {
            svContentOffsetDidChange(change);
        }
        if (keyPath == "state") {
            panStateDidChange(change);
        }
        
    }
    
    func svContentSizeDidChange(change: [String : AnyObject]?) {}
    func svContentOffsetDidChange(change: [String : AnyObject]?) {}
    func panStateDidChange(change: [String : AnyObject]?) {}
    
    func zRefreshIdle() {}
    func zRefreshPulling() {}
    func zRefreshWillRefresh() {}
    func zRefreshRefreshing() {}
    func zRefreshDidRefresh() {}
    func zRefreshNoMoreData() {}
    
}
