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


#import "NSObject+PersistanceConvenience.h"

@implementation NSObject (PersistanceConvenience)


+(id)objectUsingArchiveWithFileName:(NSString *)filename
{
    NSFileManager *fileManager;
    NSString *documentsDirectory;
    NSArray *documentsPaths;
    
    fileManager = [NSFileManager defaultManager];
    
    
    documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    documentsDirectory = [documentsPaths objectAtIndex:0];
    
    NSString *completeFilePath = [[NSString alloc] initWithString: [documentsDirectory stringByAppendingPathComponent:filename]];
    
    id anObject = nil;
    
    if ([fileManager fileExistsAtPath: completeFilePath])
    {
        anObject = [NSKeyedUnarchiver unarchiveObjectWithFile: completeFilePath];
    }
    
    return anObject;
}

-(BOOL)archiveObjectWithFileName:(NSString *)filePath
{
    NSFileManager *fileManager;
    NSString *documentsDirectory;
    NSArray *documentPaths;
    
    fileManager = [NSFileManager defaultManager];
    
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    documentsDirectory = [documentPaths objectAtIndex:0];
    
    
    NSString *completeFilePath = [[NSString alloc] initWithString: [documentsDirectory stringByAppendingPathComponent: filePath]];
    
    // Check if the file already exists
    
    BOOL result = [NSKeyedArchiver archiveRootObject:self toFile:completeFilePath];
    
    return result;
}

@end
