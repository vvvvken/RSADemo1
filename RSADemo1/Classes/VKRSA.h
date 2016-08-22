//
//  VKRSA.h
//  RSADemo1
//
//  Created by vkenchen on 16/8/22.
//  Copyright © 2016年 Vkenchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKRSA : NSObject

+ (NSData *)encryptData:(NSData *)data withKey:(SecKeyRef)keyRef;

+ (NSData *)decryptData:(NSData *)data withKey:(SecKeyRef)keyRef;

@end
