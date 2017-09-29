//
//  IXMLoginCell.h
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface IXMSDKLoginCell : UITableViewCell

@property(nonatomic,assign) BOOL  ispwd;
@property(nonatomic,assign) BOOL  isshowbtn;
@property(nonatomic,strong) UIButton *sendbtn;
@property(nonatomic,strong) UITextField *textField;
/**
 *  设置cell、数据
 *  @param dataString    textfield输入内容
 *  @param indexPath     indexPath。唯一绑定当前textfield
 */
- (void)setPlaceholderString:(NSString *)dataString
          andIndexPath:(NSIndexPath *)indexPath;

- (void)setString:(NSString *)dataString
     andIndexPath:(NSIndexPath *)indexPath;
@end
