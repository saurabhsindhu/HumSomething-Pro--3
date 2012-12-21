/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIButton+WebCache.h"
#import "SDWebImageManager.h"

@implementation UIButton (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    [self setImage:placeholder forState:UIControlStateNormal];

    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

//- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
//{
//    [self setImage:image forState:UIControlStateNormal];
//}

-(void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
	CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(40, 40, 60, 60));
	// or use the UIImage wherever you like
	
	//[self setImage:[UIImage imageWithCGImage:imageRef] forState:UIControlStateNormal];
	[self setImage:[self getNewCroppedImage:image] forState:UIControlStateNormal];
	CGImageRelease(imageRef);
	// [self setImage:image forState:UIControlStateNormal];

}

-(UIImage*)getNewCroppedImage:(UIImage*)croppedImage
{
	UIImage *image = croppedImage;//[UIImage imageNamed:croppedImage];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:croppedImage];
	
	// Get size of current image
	CGSize size = [image size];
	
	// Frame location in view to show original image
	[imageView setFrame:CGRectMake(0, 0, size.width, size.height)];
	//[[self view] addSubview:imageView];
	[imageView release];	
	
	// Create rectangle that represents a cropped image  
	// from the middle of the existing image
	//CGRect rect = CGRectMake(size.width / 4, size.height / 4 , 
//							 (size.width / 2), (size.height / 2));
//	
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	
	// Create bitmap image from original image data,
	// using rectangle to specify desired crop area
	CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
	UIImage *img = [UIImage imageWithCGImage:imageRef]; 
	return img;
	CGImageRelease(imageRef);
	
	// Create and show the new image from bitmap data
	//imageView = [[UIImageView alloc] initWithImage:img];
	//[imageView setFrame:CGRectMake(0, 200, (size.width / 2), (size.height / 2))];
	//[[self view] addSubview:imageView];
	//[imageView release];
}

@end
