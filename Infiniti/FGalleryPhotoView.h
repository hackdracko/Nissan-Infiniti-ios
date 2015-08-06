/*
 
 Product is designed by MINDBITS,  trade mark registered in Mexico.
 
 
 For tecnical support:
 
 www.mindbits.com.mx
 info@mindbits.com.mx
 ventas@mindbits.com.mx
 
 All right reserved, Do not edit this file!.
 sotware product delivered and tested under standards  by pwc mexico.
 
 Warning: this product is writting in production enviroment.
 
 This is a copy of original software, administered  by an third part,  so this software its License is distributed on an "AS IS",  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. the trade mark MINDBITS is not resposable for errors or mistakes in PWC / NISSAN production enviroments. Open Sources libraries show its own conditions of distributions.
 
 */ 


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol FGalleryPhotoViewDelegate;

//@interface FGalleryPhotoView : UIImageView {
@interface FGalleryPhotoView : UIScrollView <UIScrollViewDelegate> {
	
	UIImageView *imageView;
	UIActivityIndicatorView *_activity;
	UIButton *_button;
	BOOL _isZoomed;
	NSTimer *_tapTimer;
	NSObject <FGalleryPhotoViewDelegate> *photoDelegate;
}

- (void)killActivityIndicator;

// inits this view to have a button over the image
- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;

- (void)resetZoom;

@property (nonatomic,assign) NSObject <FGalleryPhotoViewDelegate> *photoDelegate;
@property (nonatomic,readonly) UIImageView *imageView;
@property (nonatomic,readonly) UIButton *button;
@property (nonatomic,readonly) UIActivityIndicatorView *activity;

@end



@protocol FGalleryPhotoViewDelegate

// indicates single touch and allows controller repsond and go toggle fullscreen
- (void)didTapPhotoView:(FGalleryPhotoView*)photoView;

@end

