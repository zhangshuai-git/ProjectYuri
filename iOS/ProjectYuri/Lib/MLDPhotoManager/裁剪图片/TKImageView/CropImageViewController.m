//
//  CropImageViewController.m
//  ImageTailor
//
//  Created by yinyu on 15/10/10.
//  Copyright © 2015年 yinyu. All rights reserved.
//
#define BottomH 60
#define SCALE_FRAME_Y 100.0f
#define BOUNDCE_DURATION 0.2f // doundce_duration

#define RectGap 10
#import "CropImageViewController.h"
#import "ChooseDefImgItem.h"
#import "TKImageView.h"
#import "UIView+ZSExtension.h"
#import "AlertLabel.h"
#import "UIColor+ZSExtension.h"

#define TopBtnTag 100000

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define CROP_PROPORTION_IMAGE_WIDTH 30.0f
#define CROP_PROPORTION_IMAGE_SPACE 48.0f
#define CROP_PROPORTION_IMAGE_PADDING 20.0f
typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;
@interface CropImageViewController () {
    
    NSArray *proportionImageNameArr;
    NSArray *proportionImageNameHLArr;
//    NSArray *proportionArr;
    NSMutableArray *proportionBtnArr;
    CGFloat currentProportion;
   
    NSInteger _cropIndex;
    ChooseDefImgItem * _rightItem;
    NSMutableArray * _cropedStatus;
    
    
   
    UIImageView *_imageView;
    UIImage *_image;
    UIView * _overView;
    UIView * _imageViewScale;
    
    CGFloat lastScale;
    
    
}
@property (nonatomic, assign)CGFloat scaleRation;//图片缩放的最大倍数
@property (nonatomic, assign)CGFloat radius; //圆形裁剪框的半径
@property (nonatomic, assign)CGRect circularFrame;//裁剪框的frame
@property (nonatomic, assign)CGRect OriginalFrame;
@property (nonatomic, assign)CGRect currentFrame;


@property (nonatomic, assign)ClipType clipType;  //裁剪的形状

@property (weak, nonatomic) IBOutlet UIScrollView *cropProportionScrollView;
@property (strong, nonatomic) UIView *tkImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScroll;
@property (weak, nonatomic) IBOutlet UILabel *proportionLab;

@property (nonatomic, strong) NSArray * cropImages;

@property (nonatomic, strong) NSMutableArray * cropedImages; // 裁剪完成

@end

