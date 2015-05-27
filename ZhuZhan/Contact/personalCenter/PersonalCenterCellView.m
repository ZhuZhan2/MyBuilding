//
//  PersonalCenterCellView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-28.
//
//
#import "PersonalCenterCellView.h"
@implementation PersonalCenterCellView
+(UIView *)getPersonalCenterCellViewWithImageUrl:(NSString *)imageUrl content:(NSString *)content category:(NSString *)category name:(NSString *)name{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    NSLog(@"%@",category);
    //分割线上的图片路径
    NSString* path;
    //category对应的动态名称
    NSString* newCategory;
    if([category isEqualToString:@"Personal"]){
        path=@"人脉－个人中心_05a";
        newCategory=@"个人";
    }else if([category isEqualToString:@"Company"]){
        path=@"人脉－个人中心_07a";
        newCategory=@"企业";
    }else if([category isEqualToString:@"Product"]){
        path=@"人脉－个人中心_06a";
        newCategory=@"产品";
    }
    //动态描述部分
    UIView* contentView=[self getContentViewWithImageUrl:imageUrl content:content category:newCategory name:name];
    
    //竖分割线
//    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 2, contentView.frame.size.height+20)];
//    [lineImage setBackgroundColor:[UIColor blackColor]];
//    [view addSubview:lineImage];
//    lineImage.alpha = 0.08;
//    
//    //小icon
//    UIImageView *stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 18.5, 12, 13)];
//    [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_05a"]];
//    [view addSubview:stageImage];
//    stageImage.image=[GetImagePath getImagePath:path];
//    
//    //小箭头
//    UIImageView* arrowsImage=[[UIImageView alloc]initWithFrame:CGRectMake(contentView.frame.origin.x-7, 19, 7, 12)];
//    arrowsImage.image=[GetImagePath getImagePath:@"人脉－个人中心_10a"];
//    [view addSubview:arrowsImage];
    
    [view addSubview:contentView];
    view.frame=CGRectMake(0, 0, 320, contentView.frame.size.height+10);
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    cutLine.backgroundColor = RGBCOLOR(217, 217, 217);
    [view addSubview:cutLine];
    
    UIImageView *cutLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, contentView.frame.size.height-1, 320, 1)];
    cutLine1.backgroundColor = RGBCOLOR(217, 217, 217);
    [view addSubview:cutLine1];
    return view;
}

+(UIView *)getContentViewWithImageUrl:(NSString *)imageUrl content:(NSString *)content category:(NSString *)category name:(NSString *)name{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor whiteColor];
    
    CGFloat contentX=20;
    BOOL imageExist = ![imageUrl isEqualToString:@""];
    if (imageExist) {
        UIImageView* imageView=[[UIImageView alloc]init];
        imageView.frame=CGRectMake(20, 10, 60, 60);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]] placeholderImage:[GetImagePath getImagePath:@"公司认证员工_05a"]];
        [view addSubview:imageView];
        contentX=90;
    }
    
    //动态内容contentLabel
    UILabel* contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    
    UIFont* font=[UIFont systemFontOfSize:13];
    contentLabel.numberOfLines=0;
    //提醒动态更新部分reminderLabel
    UILabel* reminderLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    
   // if (imageExist) {
        CGSize size=[content boundingRectWithSize:CGSizeMake(320-contentX-10, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        contentLabel.frame=CGRectMake(contentX, 8, 320-contentX-10, size.height>47?47:size.height);
        reminderLabel.frame=CGRectMake(contentX, imageExist?47+8+1:contentLabel.frame.size.height+8+5, contentLabel.frame.size.width, 15);
    //}
    //动态label设置
    contentLabel.font=font;
    NSLog(@"category === > %@",category);
    if([category isEqualToString:@"产品"]){
        contentLabel.text=name;
    }else{
        contentLabel.text=content;
    }
    [view addSubview:contentLabel];
    
    //提醒label设置
    category=[NSString stringWithFormat:@"我的%@动态有新评论",category];
    NSMutableAttributedString* reminderStr=[[NSMutableAttributedString  alloc]initWithString:category];
    [reminderStr addAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(148, 148, 148)} range:NSMakeRange(0, category.length-3)];
    [reminderStr addAttributes:@{NSForegroundColorAttributeName:BlueColor} range:NSMakeRange(category.length-3, 3)];
    reminderLabel.attributedText=reminderStr;
    reminderLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:reminderLabel];
    

    view.frame=CGRectMake(0, 0, 320, imageExist?80:reminderLabel.frame.origin.y+reminderLabel.frame.size.height+5);
    view.layer.cornerRadius=2;
    return view;
}

@end
