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
#import "RSA.h"

static NSString* testPrivateKeyPem = @"-----BEGIN PRIVATE KEY-----\
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDIxqmcAe6XPIMo\
ocN6fs86AcvriCFnoAXYmhTSMaQMZ3M26RNrYFn6zKc8q4yGi9pQJT+84WeHSE1b\
UCuF0KrOWeE2JrM1n5zL5FYnkEKQ7kRossy9JNUnMrD7XkQWYbjelYumDLYkkE+/\
UHUf9fvRyeSI4nI6cqKQ0k6sVoUj+TZisaXRFgetRZrBydAxV0ZBZ0EvayzjvVuG\
PaReVp9FKuBUcRiFdLMz/2Ogfo1irX7OHx+Tx9DpoW5Vj+qxnBccXRWNvZKRu21F\
6cbz91+OomGa0pysUJ1xG+DbfzKClktlZWm+mdv1PN+eDodKrvuOrFdd6rneY8/y\
r80OqrazAgMBAAECggEAMMl9a2hYxq0wnc35ByoLRugq2hfhLiIHaaO/TXg8ibsV\
lxE548ys8LGMLcTtx7/yE6mJfGc1Vf0utvKbMNAMwUm73QG4aF5Zpn3cpY57bmZH\
fz17XLa3iOfbc6lrWBj06DlkjrvmAqqChlWRsGuAfnDVtKF56lPyxsgjz+LSRXQZ\
z7cK1xV6kn2K/EkFMSRYLrYaGAW5XkxzsF3loGc4WVAgezv4DTwWwOb113s10rZs\
k8nmiGwcdQxwysQ81duIUtRkDBBXfch4eO0RjlERWdcCBI0mrMZZ3l9NDlAW6YpL\
RZWNJGqc/uHLwER0XXzR5GEgKmH6Ap8WexpEsABVoQKBgQD0rqtvpU2aB0tiWVYO\
6mwhYaMQtbkAZU7D12pZ/nrckaA4rn2OAhx8UxQ58RT34XFxxe6zWIshdJeQG4Rt\
QUSYdQ1sFVa4RhFfHm2GfCFVxAlzwzZFR9+pzP8BGsYUrMbUjbQYl/VMFwVHmpzp\
Y0fqThetqUBDlI3SueynqjtJkQKBgQDSEBcU8PVEm8SJfq8tirtYx888e05zvU47\
p4inG7vKaK/nn1IwKpMAi0YStNhWmmuxj0+WdMbGTDVzb1FwtKPZiaw971pmxqxq\
DPfpafP51H54qPUS3UNeJQzrn2WFZgkAPZTBZ9kvogzrbWzhZ77I1GCR7A8q9z05\
MiCQNW46AwKBgE7QbJxbzLFOpDObvyKy0/20q4fYYS0FdOeUXcd7NywRJGDdo8e4\
WmCZiixXwX9O+PHC5e6TGM2/9ooOswtWOLg7DAXCodpdh37yGCl3lm0/5iOJv9N1\
IVBandFHRIKoXKtesaIyYGsQBz1XSi/LMQECApKHsBGUqlI0XUxsgwhhAoGAFD9i\
yizzpzpQdmRUpFIj/sm7qvvDsxpDKTLb1CezMS5oDi5oMKZZ5wqFpZXy6F4YFVRX\
+oulAUYlPMw1EGUJChXgGVQx5Ygu5EX9u2zwDFu0GRNIFBppvPBbT3bcxT/xjClj\
ZkUJRTMchbDVduCWHiuCZ25Wg/Cy4Ql45A2SY1sCgYAr6Z67YLIjloZQYJxKlDAl\
wHLNjMt2FD04Nq+8Gbr9j2YNQg3VQsffpIBG/RzQtUkQk++d8G/djn1smgkmjpUL\
inaJEpqVpbJXYPm5jFr1HFuD/uHQM60OT6IgSnWZANNJmTh3zKUhBaMs9n760sHK\
zxOTYLkGAkITt6vwWW1kLA==\
-----END PRIVATE KEY-----";
static NSString* testPublicKeyPem = @"-----BEGIN PUBLIC KEY-----\
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyMapnAHulzyDKKHDen7P\
OgHL64ghZ6AF2JoU0jGkDGdzNukTa2BZ+synPKuMhovaUCU/vOFnh0hNW1ArhdCq\
zlnhNiazNZ+cy+RWJ5BCkO5EaLLMvSTVJzKw+15EFmG43pWLpgy2JJBPv1B1H/X7\
0cnkiOJyOnKikNJOrFaFI/k2YrGl0RYHrUWawcnQMVdGQWdBL2ss471bhj2kXlaf\
RSrgVHEYhXSzM/9joH6NYq1+zh8fk8fQ6aFuVY/qsZwXHF0Vjb2SkbttRenG8/df\
jqJhmtKcrFCdcRvg238ygpZLZWVpvpnb9Tzfng6HSq77jqxXXeq53mPP8q/NDqq2\
swIDAQAB\
-----END PUBLIC KEY-----";

@interface ViewController ()

@property(nonatomic,retain) NSData*     encryptData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    SecKeyRef publicKey = [VKRSAKeyHelper publicKeyOfPem:testPublicKeyPem error:&error];
    if(error || publicKey == nil)
    {
        NSLog(@"omg,there is an error :%@",error?error.localizedDescription:@"public key fail");
        return ;
    }
    
    _encryptData = [VKRSA encryptData:originData withKey:publicKey];
    
    
    //_encryptData = [RSA encryptData:originData withKeyRef:publicKey];
    
}
- (IBAction)onDecrypt:(id)sender {
    
    //准备私钥
    NSError* error = nil;
    SecKeyRef privateKey = [VKRSAKeyHelper privateKeyOfPem:testPrivateKeyPem error:&error];
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
