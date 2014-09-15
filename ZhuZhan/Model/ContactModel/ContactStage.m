//
//  ContactStage.m
//  ZhuZhan
//
//  Created by Jack on 14-9-13.
//
//

#import "ContactStage.h"

@implementation ContactStage

+(NSString *)ContactStrStage:(NSString *)str{
    NSString *string = nil;
    if([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",str] isEqualToString:@" "]){
        string = @"";
    }else{
        string = str;
    }
    return string;
}
@end
