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

@interface SEECSSICSIViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *mlast;

@property (retain, nonatomic) IBOutlet UITextField *mpenultimate;
@property (retain, nonatomic) IBOutlet UITextField *mantepenultimate;
@property (retain, nonatomic) IBOutlet UITextField *ultimateSSI;
@property (retain, nonatomic) IBOutlet UITextField *penulSSI;
@property (retain, nonatomic) IBOutlet UITextField *anteSSI;
@property (retain, nonatomic) IBOutlet UITextField *ultimateCSI;
@property (retain, nonatomic) IBOutlet UITextField *penCSI;
@property (retain, nonatomic) IBOutlet UITextField *anteCSI;

- (IBAction)saveSSICSI:(id)sender;
- (IBAction)back:(id)sender;

- (IBAction)textDidChange:(id)textField;
- (IBAction)textDidChange1:(id)textField;
- (IBAction)textDidChange2:(id)textField;



@end