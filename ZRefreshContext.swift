//
//  ZRefreshContext.swift
//  Pixcial
//
//  Created by Zack on 27/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

//enum ZRefreshState: String {
//    case Idle = "Idle";
//    case Pulling = "Pulling";
//    case Refreshing = "Refreshing";
//    case NoMoreData = "NoMoreData";
//}

import Foundation

enum ZRefreshStateDescription: Int {
    case Idle = 0;
    case Pulling = 1;
    case WillRefresh = 2;
    case Refreshing = 3;
    case DidRefresh = 4;
    case NoMoreData = 5;
}

protocol ZRefreshState: NSObjectProtocol {
    
    var state: ZRefreshStateDescription { get };
    var text: String { get };
    
    func stateTransform(state: ZRefreshState, context: ZRefreshContext) -> Bool;
    
}

class ZRefreshContext: NSObject {
    
    private var statePrevious: ZRefreshState;
    private var statePersent: ZRefreshState;
    
    var stateZRefresh: ZRefreshState {
        get {
            return self.statePersent;
        }
    }
    
    init(state: ZRefreshState) {
        self.statePrevious = state;
        self.statePersent = state;
        super.init();
    }
    
    func stateTransform(toState: ZRefreshState) {
        let isTransform = self.statePersent.stateTransform(toState, context: self);
        if (isTransform) {
            self.statePrevious = self.stateZRefresh;
            self.statePersent = toState;
        }
    }
    
    func stateTransform(toState: ZRefreshState, closure: (succeeded: Bool) -> Void ) {
        let isTransform = self.statePersent.stateTransform(toState, context: self);
        if (isTransform) {
            self.statePrevious = self.stateZRefresh;
            self.statePersent = toState;
        }
        closure(succeeded: isTransform);
    }
    
    func stateTransform(toState: ZRefreshState, complettion: () -> Void ) {
        let isTransform = self.statePersent.stateTransform(toState, context: self);
        if (isTransform) {
            self.statePrevious = self.stateZRefresh;
            self.statePersent = toState;
        }
        complettion();
    }
    
    func stateTransform(toState: ZRefreshState, closure: (succeeded: Bool) -> Void, complettion: () -> Void ) {
        let isTransform = self.statePersent.stateTransform(toState, context: self);
        if (isTransform) {
            self.statePrevious = self.stateZRefresh;
            self.statePersent = toState;
        }
        closure(succeeded: isTransform);
        complettion();
    }
       
}