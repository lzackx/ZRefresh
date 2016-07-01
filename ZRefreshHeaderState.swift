//
//  ZRefreshHeaderState.swift
//  Pixcial
//
//  Created by Zack on 27/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import Foundation

class ZRefreshHeaderStateIdle: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.Idle;
        self.text = "Pull Down To Refresh";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true;
    }
}

class ZRefreshHeaderStatePulling: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.Pulling;
        self.text = "Pull Down To Refresh";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

class ZRefreshHeaderStateWillRefresh: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.WillRefresh;
        self.text  = "Release To Refresh";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

class ZRefreshHeaderStateRefreshing: NSObject, ZRefreshState {
    
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

class ZRefreshHeaderStateDidRefresh: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.DidRefresh;
        self.text  = "Pull Down To Refresh";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

class ZRefreshHeaderStateNoMoreData: NSObject, ZRefreshState {
    
    var state: ZRefreshStateDescription;
    var text: String;
    
    override init() {
        self.state = ZRefreshStateDescription.NoMoreData;
        self.text  = "Pull Down To Refresh";
        super.init();
    }
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool {
        
        return true
    }
}

