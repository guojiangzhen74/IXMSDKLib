//
//  DLPickerView.m
//
//
//  Created by zuweizhong on 16/2/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "IXMSDKPickerView.h"

#define IXMSDKkScreenFrame                    ([UIScreen mainScreen].bounds)

#define IXMShadeViewAlphaWhenShow          0.4
#define IXMShadeViewAlphaWhenHide          0

#define IXMPickerBackViewAnimateDuration   0.3

#define IXMPickerRowHieght                 35

#define IXMPickerHeaderHieght              50

#define IXMPickerBackViewPointX            0
#define PickerBackViewPointYWhenHide    IXMSDKkScreenFrame.size.height
#define PickerBackViewPointYWhenShow    (IXMSDKkScreenFrame.size.height - PickerBackViewHieght)
#define PickerBackViewWeight            IXMSDKkScreenFrame.size.width
#define PickerBackViewHieght            (IXMPickerHeaderHieght + PickerHieght)

#define PickerPointX                    0
#define PickerPointY                    IXMPickerHeaderHieght
#define PickerWeight                    IXMSDKkScreenFrame.size.width
#define PickerHieght                    PickerViewHeightTypeMiddle

#define HeaderButtonTitleFontSize       17
#define HeaderButtonMargin              15

#define CancelButtonPointX              HeaderButtonMargin
#define CancelButtonPointY              0
#define CancelButtonWeight              50
#define CancelButtonHieght              IXMPickerHeaderHieght
#define CancelButtonTitleColor          [UIColor colorWithRed:0.26f green:0.56f blue:1.00f alpha:1.00f]

#define ConfirmButtonPointX             (PickerBackViewWeight - HeaderButtonMargin - ConfirmButtonWeight)
#define ConfirmButtonPointY             0
#define ConfirmButtonWeight             50
#define ConfirmButtonHieght             IXMPickerHeaderHieght
#define ConfirmButtonTitleColor         [UIColor colorWithRed:0.26f green:0.56f blue:1.00f alpha:1.00f]

BOOL isString(id obj) {
    return [obj isKindOfClass:[NSString class]];
}

BOOL isArray(id obj) {
    return [obj isKindOfClass:[NSArray class]];
}

typedef NS_ENUM(NSInteger, PickerViewHeightType) {
    PickerViewHeightTypeHeight  = 216,
    PickerViewHeightTypeMiddle  = 180,
    PickerViewHeightTypeLow     = 162
};

@interface IXMSDKPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, copy  ) SelectedBlock  selectedBlock;
@property (nonatomic, copy  ) NSArray        *dataSource;
@property (nonatomic, copy  ) NSString       *selectedItem;         //Single Column of the selected item
@property (nonatomic, strong) NSMutableArray *selectedItems;        //Multiple Column of the selected item
@property (nonatomic, assign) BOOL           isSingleColumn;
@property (nonatomic, assign) BOOL           isDataSourceValid;
@property (nonatomic, strong) UIView         *pickerBackView;
@property (nonatomic, strong) UIButton       *shadeView;
@property (nonatomic, strong) UIPickerView   *pickerView;
@end

@implementation IXMSDKPickerView


#pragma mark - init
- (instancetype)initWithPlistName:(NSString *)plistName
                 withSelectedItem:(id)selectedData
                withSelectedBlock:(SelectedBlock)selectedBlock {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *dataSource =[[NSArray alloc] initWithContentsOfFile:path];
    return [self initWithDataSource:dataSource
                   withSelectedItem:selectedData
                  withSelectedBlock:selectedBlock];
}

- (instancetype)initWithDataSource:(NSArray *)dataSource
                  withSelectedItem:(id)selectedData
                 withSelectedBlock:(SelectedBlock)selectedBlock {
    
    self = [super initWithFrame:IXMSDKkScreenFrame];
    if (self) {
        self.dataSource = dataSource;
        self.selectedBlock = selectedBlock;
        if (isString(selectedData)) {
            self.selectedItem = selectedData;
        } else if (isArray(selectedData)){
            self.selectedItems = [selectedData mutableCopy];
        }
        
        
        [self initData];
        [self initView];
    }
    return self;
}


#pragma mark - initData
- (void)initData {
    if (self.dataSource == nil || self.dataSource.count == 0) {
        self.isDataSourceValid = NO;
        return;
    } else {
        self.isDataSourceValid = YES;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            static Class cls;
            if (idx == 0) {
                cls = [obj class];
                
                if (isArray(obj)) {
                    weakSelf.isSingleColumn = NO;
                } else if (isString(obj)) {
                    weakSelf.isSingleColumn = YES;
                } else {
                    weakSelf.isDataSourceValid = NO;
                    return;
                }
            } else {
                if (cls != [obj class]) {
                    weakSelf.isDataSourceValid = NO;
                    *stop = YES;
                    return;
                }
                
                if (isArray(obj)) {
                    if (((NSArray *)obj).count == 0) {
                        weakSelf.isDataSourceValid = NO;
                        *stop = YES;
                        return;
                    } else {
                        for (id subObj in obj) {
                            if (!isString(subObj)) {
                                weakSelf.isDataSourceValid = NO;
                                *stop = YES;
                                return;
                            }
                        }
                    }
                }
            }
        }
    ];
    
    if (self.isSingleColumn) {
        if (self.selectedItem == nil) {
            self.selectedItem = self.dataSource.firstObject;
        }
    } else {
        BOOL isSelectedItemsValid = YES;
        for (id obj in self.selectedItems) {
            if (!isString(obj)) {
                isSelectedItemsValid = NO;
                break;
            }
        }
        
        if (self.selectedItems == nil || self.selectedItems.count != self.dataSource.count || !isSelectedItemsValid) {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSArray* componentItem in self.dataSource) {
                [mutableArray addObject:componentItem.firstObject];
            }
            self.selectedItems = [NSMutableArray arrayWithArray:mutableArray];
        }
    }
    
}

