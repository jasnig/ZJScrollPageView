# ZJScrollPageView
####OC版的简单方便的集成网易新闻, 腾讯视频, 头条 等首页的滑块视图联动的效果, segmentVIew, scrollViewController

###swift版本的请点[这里](https://github.com/jasnig/ScrollPageView)
----
##使用示例效果
![滚动示例1.gif](http://upload-images.jianshu.io/upload_images/1271831-ecb291a43d1e5209.gif?imageMogr2/auto-orient/strip)![滚动示例2.gif](http://upload-images.jianshu.io/upload_images/1271831-bd679dbe86ab7404.gif?imageMogr2/auto-orient/strip)![滚动示例3.gif](http://upload-images.jianshu.io/upload_images/1271831-e094a23212160015.gif?imageMogr2/auto-orient/strip)

![滚动示例4.gif](http://upload-images.jianshu.io/upload_images/1271831-829166f3911adff6.gif?imageMogr2/auto-orient/strip)![滚动示例5.gif](http://upload-images.jianshu.io/upload_images/1271831-3f2b8dc30bf013b1.gif?imageMogr2/auto-orient/strip)![滚动示例6.gif](http://upload-images.jianshu.io/upload_images/1271831-6d37b6b5699e63a6.gif?imageMogr2/auto-orient/strip)

![滚动示例7.gif](http://upload-images.jianshu.io/upload_images/1271831-d4c09a66bd840fe4.gif?imageMogr2/auto-orient/strip)
![滚动示例8.gif](http://upload-images.jianshu.io/upload_images/1271831-c6b1d54295f4bcb1.gif?imageMogr2/auto-orient/strip)


----
### 可以简单快速灵活的实现上图中的效果

-----


### 书写思路移步
###[简书1](http://www.jianshu.com/p/b84f4dd96d0c)

## Requirements

* iOS 7.0+ 


## Installation

###直接将下载文件的ZJScrollPageView文件夹下的文件拖进您的项目中然后#import "ZJScrollPageView.h"就可以使用了 


##usage

####一. 使用ScrollPageView , 提供了各种效果的组合,但是不能修改segmentView和ContentView的相对位置,两者是结合在一起的

	- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";
    //1.必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 2.设置需要的效果分类
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    // 缩放标题
    style.scaleTitle = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 3.设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
    NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    // 4.初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style childVcs:childVcs parentViewController:self];
    // 5. 添加scrollPageView
    [self.view addSubview:scrollPageView];
}

####二 使用 ZJScrollSegmentView 和 ZJContentView, 提供相同的效果组合, 但是同时可以分离开segmentView和contentView,可以单独设置他们的frame, 使用更灵活


	- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSegmentView];
    [self setupContentView];
    
	}


###setupSegmentView
	    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 64.0, 160.0, 28.0) segmentStyle:style titles:titles titleDidClick:^(UILabel *label, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    // 自定义标题的样式
    segment.layer.cornerRadius = 14.0;
    segment.backgroundColor = [UIColor redColor];
    // 当然推荐直接设置背景图片的方式
	//    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    self.navigationItem.titleView = self.segmentView;
    
    
###setupContentView

	    NSArray *childVcs = [self setupChildVcAndTitle];
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) childVcs:childVcs segmentView:self.segmentView parentViewController:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
    
    
    
###如果您在使用过程中遇到问题, 请联系我
####QQ:854136959 邮箱: 854136959@qq.com
####如果对您有帮助,请随手给个star鼓励一下 

## License

ScrollPageView is released under the MIT license. See LICENSE for details.