@implementation CropImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)cropedImages {
    if (!_cropedImages) {
        _cropedImages = [NSMutableArray arrayWithArray:self.cropImages];
    }
    return _cropedImages;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"图片裁剪";
    
    _cropIndex = 0;
     _cropedStatus = [NSMutableArray array];
 
    for (id obj in self.cropImages) {
        [_cropedStatus addObject:@0];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _rightItem = [ChooseDefImgItem itemFrame:CGRectMake(0, 0, 100, 40) title:[NSString stringWithFormat:@"完成(%d/%ld)",0,self.cropImages.count] target:self action:@selector(complainItemClick:)];
    _rightItem.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightItem];
    _navRightItem.text = [NSString stringWithFormat:@"完成(%d/%ld)",0,self.cropImages.count];
    
    
    _tkImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 147, SCREENWIDTH, SCREENHEIGHT-147-50)];
    _tkImageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tkImageView];
   
    [self CreatUI];
    [self addAllGesture];
    [self setUpCropProportionView];
    [self initControlBtn];
    [self.view bringSubviewToFront:self.topScroll];
    
    [self adjustImgAndline];
}
- (void)adjustImgAndline {
    UIView * view = _imageView;
    CGRect currentFrame = view.frame;
    //向右滑动 并且超出裁剪范围后
    if(currentFrame.origin.x >= self.circularFrame.origin.x)
    {
        currentFrame.origin.x =self.circularFrame.origin.x;
        
    }
    //向下滑动 并且超出裁剪范围后
    if(currentFrame.origin.y >= self.circularFrame.origin.y)
    {
        currentFrame.origin.y = self.circularFrame.origin.y;
    }
    //向左滑动 并且超出裁剪范围后
    if(currentFrame.size.width + currentFrame.origin.x < self.circularFrame.origin.x + self.circularFrame.size.width)
    {
        CGFloat movedLeftX =fabs(currentFrame.size.width + currentFrame.origin.x -(self.circularFrame.origin.x + self.circularFrame.size.width));
        currentFrame.origin.x += movedLeftX;
    }
    //向上滑动 并且超出裁剪范围后
    if(currentFrame.size.height+currentFrame.origin.y < self.circularFrame.origin.y + self.circularFrame.size.height)
    {
        CGFloat moveUpY =fabs(currentFrame.size.height + currentFrame.origin.y -(self.circularFrame.origin.y + self.circularFrame.size.height));
        currentFrame.origin.y += moveUpY;
    }
    [UIView animateWithDuration:0.05 animations:^{
        [view setFrame:currentFrame];
    }];
}
-(void)CreatUI
{
    
    _image = self.cropImages.firstObject;
    self.clipType = SQUARECLIP;
    self.radius = CGRectGetWidth(_tkImageView.bounds)-2;
    self.scaleRation =  10;
    lastScale = 1.0;

    
    //验证 裁剪半径是否有效
    self.radius= self.radius > _tkImageView.frame.size.width/2?_tkImageView.frame.size.width/2:self.radius;
    
    CGFloat width  = _tkImageView.frame.size.width;
    CGFloat height = (_image.size.height / _image.size.width) * _tkImageView.frame.size.width;
    
    
    _imageView = [[UIImageView alloc]init];
    [_imageView setImage:_image];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView setFrame:CGRectMake(0, 0, width, height)];
    [_imageView setCenter:CGPointMake(CGRectGetWidth(_tkImageView.bounds)/2, CGRectGetHeight(_tkImageView.bounds)/2)];
    self.OriginalFrame = _imageView.frame;
    [_tkImageView addSubview:_imageView];
    
    _imageViewScale = _imageView;
    
    //覆盖层
    _overView = [[UIView alloc]init];
    [_overView setBackgroundColor:[UIColor clearColor]];
//    _overView.opaque = NO;
    [_overView setFrame:CGRectMake(0, 0, _tkImageView.frame.size.width, _tkImageView.frame.size.height )];
    [_tkImageView addSubview:_overView];
    
//    UIButton * clipBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [clipBtn setTitle:@"裁剪" forState:UIControlStateNormal];
//    [clipBtn addTarget:self action:@selector(clipBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
//    [clipBtn setBackgroundColor:[UIColor redColor]];
//    [clipBtn setFrame:CGRectMake(0, _tkImageView.frame.size.height - 50, _tkImageView.frame.size.width, 50)];
//    [_tkImageView addSubview:clipBtn];
    _clipType = 1;
    [self drawClipPath:self.clipType];
    [self MakeImageViewFrameAdaptClipFrame];
}

//绘制裁剪框
-(void)drawClipPath:(ClipType )clipType
{
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat ScreenHeight = _tkImageView.frame.size.height;
    CGPoint center = _tkImageView.center;
    
    self.circularFrame = CGRectMake(center.x - self.radius, center.y - self.radius, self.radius * 2, self.radius * 2);
     CGRect rect = self.circularFrame;
    if (self.proportion.floatValue != 1) {
        rect.origin.y = (CGRectGetHeight(_tkImageView.bounds)-CGRectGetHeight(self.circularFrame))/2;
        rect.size.height = CGRectGetWidth(self.circularFrame)/self.proportion.floatValue;
        self.circularFrame = rect;
    }
    else {
    rect.origin.y = (_tkImageView.frame.size.height-self.radius*2)/2;
    self.circularFrame = rect;
    }
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    if(clipType == CIRCULARCLIP)
    {
        //绘制圆形裁剪区域
        [path  appendPath:[UIBezierPath bezierPathWithArcCenter:_tkImageView.center radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:NO]];
    }
    else
    {
        [path appendPath:[UIBezierPath bezierPathWithRect:rect]]; // 正方形
        UIView * line = [[UILabel alloc] initWithFrame:rect];
        line.layer.borderColor = [UIColor whiteColor].CGColor;
        line.layer.borderWidth = 1.f;
        [_overView addSubview:line];
        
    }
    [path setUsesEvenOddFillRule:YES];
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 1.f;
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    [_overView.layer addSublayer:layer];
}

