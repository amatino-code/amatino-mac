//
//  Amatino Swift
//  AMCryptography.h
//
//  author: hugh@amatino.io
//

#ifndef AMCryptography_h
#define AMCryptography_h


#endif /* AMCryptography_h */

#import <Foundation/Foundation.h>

@interface AMSignature : NSObject

+ (NSString *)sha512:(NSString*)apiKey data:(NSString*)dataToHash;

@end
