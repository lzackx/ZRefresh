//
//  ZRefreshHeaderView.swift
//  Pixcial
//
//  Created by Zack on 27/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

/* Add codes as followed in UITableViewController to use ZRefresh
 
    var headerZRefreshView: ZRefreshHeaderView!;
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.headerZRefreshView = ZRefreshHeaderView(sv: self.tableView);
        self.headerZRefreshView.closureZRefreshing = {
            [unowned self] () -> Void in
            self.tableView.reloadDataZRefresh(self.headerZRefreshView);
        };
        self.view.addSubview(self.headerZRefreshView);
    }
 
 */

import UIKit

class ZRefreshHeaderView: ZRefreshView {

    let stateIdle: ZRefreshState = ZRefreshHeaderStateIdle();
    let statePulling: ZRefreshState = ZRefreshHeaderStatePulling();
    let stateWillRefresh: ZRefreshState = ZRefreshHeaderStateWillRefresh();
    let stateRefreshing: ZRefreshState = ZRefreshHeaderStateRefreshing();
    let stateDidRefresh: ZRefreshState = ZRefreshHeaderStateDidRefresh();
    let stateNoMoreData: ZRefreshState = ZRefreshHeaderStateNoMoreData();
    
    init(sv: UIScrollView) {
        super.init(frame: CGRectMake(sv.zX, sv.zY - 56, sv.zWidth, 56), sv: sv, state: self.stateIdle);
        initTitleLabel();
        self.addSubview(self.labelTitle);
        initDateLabel();
        self.addSubview(self.labelDate);
        initPanGestureRecognizer();
    }
    
    init(frame: CGRect, sv: UIScrollView) {
        super.init(frame: frame, sv: sv, state: self.stateIdle);
        initTitleLabel();
        self.addSubview(self.labelTitle);
        initDateLabel();
        self.addSubview(self.labelDate);
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
    
    func getCurrentDate() -> String {
        
        let formatterDate = NSDateFormatter();
        let formatDate = NSDateFormatter
            .dateFormatFromTemplate("yyyy-MM-dd HH:mm:ss",
                                    options: 0,
                                    locale: NSLocale.currentLocale());
        formatterDate.dateFormat = formatDate;
        return formatterDate.stringFromDate(NSDate());
    }
    
    func initDateLabel() {
        self.labelDate = UILabel(frame:
            CGRectMake(0, self.zHeight/2, self.zWidth, self.zHeight/2));
        self.labelDate.textAlignment = .Center;
        self.labelDate.font = UIFont.systemFontOfSize(12);
        self.labelDate.textColor = UIColor.lightGrayColor();
        self.labelDate.text = "Last Update: \(getCurrentDate())";
    }
    
    func initPanGestureRecognizer() {
        self.pan = self.sv!.panGestureRecognizer;
    }
    
    override func svContentOffsetDidChange(change: [String : AnyObject]?) {
        super.svContentOffsetDidChange(change);
       
        if (self.percentPulling < 1 && self.contextZRefresh.stateZRefresh.state == .NoMoreData) {
            self.contextZRefresh.stateTransform(self.stateIdle);
            self.labelTitle.text = self.contextZRefresh.stateZRefresh.text;
        }
        
        let currentOffsetY = self.sv.zOffsetY;
        let boundaryOffsetY = -self.svInsetOriginal.top;
        
        if (currentOffsetY <= boundaryOffsetY) {
            let percentPulling = Float((boundaryOffsetY - currentOffsetY) / self.zHeight);
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
            self.sv.zInsetT = self.svInsetOriginal.top + self.zHeight;
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
            self.sv.zInsetT = self.svInsetOriginal.top;
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
