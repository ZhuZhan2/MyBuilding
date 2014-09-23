//
//  CommentView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentView.h"
#import "EGOImageView.h"
#import "ContactCommentModel.h"
#import "ContactCommentTableViewCell.h"
@implementation CommentView
@synthesize indexpath = _indexpath;
@synthesize showArr;
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
+(CommentView *)setFram:(ActivesModel *)model{
    /*for(int i=0;i<model.a_commentsArr.count;i++){
        ContactCommentModel *commentModel = model.a_commentsArr[i];
        NSLog(@"commentModel ===> %@",commentModel.a_commentContents);
    }*/
    
    CommentView *commentView = [[CommentView alloc] init];
    CGFloat height=0;
    //上分割线
    UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 5)];
    [topLineImage setBackgroundColor:[UIColor blackColor]];
    [commentView addSubview:topLineImage];
    topLineImage.alpha =0.2;
    height+=topLineImage.frame.size.height;
    
    model.a_imageUrl=@"";
    //model.a_content=@"";
    EGOImageView *imageView;
    //动态图像
    if(![model.a_imageUrl isEqualToString:@""]){
        imageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001.png"]];
        imageView.frame = CGRectMake(5, 5, 310,[model.a_imageHeight floatValue]/[model.a_imageWidth floatValue]*310);
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_imageUrl]];
        [commentView addSubview:imageView];
        height+=imageView.frame.size.height;
    }
    
    UIView* contentTotalView;
    //动态描述
    if (![model.a_content isEqualToString:@""]) {
        UILabel* contentTextView = [[UILabel alloc] init];
        contentTextView.numberOfLines =0;
        UIFont * tfont = [UIFont systemFontOfSize:15];
        contentTextView.font = tfont;
        contentTextView.textColor = [UIColor blackColor];
        contentTextView.lineBreakMode =NSLineBreakByCharWrapping ;
        
        //用户名颜色
        NSString * text = [NSString stringWithFormat:@"%@:%@",model.a_userName,model.a_content];
        NSMutableAttributedString* attributedText=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange range=NSMakeRange(0, model.a_userName.length+1);
        [attributedText addAttributes:@{NSForegroundColorAttributeName:BlueColor} range:range];
        [attributedText addAttributes:@{NSFontAttributeName:tfont} range:NSMakeRange(0, text.length)];
        
        //动态文字内容
        contentTextView.attributedText=attributedText;
        
        
        BOOL imageUrlExist=![model.a_imageUrl isEqualToString:@""];
        //给一个比较大的高度，宽度不变
        CGSize size =CGSizeMake(imageUrlExist?300:250,CGFLOAT_MAX);
        // 获取当前文本的属性
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        //ios7方法，获取文本需要的size，限制宽度
        CGSize actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        contentTextView.frame =CGRectMake(imageUrlExist?10:60,10, actualsize.width, actualsize.height);
        
        contentTotalView=[[UIView alloc]initWithFrame:CGRectMake(5, height, 310, imageView?contentTextView.frame.size.height+20:contentTextView.frame.size.height+20+40)];
        contentTotalView.backgroundColor=[UIColor whiteColor];
        [contentTotalView addSubview:contentTextView];
        [commentView addSubview:contentTotalView];
        height+=contentTotalView.frame.size.height;
    }
    
    //评论图标
    CGFloat tempHeight=imageView?imageView.frame.origin.y+imageView.frame.size.height:height;
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(270, tempHeight-40, 37, 37);
    [commentBtn setImage:[GetImagePath getImagePath:@"人脉_66a"] forState:UIControlStateNormal];
    [commentBtn addTarget:commentView action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:commentBtn];

    //用户头像
    tempHeight=imageView?imageView.frame.origin.y:contentTotalView.frame.origin.y;
    EGOImageView* userImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001.png"]];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 3;
    userImageView.frame=CGRectMake(10,tempHeight+5,36,36);
    [commentView addSubview:userImageView];
    
    userImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_avatarUrl]];
    [commentView addSubview:userImageView];
    height+=imageView.frame.size.height;

    
    if(model.a_commentsArr.count !=0){
        int count = 0;
        if(model.a_commentsArr.count>4){
            count = 4;
        }else{
            count = model.a_commentsArr.count;
        }
        UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(85, height, 230, 50*count)];
        _tableView.delegate = commentView;
        _tableView.dataSource = commentView;
        _tableView.separatorStyle = NO;
        [commentView addSubview:_tableView];
        height += 50*count+10;
    }
    
    //设置总的frame
    commentView.frame = CGRectMake(0, 0, 320, height);
    [commentView setBackgroundColor:RGBCOLOR(239, 237, 237)];
    return commentView;
}

-(void)commentClick{
    if([self.delegate respondsToSelector:@selector(addCommentView:)]){
        [self.delegate addCommentView:_indexpath];
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexpath = indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return showArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ContactCommentTableViewCell"];
    ContactCommentModel *model = showArr[indexpath.row];
    ContactCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[ContactCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = NO;
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
