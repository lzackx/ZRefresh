//
//  UICollectionView+ZRefresh.swift
//  Pixcial
//
//  Created by Zack on 15/6/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func reloadDataZRefresh(view: ZRefreshView) {
        reloadData();
        
        if (view.isKindOfClass(ZRefreshHeaderView)) {
            print("header reload");
            let header = view as! ZRefreshHeaderView;
            header.contextZRefresh.stateTransform(header.stateDidRefresh);
            header.labelTitle.text = header.contextZRefresh.stateZRefresh.text;
            header.zRefreshDidRefresh();
        }
        if (view.isKindOfClass(ZRefreshFooterView)) {
            print("footer reload");
            let footer = view as! ZRefreshFooterView;
            footer.contextZRefresh.stateTransform(footer.stateDidRefresh);
            footer.labelTitle.text = footer.contextZRefresh.stateZRefresh.text;
            footer.zRefreshDidRefresh();
        }
    }
    
    public func reloadSectionsZRefresh(view: ZRefreshView, sections: NSIndexSet) {
        reloadSections(sections);
    }
    
    public func reloadItemsAtIndexPathsZRefresh(view: ZRefreshView, indexPaths: [NSIndexPath]) {
        reloadItemsAtIndexPaths(indexPaths);
    }
    
}