#pragma mark - initView
- (void)initView {
    [self initBackView];
    [self initPickerBackView];
    [self initPickerHeaderView];
    [self initPickerView];
}

-(void)initBackView {
    self.shadeView = [[UIButton alloc] initWithFrame:self.frame];
    self.shadeView.userInteractionEnabled = NO;
    [self.shadeView addTarget:self action:@selector(shadowViewClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shadeView.backgroundColor = [UIColor blackColor];
    self.shadeView.alpha = IXMShadeViewAlphaWhenHide;
    [self addSubview:self.shadeView];
}
-(void)shadowViewClick:(UIButton *)btn
{
    [self hide:^{
        
    }];
}
-(void)setShouldDismissWhenClickShadow:(BOOL)shouldDismissWhenClickShadow
{
    _shouldDismissWhenClickShadow = shouldDismissWhenClickShadow;
    if (shouldDismissWhenClickShadow) {
        self.shadeView.userInteractionEnabled = YES;
    }
}
- (void)initPickerBackView {
    self.pickerBackView = [[UIView alloc] initWithFrame:CGRectMake(IXMPickerBackViewPointX,
                                                                   PickerBackViewPointYWhenHide,
                                                                   PickerBackViewWeight,
                                                                   PickerBackViewHieght)
                           ];
    self.pickerBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pickerBackView];
}

- (void)initPickerHeaderView {
    CGRect cancelButtonFrame  = CGRectMake(CancelButtonPointX,
                                           CancelButtonPointY,
                                           CancelButtonWeight,
                                           CancelButtonHieght);
    
    CGRect confirmButtonFrame = CGRectMake(ConfirmButtonPointX ,
                                           ConfirmButtonPointY,
                                           ConfirmButtonWeight,
                                           ConfirmButtonHieght);
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelButtonFrame];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn = cancelButton;
    [cancelButton setTitleColor:CancelButtonTitleColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:HeaderButtonTitleFontSize];
    [self.pickerBackView addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:confirmButtonFrame];
    self.confirmBtn = confirmButton;
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:ConfirmButtonTitleColor forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:HeaderButtonTitleFontSize];
    [self.pickerBackView addSubview:confirmButton];
}

- (void)initPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(PickerPointX,
                                                                     PickerPointY,
                                                                     PickerWeight,
                                                                     PickerHieght)
                       ];
    [self.pickerBackView addSubview:self.pickerView];
    
    if (!self.isDataSourceValid)  return;
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    if (self.isSingleColumn) {
        [self.dataSource enumerateObjectsUsingBlock:^(NSString *rowItem, NSUInteger rowIdx, BOOL *stop) {
            if ([weakSelf.selectedItem isEqualToString:rowItem]) {
                [weakSelf.pickerView selectRow:rowIdx inComponent:0 animated:NO];
                *stop = YES;
            }
        }
         ];
    } else {
        [self.selectedItems enumerateObjectsUsingBlock:^(NSString *selectedItem, NSUInteger component, BOOL *stop) {
                [self.dataSource[component] enumerateObjectsUsingBlock:^(id rowItem, NSUInteger rowIdx, BOOL *stop) {
                        if ([selectedItem isEqualToString:rowItem]) {
                            [weakSelf.pickerView selectRow:rowIdx inComponent:component animated:NO];
                            *stop = YES;
                        }
                    }
                ];
            }
        ];
    }
}

#pragma mark - Action
- (void)confirm {
    [self hide:^{
        if(self.selectedBlock) {
            if (self.isSingleColumn) {
                self.selectedBlock([self.selectedItem copy]);
            } else {
                self.selectedBlock([self.selectedItems copy]);
            }
        }
    }];
}

- (void)cancel {
    [self hide:^{
        
    }];
}

- (void)hide:(void (^)(void))completion{
    [UIView animateWithDuration:IXMPickerBackViewAnimateDuration
                     animations:^{
                                    self.shadeView.alpha = IXMShadeViewAlphaWhenHide;
                                    self.pickerBackView.frame = CGRectMake(IXMPickerBackViewPointX,
                                                                           PickerBackViewPointYWhenHide,
                                                                           PickerBackViewWeight,
                                                                           PickerBackViewHieght);
                                }
                     completion:^(BOOL finished) {
                                    if (finished) {
                                        if (completion) {
                                            completion();
                                        }
                                        [self removeFromSuperview];
                                    }
                                }
    ];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:IXMPickerBackViewAnimateDuration
                     animations:^{
                                    self.shadeView.alpha = IXMShadeViewAlphaWhenShow;
                                    self.pickerBackView.frame = CGRectMake(IXMPickerBackViewPointX,
                                                                           PickerBackViewPointYWhenShow,
                                                                           PickerBackViewWeight,
                                                                           PickerBackViewHieght);
                                }
                     completion:nil
    ];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.isSingleColumn) {
        return 1;
    } else {
        return self.dataSource.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return IXMPickerRowHieght;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        return self.dataSource.count;
    } else {
        return ((NSArray*)self.dataSource[component]).count;
    }
}

#pragma mark - UIPickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        return self.dataSource[row];
    } else {
        return ((NSArray*)self.dataSource[component])[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.isSingleColumn) {
        self.selectedItem = self.dataSource[row];
    } else {
        self.selectedItems[component] = ((NSArray*)self.dataSource[component])[row];
    }
}

@end
