//
//  DownLoadViewController.m
//  base
//
//  Created by 沈雁飞 on 16/10/13.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "DownLoadViewController.h"
static NSString *imageUrl = @"Desktop/9月优化第一期相关标注/帖子详情页%20标注.png";

static NSString *downloadUrl = @"http://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u101-b13/jre-8u101-macosx-x64.dmg?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u101-b13/jre-8u101-macosx-x64.dmg&BHost=javadl.sun.com&File=jre-8u101-macosx-x64.dmg&AuthParam=1476419534_5bce046b790315822c09e20116e8f8c3&ext=.dmg";


@interface DownLoadViewController ()<NSURLConnectionDownloadDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *download;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, assign) long long fileOffset;
@property (nonatomic, strong) NSMutableDictionary *expectedWrittenDict;


@property (nonatomic, strong) NSURLConnection *connection;

@end


@implementation DownLoadViewController
{
    UIButton  *_downloadButton;
    UIImageView *_imageView;
    UISlider  *_slider;
    UILabel  *_label;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fileOffset = 0;
    self.expectedWrittenDict = [NSMutableDictionary dictionary];
    [self loadData];
    [self loadAllSubViews];
    
}

- (void)loadData{
    
}

- (void)loadAllSubViews {
    _downloadButton = [[UIButton alloc]init];
    [_downloadButton setTitle:@"开始下载" forState:UIControlStateNormal];
    [_downloadButton setTitle:@"暂停下载" forState:UIControlStateSelected];
    [_downloadButton setBackgroundColor:[UIColor greenColor]];
    _downloadButton.frame = CGRectMake(0, 100, 375, 30);
    [_downloadButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downloadButton];
    
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.frame = CGRectMake(0, 200, 375, 300);
    [self.view addSubview:_imageView];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(15, 600, 345, 10)];
    [self.view addSubview:_slider];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 620, 345, 20)];
    _label.textColor = [UIColor greenColor];
    _label.text = [NSString stringWithFormat:@"已下载 ： 0"];
    [self.view addSubview:_label];
    
    [self loadAllConstrain];
}

-(void)loadAllConstrain {
    
}

- (void)downloadButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected == YES) {
        [self testDownload2];
    }else{
//        __weak typeof(self) wSelf = self;
//        [self.download cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//            wSelf.resumeData = resumeData;
//            wSelf.download = nil;
//            
//        }];
        [self.connection cancel];
//        self.connection = nil;
    }
}

- (void)testDownload1 {
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _imageView.image = [UIImage imageWithData:data];
}

- (void)testDownload2 {
    NSURL *url = [NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *range = [NSString stringWithFormat:@"bytes=0-50"];
    NSLog(@"前%@",request.allHTTPHeaderFields);
    [request setValue:range forHTTPHeaderField:@"Range"];
    NSLog(@"后%@",request.allHTTPHeaderFields);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        _imageView.image = [UIImage imageWithData:data];
    }];
}

- (void)testDownload3 {
    NSURL *url = [NSURL URLWithString:[downloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求头
    if (self.fileOffset > 0) {
        NSString *key = [NSString stringWithFormat:@"%@",url];
        long long expectedWritten = [[self.expectedWrittenDict valueForKey:key] longLongValue];
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-%lld", self.fileOffset,expectedWritten];
        NSLog(@"前%@",request.allHTTPHeaderFields);
        [request setValue:range forHTTPHeaderField:@"Range"];
        NSLog(@"后%@",request.allHTTPHeaderFields);
    }
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.connection = connection;
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    __weak typeof(self) wSelf = self;
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        [wSelf.connection start];
    }];
    [queue addOperation:op];
}

-(void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    NSLog(@"%lld",totalBytesWritten);
    NSLog(@"%lld",expectedTotalBytes);
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *) destinationURL {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _downloadButton.selected = NO;
        self.fileOffset = 0;
        
    });
}
- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes {
    double written = totalBytesWritten / (double)expectedTotalBytes;
    self.fileOffset = totalBytesWritten;
    NSString *key = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    long long expectedWritten = [[self.expectedWrittenDict valueForKey:key] longLongValue];
    if (expectedWritten == 0) {
        [self.expectedWrittenDict setValue:[NSNumber numberWithLongLong:expectedTotalBytes] forKey:key];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _slider.value = written;
        _label.text = [NSString stringWithFormat:@"已下载 ： %.3f",written];
    });
    

}
#pragma mark - NSURLSession
- (void)testDownload4 {
    NSURL *url = [NSURL URLWithString:[downloadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:con delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    if (self.resumeData == nil) {
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
        self.download = downloadTask;
        [downloadTask resume];
    }else{
        self.download = [session downloadTaskWithResumeData:self.resumeData];
        [self.download resume];
    }
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    dispatch_async(dispatch_get_main_queue(), ^{
        _downloadButton.selected = NO;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if (totalBytesWritten == 0) {
        return;
    }
    double written =  totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        _slider.value = written;
        _label.text = [NSString stringWithFormat:@"已下载 ： %.3f",written];
    });
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    self.fileOffset = fileOffset;
}
@end