//让图片自己适应裁剪框的大小
-(void)MakeImageViewFrameAdaptClipFrame
{
    CGFloat width = _imageView.frame.size.width ;
    CGFloat height = _imageView.frame.size.height;
    if(height < self.circularFrame.size.height)
    {
        width = (width / height) * self.circularFrame.size.height;
        height = self.circularFrame.size.height;
        CGRect frame = CGRectMake(0, 0, width, height);
        [_imageView setFrame:frame];
        [_imageView setCenter:CGPointMake(CGRectGetWidth(_tkImageView.bounds)/2, CGRectGetHeight(_tkImageView.bounds)/2)];
    }
}
-(void)addAllGesture
{
    //捏合手势
    UIPinchGestureRecognizer * pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinGesture:)];
    [_tkImageView addGestureRecognizer:pinGesture];
    //拖动手势
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [_tkImageView addGestureRecognizer:panGesture];
    
}

-(void)handlePinGesture:(UIPinchGestureRecognizer *)pinGesture
{
    UIView * view = _imageView;
    if(pinGesture.state == UIGestureRecognizerStateBegan || pinGesture.state == UIGestureRecognizerStateChanged)
    {
        view.transform = CGAffineTransformScale(_imageViewScale.transform, pinGesture.scale,pinGesture.scale);
        pinGesture.scale = 1.0;
    }
    else if(pinGesture.state == UIGestureRecognizerStateEnded)
    {
        lastScale = 1.0;
        CGFloat ration =  view.frame.size.width /self.OriginalFrame.size.width;
        
        if(ration>_scaleRation) // 缩放倍数 > 自定义的最大倍数
        {
            CGRect newFrame =CGRectMake(0, 0, self.OriginalFrame.size.width * _scaleRation, self.OriginalFrame.size.height * _scaleRation);
            view.frame = newFrame;
        }else if (view.frame.size.width < self.circularFrame.size.width && self.OriginalFrame.size.width <= self.OriginalFrame.size.height)
        {
            view.frame = [self handelWidthLessHeight:view];
            view.frame = [self handleScale:view];
        }
        else if(view.frame.size.height< self.circularFrame.size.height && self.OriginalFrame.size.height <= self.OriginalFrame.size.width)
        {
            view.frame =[self handleHeightLessWidth:view];
            view.frame = [self handleScale:view];
        }
        else
        {
            view.frame = [self handleScale:view];
        }
        self.currentFrame = view.frame;
    }
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    UIView * view = _imageView;
    
    if(panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [panGesture translationInView:view.superview];
        [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
        
        [panGesture setTranslation:CGPointZero inView:view.superview];
    }
    else if ( panGesture.state == UIGestureRecognizerStateEnded)
    {
        CGRect currentFrame = view.frame;
        //向右滑动 并且超出裁剪范围后
        if(currentFrame.origin.x >= self.circularFrame.origin.x)
        {
            currentFrame.origin.x =self.circularFrame.origin.x;
            
        }
        //向下滑动 并且超出裁剪范围后
        if(currentFrame.origin.y >= self.circularFrame.origin.y)
        {
            currentFrame.origin.y = self.circularFrame.origin.y;
        }
        //向左滑动 并且超出裁剪范围后
        if(currentFrame.size.width + currentFrame.origin.x < self.circularFrame.origin.x + self.circularFrame.size.width)
        {
            CGFloat movedLeftX =fabs(currentFrame.size.width + currentFrame.origin.x -(self.circularFrame.origin.x + self.circularFrame.size.width));
            currentFrame.origin.x += movedLeftX;
        }
        //向上滑动 并且超出裁剪范围后
        if(currentFrame.size.height+currentFrame.origin.y < self.circularFrame.origin.y + self.circularFrame.size.height)
        {
            CGFloat moveUpY =fabs(currentFrame.size.height + currentFrame.origin.y -(self.circularFrame.origin.y + self.circularFrame.size.height));
            currentFrame.origin.y += moveUpY;
        }
        [UIView animateWithDuration:0.05 animations:^{
            [view setFrame:currentFrame];
        }];
    }
}

//缩放结束后 确保图片在裁剪框内
-(CGRect )handleScale:(UIView *)view
{
    // 图片.right < 裁剪框.right
    if(view.frame.origin.x + view.frame.size.width< self.circularFrame.origin.x+self.circularFrame.size.width)
    {
        CGFloat right =view.frame.origin.x + view.frame.size.width;
        CGRect viewFrame = view.frame;
        CGFloat space = self.circularFrame.origin.x+self.circularFrame.size.width - right;
        viewFrame.origin.x+=space;
        view.frame = viewFrame;
    }
    // 图片.top < 裁剪框.top
    if(view.frame.origin.y > self.circularFrame.origin.y)
    {
        CGRect viewFrame = view.frame;
        viewFrame.origin.y=self.circularFrame.origin.y;
        view.frame = viewFrame;
    }
    // 图片.left < 裁剪框.left
    if(view.frame.origin.x > self.circularFrame.origin.x)
    {
        CGRect viewFrame = view.frame;
        viewFrame.origin.x=self.circularFrame.origin.x;
        view.frame = viewFrame;
    }
    // 图片.bottom < 裁剪框.bottom
    if((view.frame.size.height +view.frame.origin.y) < (self.circularFrame.origin.y + self.circularFrame.size.height))
    {
        CGRect viewFrame = view.frame;
        CGFloat space = self.circularFrame.origin.y + self.circularFrame.size.height - (view.frame.size.height +view.frame.origin.y);
        viewFrame.origin.y +=space;
        view.frame = viewFrame;
    }
    
    return view.frame;
}

// 图片的高<宽 并且缩放后的图片高小于裁剪框的高
-(CGRect )handleHeightLessWidth:(UIView *)view
{
    CGRect tempFrame = view.frame;
    CGFloat rat = self.OriginalFrame.size.width / self.OriginalFrame.size.height;
    CGFloat width = self.circularFrame.size.width * rat;
    CGFloat height = self.circularFrame.size.height ;
    CGFloat  x  = view.frame.origin.x ;
    CGFloat y = self.circularFrame.origin.y;
    
    if(view.frame.origin.x > self.circularFrame.origin.x)
    {
        x = self.circularFrame.origin.x;
    }
    else if ((view.frame.origin.x+view.frame.size.width) < self.circularFrame.origin.x + self.circularFrame.size.width)
    {
        x = self.circularFrame.origin.x + self.circularFrame.size.width - width ;
    }
    
    CGRect newFrame =CGRectMake(x, y, width,height);
    view.frame = newFrame;
    
    if((tempFrame.origin.x > self.circularFrame.origin.x &&(tempFrame.origin.x+tempFrame.size.width) < self.circularFrame.origin.x + self.circularFrame.size.width))
    {
        [view setCenter:_tkImageView.center];
    }
    
    if((tempFrame.origin.y > self.circularFrame.origin.y &&(tempFrame.origin.y+tempFrame.size.height) < self.circularFrame.origin.y + self.circularFrame.size.height))
    {
        [view setCenter:CGPointMake(tempFrame.size.width/2 + tempFrame.origin.x, view.frame.size.height /2)];
    }
    return  view.frame;
}

//图片的宽<高 并且缩放后的图片宽小于裁剪框的宽
-(CGRect)handelWidthLessHeight:(UIView *)view
{
    CGFloat rat = self.OriginalFrame.size.height / self.OriginalFrame.size.width;
    CGRect tempFrame = view.frame;
    
    CGFloat width = self.circularFrame.size.width;
    CGFloat height = self.circularFrame.size.height * rat ;
    
    CGFloat  x  = self.circularFrame.origin.x ;
    CGFloat y = view.frame.origin.y;
    
    if(view.frame.origin.y > self.circularFrame.origin.y)
    {
        y = self.circularFrame.origin.y;
    }
    else if ((view.frame.origin.y+view.frame.size.height) < self.circularFrame.origin.y + self.circularFrame.size.height)
    {
        y = self.circularFrame.origin.y + self.circularFrame.size.height - height ;
    }
    CGRect newFrame =CGRectMake(x, y, width,height);
    view.frame = newFrame;
    
    if((tempFrame.origin.y > self.circularFrame.origin.y &&(tempFrame.origin.y+tempFrame.size.height) < self.circularFrame.origin.y + self.circularFrame.size.height))
    {
        [view setCenter:_tkImageView.center];
        
    }
    if((tempFrame.origin.x > self.circularFrame.origin.x &&(tempFrame.origin.x+tempFrame.size.width) < self.circularFrame.origin.x + self.circularFrame.size.width))
    {
        [view setCenter:CGPointMake(view.frame.size.width/2, tempFrame.size.height /2 + tempFrame.origin.y)];
    }
    return  view.frame;
}

-(void)clipBtnSelected:(UIButton *)btn
{
  
}

//修复图片显示方向问题
-(UIImage *)fixOrientation:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//方形裁剪
-(UIImage *)getSmallImage
{
    CGFloat width= _imageView.frame.size.width;
    CGFloat rationScale = (width /_image.size.width);
    
    CGFloat origX = (self.circularFrame.origin.x - _imageView.frame.origin.x) / rationScale;
    CGFloat origY = (self.circularFrame.origin.y - _imageView.frame.origin.y) / rationScale;
    CGFloat oriWidth = self.circularFrame.size.width / rationScale;
    CGFloat oriHeight = self.circularFrame.size.height / rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    CGImageRef  imageRef = CGImageCreateWithImageInRect(_image.CGImage, myRect);
    UIGraphicsBeginImageContext(myRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myRect, imageRef);
    UIImage * clipImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    
    if(self.clipType == CIRCULARCLIP)
        return  [self CircularClipImage:clipImage];
    
    return clipImage;
}

//圆形图片
-(UIImage *)CircularClipImage:(UIImage *)image
{
    CGFloat arcCenterX = image.size.width/ 2;
    CGFloat arcCenterY = image.size.height / 2;
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddArc(context, arcCenterX , arcCenterY, image.size.width/ 2 , 0.0, 2*M_PI, NO);
    CGContextClip(context);
    CGRect myRect = CGRectMake(0 , 0, image.size.width ,  image.size.height);
    [image drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

#pragma mark ***************************** 裁剪操作之后 *****************

- (void)initControlBtn {
    
    UIView * bottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-BottomH, SCREENWIDTH, BottomH)];
    [self.view addSubview:bottom];
    bottom.backgroundColor = [UIColor blackColor];
    
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREENWIDTH - 100.0f*2)/2, 0, 100, 50)];
    confirmBtn.backgroundColor = [UIColor blackColor];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
