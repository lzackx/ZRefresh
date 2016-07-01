//
//  ZRefreshFooterView.swift
//  Pixcial
//
//  Created by Zack on 27/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

/* Add codes as followed in UITableViewController to use ZRefresh
 
 var footerZRefreshView: ZRefreshFooterView!;
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.footerZRefreshView = ZRefreshFooterView(sv: self.tableView);
        self.footerZRefreshView.closureZRefreshing = {
            [unowned self] () -> Void in
            self.tableView.reloadDataZRefresh(self.footerZRefreshView);
        };
        self.view.addSubview(self.footerZRefreshView);
 }
 
 */

import UIKit

class ZRefreshFooterView: ZRefreshView {

    let stateIdle: ZRefreshState = ZRefreshFooterStateIdle();
    let statePulling: ZRefreshState = ZRefreshFooterStatePulling();
    let stateWillRefresh: ZRefreshState = ZRefreshFooterStateWillRefresh();
    let stateRefreshing: ZRefreshState = ZRefreshFooterStateRefreshing();
    let stateDidRefresh: ZRefreshState = ZRefreshFooterStateDidRefresh();
    let stateNoMoreData: ZRefreshState = ZRefreshFooterStateNoMoreData();
    
    init(sv: UIScrollView) {
        super.init(frame: CGRectMake(sv.zX, sv.zContentHeight, sv.zWidth, 56),
                   sv: sv,
                   state: self.stateIdle);
        initTitleLabel();
        self.addSubview(self.labelTitle);
        initPanGestureRecognizer();
    }
    
    init(frame: CGRect, sv: UIScrollView) {
        super.init(frame: frame, sv: sv, state: self.stateIdle);
        
        initTitleLabel();
        self.addSubview(self.labelTitle);
        initPanGestureRecognizer();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func initTitleLabel() {
        self.labelTitle = UILabel(frame:
            CGRectMake(0, self.zHeight/4, self.zWidth, self.zHeight/2));
        self.labelTitle.textAlignment = .Center;
        self.labelTitle.font = UIFont.systemFontOfSize(14);
        self.labelTitle.textColor = UIColor.lightGrayColor();
        self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
    }
    
    func initPanGestureRecognizer() {
        self.pan = self.sv!.panGestureRecognizer;
    }
    
    override func svContentOffsetDidChange(change: [String : AnyObject]?) {
        super.svContentOffsetDidChange(change);
        
        if (self.percentPulling < 1 &&
            self.contextZRefresh.stateZRefresh.state == .NoMoreData ) {
            self.contextZRefresh.stateTransform(self.stateIdle);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        }
        
        let currentOffsetY = self.sv.zOffsetY;
        let boundaryOffsetY = (self.sv.zContentHeight
            - (self.sv.zHeight - self.sv.zInsetT - self.sv.zInsetB));
        if (currentOffsetY > boundaryOffsetY ||
            self.sv.zHeight > self.sv.zContentHeight) {
            
            let percentPulling = Float((currentOffsetY
                - ((self.sv.zHeight > self.sv.zContentHeight) ? 0 : boundaryOffsetY))
                / self.zHeight);
            self.percentPulling = Float(percentPulling);

            switch self.contextZRefresh.stateZRefresh.state {
            case .Idle:
                zRefreshIdle();
            case .Pulling:
                zRefreshPulling();
            case .WillRefresh:
                zRefreshWillRefresh();
            case .Refreshing:
                zRefreshRefreshing();
            case .DidRefresh:
                break;
            case .NoMoreData:
                break;
            }
        }
    }
    
    override func svContentSizeDidChange(change: [String : AnyObject]?) {
        super.svContentSizeDidChange(change);
        self.zY = self.sv.zContentHeight;
    }
    
    override func zRefreshIdle() {
        super.zRefreshIdle();
        self.svInsetOriginal = self.sv.contentInset;
        if (self.sv.dragging) {
            self.contextZRefresh.stateTransform(self.statePulling);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        }        
    }
    
    override func zRefreshPulling() {
        super.zRefreshPulling();
        if (self.sv.dragging && self.percentPulling >= 1) {
            self.contextZRefresh.stateTransform(self.stateWillRefresh);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        } else if (!self.sv.dragging && self.percentPulling < 1) {
            self.contextZRefresh.stateTransform(self.stateIdle);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        }
    }
    
    override func zRefreshWillRefresh() {
        super.zRefreshWillRefresh();
        if (self.sv.dragging && self.percentPulling < 1) {
            self.contextZRefresh.stateTransform(self.statePulling);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        } else if(!self.sv.dragging && self.percentPulling >= 1) {
            self.contextZRefresh.stateTransform(self.stateRefreshing);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        }
    }
    
    override func zRefreshRefreshing() {
        super.zRefreshRefreshing();
        UIView.animateWithDuration(0.25, animations: {
            [unowned self] () -> Void in
            self.sv.zInsetB = self.svInsetOriginal.bottom + self.zHeight;
        }) { [unowned self] (_) in
            if (!self.isZRefreshing) {
                self.isZRefreshing = true;
                self.closureZRefreshing();
            }
        }
    }
    
    override func zRefreshDidRefresh() {
        super.zRefreshDidRefresh();
        UIView.animateWithDuration(0.5, animations: {
            [unowned self] () -> Void in
            self.sv.zInsetB = self.svInsetOriginal.bottom;
        }) { [unowned self] (_) in
            self.contextZRefresh.stateTransform(self.stateNoMoreData);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
            self.zRefreshNoMoreData();
        }
    }
    
    override func zRefreshNoMoreData() {
        super.zRefreshNoMoreData();
        self.isZRefreshing = false;
    }
}
