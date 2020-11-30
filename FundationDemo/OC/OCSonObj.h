//
//  OCSonObj.h
//  FundationDemo
//
//  Created by jingyuan5 on 2020/11/26.
//

#import "OCFatherObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCSonObj : OCFatherObj

@property (nonatomic, weak) NSObject * forwardObj;

+ (void)objectAction;
@end

NS_ASSUME_NONNULL_END
