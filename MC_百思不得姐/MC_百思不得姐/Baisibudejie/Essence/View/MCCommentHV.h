//
//  MCCommentHV.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/12.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCommentHV : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewOfSectionWithTableView:(UITableView *)tableView;

@end
