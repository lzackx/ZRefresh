//
//  UITableView+ZRefresh.swift
//  Pixcial
//
//  Created by Zack on 15/6/16.
//  Copyright © 2016年 lZackx. All rights reserved.
//

import UIKit

extension UITableView {
    
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
    
    public func reloadRowsAtIndexPathsZRefresh(view: ZRefreshView, indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation);
    }
    
    public func reloadSectionsZRefresh(view: ZRefreshView, sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        reloadSections(sections, withRowAnimation: animation);
    }
    
    public func reloadSectionIndexTitlesZRefresh(view: ZRefreshView) {
        reloadSectionIndexTitles();
    }
    
}
