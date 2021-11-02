//
//  OCTableViewController.m
//  FundationDemo
//
//  Created by jingyuan5 on 2020/10/30.
//

#import "OCTableViewController.h"
#import "NSObject+Ext.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface OCTableViewController ()
@property (nonatomic, strong)NSArray *mainArray;
@end

@implementation OCTableViewController
+ (void)load {
    NSLog(@"load %s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.mainArray = @[@{@"title":@"方法调用方式",@"class":@"",@"selector":@"fundationPerform"},
                       @{@"title":@"Object方法调用",@"class":@"",@"selector":@"objectFundation"},
                       @{@"title":@"静态调用",@"class":@"",@"selector":@"1"},@{@"title":@"c函数调用",@"class":@"",@"selector":@"2"},@{@"title":@"msgSend",@"class":@"",@"selector":@"msgSendAction"},];
    
}
#pragma mark == 静态函数
static BOOL staticFundation () {
    NSLog(@"static %s",__func__);
    return YES;
}
int addFundation(int a,int b){
    NSLog(@"add %s",__func__);
    return  a+b;
}
#pragma mark == 函数调用方式
- (void)fundationPerform {
    NSLog(@"--------方法调用---------");
    //1
    [self fundetionBeInvoked];
    //2
    self.fundetionBeInvoked;
    //3
    [self performSelector:@selector(fundetionBeInvoked)];
    //4
    SEL sel = NSSelectorFromString(@"fundetionBeInvoked");
    [self performSelector:sel];
    //5
    IMP imp = [self methodForSelector:@selector(fundetionBeInvoked)];
    void (*impFunc)(id,SEL) = (void *)imp;
    impFunc(self,@selector(fundetionBeInvoked));
    //6 NSInvocation 封装方法，对应的对象，参数，的对象。
    NSMethodSignature *methSig = [self methodSignatureForSelector:@selector(fundetionBeInvoked)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methSig];
    [invocation setSelector:@selector(fundetionBeInvoked)];
    [invocation setTarget:self];
    [invocation invoke];
    
}
- (void)msgSendAction {
    NSInteger v =  ((NSInteger (*)(id, SEL,NSInteger))objc_msgSend)((id)nil, @selector(sendInt:),5);
    NSLog(@"v === %@",@(v));
}
- (NSInteger)sendInt:(NSInteger)a {
    return a*a;
}
- (void)fundetionBeInvoked {
    static int a = 0;
    a++;
    NSLog(@"%s被调用%d次",__func__,a);
}
- (void)objectFundation {
    [NSObject objectAction];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"occell" forIndexPath:indexPath];
    NSDictionary *dict = self.mainArray[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.mainArray[indexPath.row];
    NSString *classStr = [dict objectForKey:@"class"];
    if (classStr.length > 0) {
        NSString *title = [dict objectForKey:@"title"];
        Class objectClass = NSClassFromString(classStr);
        UIViewController * object = [[objectClass alloc]init];
        object.title = title;
        object.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:object animated:YES];
        return;
    }
    NSString *selectorStr = [dict objectForKey:@"selector"];
    if (selectorStr.length > 0) {
        if (selectorStr.intValue == 1) {
            staticFundation();
        }
        else if (selectorStr.intValue == 2){
            addFundation(1, 2);
        }
        else {
            SEL sel = NSSelectorFromString(selectorStr);
            if ([self canPerformAction:sel withSender:nil]) {
                [self performSelector:sel];
            }
        }
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
