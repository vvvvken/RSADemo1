//
//  ViewController.m
//  RSADemo1
//
//  Created by vkenchen on 16/8/22.
//  Copyright © 2016年 Vkenchen. All rights reserved.
//

#import "ViewController.h"
#import "VKRSAKeyHelper.h"
#import "VKRSA.h"

static NSString* testPrivateKeyPem = @"-----BEGIN PRIVATE KEY-----\
MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAL8VQpM6fdMV21Wa\
lERf933AWzNGGndab3Jdw1R1+MW4hq7oqH/5GJ7YmNBA637zU4jTTzPv+NGO7+tk\
mHYgyaDB/7NE2509WvoSBq0yrWqsNCq16OgExJvtlb5Q9Bt9mFbsirz1tIHmGc8I\
6iOv01O5nD+qgmmC17CCu9UegaBnAgMBAAECgYA9JaSEULdrERd7MVg4+SzNxPxq\
UAiwIPSA+JhFMutE+mO/HRyutxu12UItgljZ6yvUISq7SBOrm74S6cIQKzXZ+UnT\
wYLs9Y57zMeowYuQ+M9x6C9x7aaqpzzfBQ6yVjFzQenWqbSPLh3X+eN7ZGJpDcOz\
MvnXdXecX2Ox42gEYQJBAPddsSrzRtYCkKRtLwgdcd3z6DA4mwT1jUXhjTuGbZEU\
f8zjaimV0f85uvLsbpk3djzVLBY4Ain9vjaA4MaIHwsCQQDFwKiof59L6VBXDFCx\
kKxvhYMf9yv6k7qNPtU3cJ3M1DEenWeN7Htt0hag0BZadNW4xt6RvSqQ3gaGPGdX\
nA2VAkB/gx2LzWIreaEEEYBYB42l41BCYzuN3+JWLoG2OIKMceu7O1ODYkag8Sps\
hPIyKwPZMe4K+g4rhTCjOeYkkRCnAkBxe2sOLxbSMFT7b0TLcVOTOBIUgPqK9MXk\
kn83LnhP+CEsCXZIusHmNt7ncCKzzEJtpCpLhjvsII2r8PP5EcO1AkA4RA3aoQbY\
RlQ7GXeQjsH6erpyOIWBYbQg34T2Zr+D/BkQUTLawoozDhUSdTtMqC5cdYV3ICXl\
pFpgnvqP7ASJ\
-----END PRIVATE KEY-----";

static NSString* testPublicKeyPem = @"-----BEGIN PUBLIC KEY-----\
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC/FUKTOn3TFdtVmpREX/d9wFsz\
Rhp3Wm9yXcNUdfjFuIau6Kh/+Rie2JjQQOt+81OI008z7/jRju/rZJh2IMmgwf+z\
RNudPVr6EgatMq1qrDQqtejoBMSb7ZW+UPQbfZhW7Iq89bSB5hnPCOojr9NTuZw/\
qoJpgtewgrvVHoGgZwIDAQAB\
-----END PUBLIC KEY-----";

@interface ViewController ()

@property(nonatomic,retain) NSData*     encryptData;

@property(nonatomic,retain) NSString*   privateKeyPem;
@property(nonatomic,retain) NSString*   publicKeyPem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError* error = nil;
    NSString* privateKeyPemFile = [[NSBundle mainBundle]pathForResource:@"rsa_private_key_pkcs8" ofType:@"pem"];
    _privateKeyPem = [NSString stringWithContentsOfFile:privateKeyPemFile encoding:NSUTF8StringEncoding error:&error];
    
    if(error)
    {
        NSLog(@"error:%@",error.localizedDescription);
    }
    
    NSString* publicKeyPemFile = [[NSBundle mainBundle]pathForResource:@"rsa_public_key" ofType:@"pem"];
    _publicKeyPem = [NSString stringWithContentsOfFile:publicKeyPemFile encoding:NSUTF8StringEncoding error:&error];
    
    if(error)
    {
        NSLog(@"error:%@",error.localizedDescription);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onEncrypt:(id)sender {
    
    //准备原始数据
    NSString* originString = @"Hello VKRSA";
    NSData* originData = [originString dataUsingEncoding:NSUTF8StringEncoding];
    
    //准备公钥
    NSError* error = nil;
    SecKeyRef publicKey = [VKRSAKeyHelper publicKeyOfPem:_publicKeyPem error:&error];
    if(error || publicKey == nil)
    {
        NSLog(@"omg,there is an error :%@",error?error.localizedDescription:@"public key fail");
        return ;
    }
    
    _encryptData = [VKRSA encryptData:originData withKey:publicKey];
}
- (IBAction)onDecrypt:(id)sender {
    
    //准备私钥
    NSError* error = nil;
    SecKeyRef privateKey = [VKRSAKeyHelper privateKeyOfPem:_privateKeyPem error:&error];
    if(error || privateKey==nil)
    {
        NSLog(@"omg,there is an error :%@",error ?error.localizedDescription:@"private key fail");
        return ;
    }
    
    NSData* originData = [VKRSA decryptData:_encryptData withKey:privateKey];
    if(originData!=nil)
    {
        NSString* orginString = [[NSString alloc]initWithData:originData encoding:NSUTF8StringEncoding];
        NSLog(@"decrypt ok,and orgin string is :%@",orginString);
    }else{
        NSLog(@"omg,there is an error during decrpting,but i dont' know why");
    }
}

@end
