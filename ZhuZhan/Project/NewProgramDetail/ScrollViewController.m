//
//  ScrollViewController.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-11.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView* myScrollView;
@end

@implementation ScrollViewController


//-(NSMutableArray *)imagesArray{
//    if (!_imagesArray) {
//        _imagesArray=[NSMutableArray array];
//        for (int i=0; i<8; i++) {
//            UIImage* image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG",i]];
//            [_imagesArray addObject:image];
//        }
//    }
//    return _imagesArray;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static int number=0;//从第二张图开始

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x>=320+320+320||scrollView.contentOffset.x<=320) {
        
        if (scrollView.contentOffset.x>=320+320+320){
            number++;
        }else if (scrollView.contentOffset.x<=320){
            number--;
        }
        
        NSMutableArray* array=[NSMutableArray array];
        for (int i=0; i<5; i++) {
            NSInteger a=number-2+i;
            NSInteger b;
            if (a>=0) {
                b=a%self.imagesArray.count;
            }else{
                b=(self.imagesArray.count+a%self.imagesArray.count)%self.imagesArray.count;
            }
            
            UIImage* image=self.imagesArray[b];
            [array addObject:image];
        }
        for (int i=0; i<5; i++) {
            UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 568-64)];
            imageView.image=array[i];
            [self.myScrollView addSubview:imageView];
        }
        
        [self.myScrollView scrollRectToVisible:CGRectMake(320+320, 0, 320, 568-64) animated:NO];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.myScrollView.backgroundColor=[UIColor redColor];
    self.myScrollView.pagingEnabled=YES;
    self.myScrollView.contentSize=CGSizeMake(320*5, 568-64);
    self.myScrollView.delegate=self;
    
    
    if (self.imagesArray.count) {
        
        for (int i=0; i<5; i++) {
            NSInteger a=number-2+i;
            NSInteger b=(a>=0?a%self.imagesArray.count:((self.imagesArray.count+a%self.imagesArray.count)%self.imagesArray.count));
            
            UIImage* image=self.imagesArray[b];
            UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 568-64)];
            imageView.image=image;
            [self.myScrollView addSubview:imageView];
            
        }
        
        [self.myScrollView scrollRectToVisible:CGRectMake(320+320, 0, 320, 568-64) animated:NO];
        
        [self.view addSubview:self.myScrollView];
        
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
