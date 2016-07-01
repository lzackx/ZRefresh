//
//  ZRefreshFooterState.swift
//  Pixcial
//
//  Created by Zack on 27/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import Foundation

class ZRefreshFooterStateIdle: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.Idle;
        self.text  = "Tap Or Pull Up To Load More";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true;
    }
}

class ZRefreshFooterStatePulling: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.Pulling;
        self.text  = "Tap Or Pull Up To Load More";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

class ZRefreshFooterStateWillRefresh: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.WillRefresh;
        self.text  = "Release To Load More";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

class ZRefreshFooterStateRefreshing: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.Refreshing;
        self.text  = "...Loading...";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

class ZRefreshFooterStateDidRefresh: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.DidRefresh;
        self.text  = "Tap Or Pull Up To Load More";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}


class ZRefreshFooterStateNoMoreData: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.NoMoreData;
        self.text  = "Tap Or Pull Up To Load More";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}