//    [confirmBtn setTitle:@"裁剪" forState:UIControlStateNormal];
    [confirmBtn setImage:[UIImage imageNamed:@"裁剪"] forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    [confirmBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [confirmBtn.titleLabel setNumberOfLines:0];
    [confirmBtn setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    [confirmBtn addTarget:self action:@selector(cropButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:confirmBtn];
    confirmBtn.center = CGPointMake(CGRectGetWidth(bottom.bounds)/2.0, CGRectGetHeight(bottom.bounds)/2);
}


- (void)cropButtonClicked {
    
//    if ([[_cropedStatus objectAtIndex:_cropIndex] integerValue] > 0) {
//        [AlertLabel alertLabelShowInView:self.view WithTitle:@"该图已裁剪"];
//        return;
//    }
    
    UIImage * currenCropImg = [self getSmallImage];
   
    //
        UIButton * btn = [self.topScroll viewWithTag:TopBtnTag+_cropIndex];
        [btn setImage:currenCropImg forState:UIControlStateNormal];
    [self.cropedImages replaceObjectAtIndex:_cropIndex withObject:currenCropImg];
    [_cropedStatus replaceObjectAtIndex:_cropIndex withObject:@1];
    
//        [self initCropSetting];
    _image = currenCropImg;
    _imageView.image = currenCropImg;
    [self topBtnClick:btn];
    
        [AlertLabel alertLabelShowInView:self.view WithTitle:@"裁剪完成！"];
        int i = 0;
        for (NSNumber * obj in _cropedStatus) {
            if (obj.integerValue > 0) {
                i++;
            }
        }
    _navRightItem.text = [NSString stringWithFormat:@"完成(%d/%ld)",i,self.cropImages.count];
    _rightItem.title = [NSString stringWithFormat:@"完成(%d/%ld)",i,self.cropImages.count];

}

+ (instancetype)coreImages:(NSArray *)images proportion:(NSNumber *)proportion coreComplainBlock:(void(^)(NSArray * images))coredBlock cancelBlick:(void(^)(void))cancelBlock {
    CropImageViewController * vc = [[CropImageViewController alloc] initWithNibName:@"CropImageViewController" bundle:nil];
    vc.cropImages = images;
    vc.proportion = proportion;
    vc.coredBlock = coredBlock;
    vc.cancelBlock = cancelBlock;
    return vc;
}

- (IBAction)backClick:(UIButton *)sender {
    if(self.cancelBlock) {
        self.cancelBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBtnClick:(UIButton *)btn {
    for (int i = 0; i<self.cropImages.count; i++) {
        UIButton * button = [self.topScroll viewWithTag:TopBtnTag+i];
        if (button == btn) {
            _cropIndex = i;
           
            button.backgroundColor = [UIColor lightGrayColor];
            
            _image = [self.cropImages objectAtIndex:i];
            _imageView.image = _image;
            
            
             button.layer.borderColor = UIColor.main.CGColor;
        }
        else
        {
             button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.backgroundColor = [UIColor whiteColor];
        }
    }
}


- (void)setUpCropProportionView {
    
    for (int i= 0; i< self.cropImages.count; i++) {
        UIButton * button = [[UIButton alloc] init];
        
    
        button.frame = CGRectMake(8+i*(82+16), 0, 82, 82);
        
        [self.topScroll addSubview:button];
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        [button setImage:[self.cropImages objectAtIndex:i] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.backgroundColor = [UIColor whiteColor];
        if (!i) {
            button.backgroundColor = [UIColor lightGrayColor];
              button.layer.borderColor = UIColor.main.CGColor;
        }
        button.tag = TopBtnTag + i;
        [button addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    
}
- (void)clickProportionBtn: (UIButton *)proportionBtn {
    
    for(UIButton *btn in proportionBtnArr) {
        btn.selected = NO;
    }
    proportionBtn.selected = YES;
//    NSInteger index = [proportionBtnArr indexOfObject:proportionBtn];
//    currentProportion = [_proportionArr[index] floatValue];
    
//    _tkImageView.cropAspectRatio = currentProportion;
    
}
#pragma mark - IBActions
- (IBAction)clickCancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated: NO];
}
- (IBAction)complainItemClick:(id)sender {
//    if (self.cropedImages.count < self.cropImages.count) {
//        [AlertLabel alertLabelShowInView:[UIApplication sharedApplication].keyWindow WithTitle:@"还有未完成图片"]; return;
//    }
//    else {
        if (self.coredBlock) {
            self.coredBlock(self.cropedImages);
    
        }
        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    
    

    
}
#pragma mark 裁剪
//- (IBAction)cropClick:(UIButton *)sender {
//    UIImage * cropdImage = [_tkImageView currentCroppedImage];
//    
//    UIButton * btn = [self.topScroll viewWithTag:TopBtnTag+_cropIndex];
//    [btn setImage:cropdImage forState:UIControlStateNormal];
//    
//    [self.cropedImages replaceObjectAtIndex:_cropIndex withObject:cropdImage];
//    [_cropedStatus replaceObjectAtIndex:_cropIndex withObject:@1];
// 
//    
//    [AlertLabel alertLabelShowInView:self.view WithTitle:@"裁剪完成！"];
//    int i = 0;
//    for (NSNumber * obj in _cropedStatus) {
//        if (obj.integerValue > 0) {
//            i++;
//        }
//    }
//    _navRightItem.text = [NSString stringWithFormat:@"完成(%ld/%ld)",i,self.cropImages.count];
//    _rightItem.title = [NSString stringWithFormat:@"完成(%ld/%ld)",i,self.cropImages.count];
//}

@end
