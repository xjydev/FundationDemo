//
//  OCTableViewController.m
//  FundationDemo
//
//  Created by jingyuan5 on 2020/10/30.
//

#import "OCTableViewController.h"
#import "NSObject+Ext.h"
@interface OCTableViewController ()
@property (nonatomic, strong)NSArray *mainArray;
@end

@implementation OCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.mainArray = @[@{@"title":@"方法调用方式",@"class":@"",@"selector":@"fundationPerform"},
                       @{@"title":@"Object方法调用",@"class":@"",@"selector":@"objectFundation"},
                       @{@"title":@"",@"class":@"",@"selector":@""},];
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
    void (*impFunc)(id) = (void *)imp;
    impFunc(self);
    //6 NSInvocation 封装方法，对应的对象，参数，的对象。
    NSMethodSignature *methSig = [self methodSignatureForSelector:@selector(fundetionBeInvoked)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methSig];
    [invocation setSelector:@selector(fundetionBeInvoked)];
    [invocation setTarget:self];
    [invocation invoke];
    
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
        SEL sel = NSSelectorFromString(selectorStr);
        if ([self canPerformAction:sel withSender:nil]) {
            [self performSelector:sel];
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
