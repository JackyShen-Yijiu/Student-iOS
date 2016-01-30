//
//  GBTagListView.m
//  升级版流式标签支持点击
//
//  Created by 张国兵 on 15/8/16.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "GBTagListView.h"
#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f
#define KBtnTag            1000
#define R_G_B_16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]


@interface GBTagListView ()
@property (nonatomic,assign) CGFloat tagListViewH;
@end

@implementation GBTagListView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _tagArr = [[NSMutableArray alloc]init];
        
    }
    return self;
    
}

-(void)setTagWithTagArray:(NSArray*)arr listWidth:(float)width listHeight:(listHeighBlock)listHeight{
    
    previousFrame = CGRectZero;
    self.tagListViewH = 0;
    
    [_tagArr removeAllObjects];
    [_tagArr addObjectsFromArray:arr];

    NSLog(@"setTagWithTagArray:%@",self);
    
    for (int i = 0; i<arr.count; i++) {
        
        NSDictionary *tagDict = arr[i];
        
        NSString *_id = tagDict[@"_id"];
        NSString *color = tagDict[@"color"];
        NSString *tagname = tagDict[@"tagname"];
        NSString *tagtype = tagDict[@"tagtype"];
      
        NSLog(@"设置color:%@",color);
        
        UIButton*tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.frame = CGRectZero;
        
        if(_signalTagColor){
            //可以单一设置tag的颜色
            tagBtn.backgroundColor=_signalTagColor;
        }else{
            //tag颜色多样
            tagBtn.backgroundColor=[UIColor whiteColor];
        }
        if(_canTouch){
            tagBtn.userInteractionEnabled=YES;
            
        }else{
            tagBtn.userInteractionEnabled=NO;
        }
        [tagBtn setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
//        [tagBtn setTitleColor:R_G_B_16(color) forState:UIControlStateSelected];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagBtn setTitle:tagname forState:UIControlStateNormal];
//        [tagBtn setTitle:tagname forState:UIControlStateSelected];
        tagBtn.tag=KBtnTag+i;
        tagBtn.layer.cornerRadius=3;
        tagBtn.layer.borderColor=[UIColor colorWithHexString:color].CGColor;
        tagBtn.layer.borderWidth=0.3;
        tagBtn.clipsToBounds=YES;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
        CGSize Size_str=[tagname sizeWithAttributes:attrs];
        Size_str.width += HORIZONTAL_PADDING*3;
        Size_str.height += VERTICAL_PADDING*3;
        
        CGRect newRect = CGRectZero;
        
        if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + LABEL_MARGIN > width) {
            
            newRect.origin = CGPointMake(10, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
            self.tagListViewH += Size_str.height + BOTTOM_MARGIN;
        }
        else {
            newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            
        }
        newRect.size = Size_str;
        [tagBtn setFrame:newRect];
        previousFrame=tagBtn.frame;
//        [self setHight:self andHight:self.totalHeight+Size_str.height + BOTTOM_MARGIN];
        [self addSubview:tagBtn];
        
    }
    
    if(_GBbackgroundColor){
        self.backgroundColor = _GBbackgroundColor;
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
    
    listHeight(self.tagListViewH+BOTTOM_MARGIN*2);
    
    
}
//#pragma mark-改变控件高度
//- (void)setHight:(UIView *)view andHight:(CGFloat)hight
//{
//    CGRect tempFrame = view.frame;
//    tempFrame.size.height = hight;
//    view.frame = tempFrame;
//}

-(void)tagBtnClick:(UIButton*)button{
    button.selected=!button.selected;
    if(button.selected==YES){
        
        button.backgroundColor=[UIColor orangeColor];
    }else if (button.selected==NO){
        button.backgroundColor=[UIColor whiteColor];
    }
    
    [self didSelectItems];
    
    
}
-(void)didSelectItems{
    
    NSMutableArray*arr=[[NSMutableArray alloc]init];
    for(UIView*view in self.subviews){
        
        if([view isKindOfClass:[UIButton class]]){
            
            UIButton*tempBtn=(UIButton*)view;
            if (tempBtn.selected==YES) {
                [arr addObject:_tagArr[tempBtn.tag-KBtnTag]];
            }
            
        }
        
    }

    self.didselectItemBlock(arr);
    
}
@end
