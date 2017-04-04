//
//  ViewController.m
//  DealWithDocuments
//
//  Created by 董诗磊 on 2017/3/31.
//  Copyright © 2017年 董诗磊. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *successImage;

@end

@implementation ViewController
- (IBAction)writeAction:(id)sender {
    
    [self writeImageFileToDocument];
}
- (IBAction)showIamgeAction:(id)sender {
    
    [self readImageFileFromDocument];
    
}
- (IBAction)deleteImageAction:(id)sender {
    
    [self deleteDocument];
    
}
- (IBAction)createFilderAction:(id)sender {
    
    [self createFilder];
}
- (IBAction)writeImageToNewFilderAction:(id)sender {
    
    [self writeImageToNewFilder];
}

- (IBAction)getAllDocumentNames:(id)sender {
    
    [self getAllDocumentName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"===%@",NSHomeDirectory());
   
}

#pragma mark 获取某个目录下的所有文件名
- (void)getAllDocumentName{

    //获取需要查找的路径
  NSString * documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/DSLFilder"];
    
    NSArray * namesArray = nil;
    
    NSError * error;
    
    namesArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath error:&error];
    
    if (error) {
        
    
    }else
    {
    
        [namesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            
            if ([obj hasSuffix:@"jpg"]) {
                
                NSLog(@"=====%@",obj);

                
            }
            
        }];
    
    
    }


}

#pragma mark 给新建的文件写入一个张图片
- (void)writeImageToNewFilder{

    //新的文件的路径
    NSString * documentStr = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/DSLFilder/DSL.jpg"];
    //将图片写到沙盒中
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"1.jpg" ofType:nil];
    
    NSError * error;
    
    [[NSFileManager defaultManager ]copyItemAtPath:sourcePath toPath:documentStr error:&error];
    
    //这里用copy
    if (error) {
        
        NSLog(@"write image failed==%@",[error localizedDescription]);
        
    }else{
    
     NSLog(@"write image success");
    
    }


}

#pragma mark 在沙盒中新建一个文件夹
- (void)createFilder
{
    //沙盒文件的路径
    NSString * documentStr = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    
    //新的文件的路径
    NSString * newFilderPath = [documentStr stringByAppendingPathComponent:@"/DSLFilder"];
    
    NSFileManager * manger = [NSFileManager defaultManager];
    
    NSError * error;
    
    //创建操作
    [manger createDirectoryAtPath:newFilderPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) {
        
        NSLog(@"create filder failed == %@",[error localizedDescription]);
        
    }else{
    
        NSLog(@"create filder success");
    
    }

}

#pragma mark 删除文件操作
- (void)deleteDocument{

    //获取路径
    NSString * imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/DSL.jpg"];
    
    NSFileManager *manger = [NSFileManager defaultManager];
    
    NSError * error;
    
    [manger removeItemAtPath:imagePath error:&error];
    
    if (error) {
        
        NSLog(@"delete error == %@",[error localizedDescription]);
        
        
    }else{
    
    
        NSLog(@" delete success");
    
    }



}

#pragma mark 文件读取操作
- (void)readImageFileFromDocument{

    //获取路径
    NSString * imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/DSL.jpg"];
    
    //显示
    self.successImage.image = [UIImage imageWithContentsOfFile:imagePath];

}

#pragma mark 文件写入操作
-(void)writeImageFileToDocument {
    
    //声明一个文件管理器
    
    NSFileManager *manger = [NSFileManager defaultManager];
    
    //获取沙盒路径
    NSString * writePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    
    //文件路径
    NSString *imagePath=[writePath  stringByAppendingPathComponent:@"DSL.jpg"];
    
    if ([manger fileExistsAtPath:imagePath]) {
        
        NSLog(@" image is exist");
        
        return;
        
    }
    
    //将图片写到沙盒中
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"1.jpg" ofType:nil];
    
    NSData *iamgeData = [NSData dataWithContentsOfFile:sourcePath];
    
    if ([iamgeData writeToFile:imagePath atomically:YES]) {
        
        NSLog(@"write image success");
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
