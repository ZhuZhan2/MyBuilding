//
//  RequirementInfoMateialView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementInfoMateialView.h"
#import "RKViewFactory.h"
#import "PublishRequirementTitleView.h"
#import "RKShadowView.h"
@interface RequirementInfoMateialView ()<UITextViewDelegate>

@end

@implementation RequirementInfoMateialView
@synthesize bigCategory = _bigCategory;
@synthesize smallCategory = _smallCategory;
@synthesize requirementDescribe = _requirementDescribe;

+ (RequirementInfoMateialView*)mateialViewWithRequirementDescribe:(NSString*)requirementDescribe smallCategory:(NSString*)smallCategory{
    RequirementInfoMateialView* projectView = [[RequirementInfoMateialView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 375)];
    projectView.requirementDescribe = requirementDescribe;
    projectView.smallCategory = smallCategory;
    [projectView setUp];
    return projectView;
}

- (void)setUp{
    UIView* view1 = [PublishRequirementTitleView titleViewWithImageName:@"需求_标题_需求信息" title:@"需求信息"];
    UIView* view2 = [self bigCategoryView];
    UIView* view3 = [self smallCategoryView];
    UIView* view4 = [self requirementView];
    [self addSubview:[RKShadowView seperatorLineInViews:@[view1,view2,view3,view4]]];
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(view4.frame));
}

- (UIView*)bigCategoryView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"大类" assistContent:nil]];
    
    self.bigCategoryField = [self fieldWithContent:nil placeholderStr:@"请选择" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187)];
    [view addSubview:self.bigCategoryField];
    return view;
}

- (UIView*)smallCategoryView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [view addSubview:[self labelWithContent:@"分类" assistContent:nil]];
    
    self.smallCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 40, kScreenWidth-36, 0)];
    self.smallCategoryLabel.text = _smallCategory;
    self.smallCategoryLabel.font = [UIFont systemFontOfSize:17];
    self.smallCategoryLabel.textColor = RGBCOLOR(51, 51, 51);
    [RKViewFactory autoLabel:self.smallCategoryLabel maxWidth:CGRectGetWidth(self.smallCategoryLabel.frame)];
    
    [view addSubview:self.smallCategoryLabel];
    
    CGRect frame = view.frame;
    frame.size.height = CGRectGetMaxY(self.smallCategoryLabel.frame)+10;
    view.frame = frame;
    
    return view;
}

- (UIView*)requirementView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [view addSubview:[self labelWithContent:@"需求描述" assistContent:nil]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(18, 40, kScreenWidth-36, 20)];
    label.text = _requirementDescribe;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = RGBCOLOR(51, 51, 51);

    if ([label.text isEqualToString:@""]||!label.text) {
        label.text = Heng;
        label.textColor = AllNoDataColor;
    }else{
        [RKViewFactory autoLabel:label maxWidth:CGRectGetWidth(label.frame)];
    }
    
    
    self.requirementDescribeLabel = label;
    [view addSubview:label];
    
    CGRect frame = view.frame;
    frame.size.height = CGRectGetMaxY(label.frame)+10;
    view.frame = frame;
    
    return view;
}

- (void)textViewDidChange:(UITextView *)textView{
    UIView* view = [textView viewWithTag:1];
    view.hidden = textView.text.length;
}

- (UIView*)labelWithContent:(NSString*)content assistContent:(NSString*)assistContent{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 0, 20)];
    label1.font = [UIFont systemFontOfSize:16];
    label1.textColor = RGBCOLOR(132, 132, 132);
    label1.text = content;
    [RKViewFactory autoLabel:label1];
    [view addSubview:label1];
    
    UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+5, 15, 200, 20)];
    label2.font = [UIFont systemFontOfSize:16];
    label2.textColor = AllRedColor;
    label2.text = assistContent;
    [view addSubview:label2];
    
    return view;
}

- (UITextField*)fieldWithContent:(NSString*)content placeholderStr:(NSString*)placeholderStr contentColor:(UIColor*)contentColor placeholderStrColor:(UIColor*)placeholderStrColor{
    return [self fieldWithContent:content placeholderStr:placeholderStr contentColor:contentColor placeholderStrColor:placeholderStrColor width:kScreenWidth-36];
}

- (UITextField*)fieldWithContent:(NSString*)content placeholderStr:(NSString*)placeholderStr contentColor:(UIColor*)contentColor placeholderStrColor:(UIColor*)placeholderStrColor width:(CGFloat)width{
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 40, width, 20)];
    textField.font = [UIFont systemFontOfSize:17];
    textField.text = content;
    textField.placeholder = placeholderStr;
    
    if (contentColor) {
        textField.textColor = contentColor;
    }
    
    if (placeholderStrColor) {
        UILabel* placeholderLabel = [textField valueForKeyPath:@"_placeholderLabel"];
        placeholderLabel.textColor = placeholderStrColor;
    }
    
    return textField;
}

- (NSString *)bigCategory{
    return self.bigCategoryField.text;
}

- (void)setBigCategory:(NSString *)bigCategory{
    _bigCategory = bigCategory;
    self.bigCategoryField.text = bigCategory;
}

- (NSString *)smallCategory{
    return self.smallCategoryLabel.text;
}

- (void)setSmallCategory:(NSString *)smallCategory{
    _smallCategory = smallCategory;
    self.smallCategoryLabel.text = smallCategory;
}

- (NSString *)requirementDescribe{
    return self.requirementDescribeLabel.text;
}

- (void)setRequirementDescribe:(NSString *)requirementDescribe{
    _requirementDescribe = requirementDescribe;
}
@end
