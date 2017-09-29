//
//  IXMLoginCell.m
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKLoginCell.h"
#import "IXMSDKConfing.h"
@interface IXMSDKLoginCell ()
@end

@implementation IXMSDKLoginCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor =[UIColor whiteColor];
        _textField =[UITextField new];
        _textField.backgroundColor =[UIColor whiteColor];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font=[UIFont systemFontOfSize:14];
        _textField.returnKeyType =UIReturnKeyDone;
        [self.contentView addSubview:_textField];
        
        _sendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [sendbtn setBackgroundColor:IXMRGB(30, 181, 231,1)];
        [_sendbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendbtn setTitleColor:IXMRGB(100, 100, 100, 1) forState:UIControlStateNormal];
        _sendbtn.titleLabel.font =[UIFont systemFontOfSize:12];
        _sendbtn.layer.cornerRadius = 4;
        _sendbtn.layer.masksToBounds =YES;
        _sendbtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3,10);
        _sendbtn.hidden=YES;
        [self.contentView addSubview:_sendbtn];
        
//        [sumitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        
    
        
        
    }
    
    return self;
}

- (void)setString:(NSString *)dataString
     andIndexPath:(NSIndexPath *)indexPath{
    _textField.text = dataString;
}


- (void)setPlaceholderString:(NSString *)dataString
                   andIndexPath:(NSIndexPath *)indexPath{
    // 核心代码
    _textField.placeholder = dataString;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.ispwd) {
        _textField.secureTextEntry =YES;
    }
    
    if (self.isshowbtn) {
        _sendbtn.hidden = NO;
    }
    
    [_sendbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(24);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(IXMSDKScreenWith-30);
 
    }];
    

}

@end
