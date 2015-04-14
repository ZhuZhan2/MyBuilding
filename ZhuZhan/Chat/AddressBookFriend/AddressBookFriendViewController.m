//
//  AddressBookFriendViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "AddressBookFriendViewController.h"
#import "AddressBookFriendCell.h"
#import "GetAddressBook.h"
#import "AddressBookApi.h"
@interface AddressBookFriendViewController()<AddressBookFriendCellDelegate>
@property (nonatomic, strong)NSMutableArray* phones;
@end

@implementation AddressBookFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    // [self setUpSearchBarWithNeedTableView:NO isTableViewHeader:NO];
    [self initTableView];
    [self getAddressBookWithFinishBlock:^{
        [self postPhones];
    }];
}

-(void)getAddressBookWithFinishBlock:(void(^)())block{
    GetAddressBook *addressBook = [[GetAddressBook alloc] init];
    [addressBook registerAddressBook:^(bool granted, NSError *error) {
        [addressBook.phones enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray* phoneDics=obj[@"cellPhones"];
            [phoneDics enumerateObjectsUsingBlock:^(id tObj, NSUInteger tIdx, BOOL *tStop) {
                [self.phones addObject:tObj[@"phoneNumber"]];
            }];
        }];
        if (block) {
            block();
        }
    }];
}

-(void)postPhones{
    NSLog(@"phones=%@",self.phones);
    __block NSString* tels=@"";
    [self.phones enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"phone=%@",obj);
    }];
    [self.phones enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        tels=[tels stringByAppendingString:obj];
        if (idx==self.phones.count-1) {
            return ;
        }
        tels=[tels stringByAppendingString:@","];
    }];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:tels forKey:@"tels"];
    [AddressBookApi ValidatePlatformContactsWithBlock:^(NSMutableArray *posts, NSError *error) {
        
    } dic:dic noNetWork:nil];
}

-(void)initNavi{
    self.title=@"通讯录好友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddressBookFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
    }
    AddressBookFriendCellModel* model=[[AddressBookFriendCellModel alloc]init];
    model.mainLabelText=@"用户名显示";
    model.assistStyle=arc4random()%3;
    [cell setModel:model indexPath:indexPath];
    
    return cell;
}

-(void)chooseAssistBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
    
}

-(NSMutableArray *)phones{
    if (!_phones) {
        _phones=[NSMutableArray array];
    }
    return _phones;
}
@end
