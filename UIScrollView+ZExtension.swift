//
//  UIScrollView+ZExtension.swift
//  ZRefresh
//
//  Created by Zack on 26/5/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    public var zInsetT: CGFloat {
        get {
            return self.contentInset.top;
        }
        set {
            var inset: UIEdgeInsets = self.contentInset;
            inset.top = newValue;
            self.contentInset = inset;
        }
    }
    
    public var zInsetL: CGFloat {
        get {
            return self.contentInset.left;
        }
        set {
            var inset: UIEdgeInsets = self.contentInset;
            inset.left = newValue;
            self.contentInset = inset;
        }
    }
    
    public var zInsetR: CGFloat {
        get {
            return self.contentInset.right;
        }
        set {
            var inset: UIEdgeInsets = self.contentInset;
            inset.right = newValue;
            self.contentInset = inset;
        }
    }
    
    public var zInsetB : CGFloat {
        get {
            return self.contentInset.bottom;
        }
        set {
            var inset: UIEdgeInsets = self.contentInset;
            inset.bottom = newValue;
            self.contentInset = inset;
        }
    }
    
    public var zOffsetX: CGFloat {
        get {
            return self.contentOffset.x;
        }
        set {
            var offset: CGPoint = self.contentOffset;
            offset.x = newValue;
            self.contentOffset = offset;
        }
    }
    
    public var zOffsetY: CGFloat {
        get {
            return self.contentOffset.y;
        }
        set {
            var offset: CGPoint = self.contentOffset;
            offset.y = newValue;
            self.contentOffset = offset;
        }
    }
    
    public var zContentWidth: CGFloat {
        get {
            return self.contentSize.width;
        }
        set {
            var size: CGSize = self.contentSize;
            size.width = newValue;
            self.contentSize = size;
        }
    }
    
    public var zContentHeight: CGFloat {
        get {
            return self.contentSize.height;
        }
        set {
            var size: CGSize = self.contentSize;
            size.height = newValue;
            self.contentSize = size;
        }
    }
}
