//
//  VKRSAKeyHelper.h
//  RSADemo1
//
//  Created by vkenchen on 16/8/22.
//  Copyright © 2016年 Vkenchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface VKRSAKeyHelper : NSObject

+ (SecKeyRef)privateKeyOfPem:(NSString *)privateKey error:(NSError **)error;

+ (SecKeyRef)publicKeyOfPem:(NSString *)publicKey error:(NSError **)error;

@end
