//
//  UIView+ZExtension.swift
//  ZRefresh
//
//  Created by Zack on 26/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import UIKit

extension UIView {
    
    public var zX: CGFloat {
        get {
            return self.frame.origin.x;
        }
        set {
            var frame: CGRect = self.frame;
            frame.origin.x = newValue;
            self.frame = frame;
        }
    }
    
    public var zY: CGFloat {
        get {
            return self.frame.origin.y;
        }
        set {
            var frame: CGRect = self.frame;
            frame.origin.y = newValue;
            self.frame = frame;
        }
    }
    
    public var zWidth: CGFloat {
        get {
            return self.frame.size.width;
        }
        set {
            var frame: CGRect = self.frame;
            frame.size.width = newValue;
            self.frame = frame;
        }
    }
    
    public var zHeight: CGFloat {
        get {
            return self.frame.size.height;
        }
        set {
            var frame: CGRect = self.frame;
            frame.size.height = newValue;
            self.frame = frame;
        }
    }
    
    public var zSize: CGSize {
        get {
            return self.frame.size;
        }
        set {
            var frame: CGRect = self.frame;
            frame.size = newValue;
            self.frame = frame;
        }
    }
    
    public var zOrigin: CGPoint {
        get {
            return self.frame.origin;
        }
        set {
            var frame: CGRect = self.frame;
            frame.origin = newValue;
            self.frame = frame;
        }
    }
    
}
