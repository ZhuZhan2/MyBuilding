//
//  ConditionsView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-1.
//
//

#import "ConditionsView.h"

@implementation ConditionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+(ConditionsView *)setFram:(ConditionsModel *)model{
    ConditionsView *conditionsView = [[ConditionsView alloc] init];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    contentLabel.font = tfont;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.lineBreakMode =NSLineBreakByCharWrapping ;
    contentLabel.text = model.a_searchConditions;
    //给一个比较大的高度，宽度不变
    CGSize size =CGSizeMake(230,1000);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[model.a_searchConditions boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    if(conditionsView.frame.size.height <44){
        contentLabel.frame =CGRectMake(80,(44-actualsize.height)/2, actualsize.width, actualsize.height);
    }else{
        contentLabel.frame =CGRectMake(80,5, actualsize.width, actualsize.height);
    }
    conditionsView.frame = CGRectMake(0,0, 320, actualsize.height+10);
    [conditionsView addSubview:contentLabel];
    
    UIImageView *image = [[UIImageView alloc] init];
    if(conditionsView.frame.size.height <44){
        image.frame = CGRectMake(0, 43, 320, 1);
    }else{
        image.frame = CGRectMake(0, actualsize.height+9, 320, 1);
    }
    [image setBackgroundColor:[UIColor lightGrayColor]];
    [conditionsView addSubview:image];
    [image setAlpha:0.5];
    return conditionsView;
}
@end
