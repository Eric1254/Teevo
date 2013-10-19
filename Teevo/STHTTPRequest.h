//
//  STHTTPRequest.m
//  STHTTPRequest
//
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSUInteger const kSTHTTPRequestCancellationError;
extern NSUInteger const kSTHTTPRequestDefaultTimeout;

@class STHTTPRequest;

typedef void (^uploadProgressBlock_t)(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite);
typedef void (^downloadProgressBlock_t)(NSData *data, NSInteger totalBytesReceived, NSInteger totalBytesExpectedToReceive);
typedef void (^completionBlock_t)(NSDictionary *headers, NSString *body);
typedef void (^errorBlock_t)(NSError *error);

@interface STHTTPRequest : NSObject <NSURLConnectionDelegate>

@property (copy) uploadProgressBlock_t uploadProgressBlock;
@property (copy) downloadProgressBlock_t downloadProgressBlock;
@property (copy) completionBlock_t completionBlock;
@property (copy) errorBlock_t errorBlock;
@property (nonatomic) NSStringEncoding postDataEncoding;
@property (nonatomic, retain) NSDictionary *POSTDictionary; // keys and values are NSString objects
@property (nonatomic, retain) NSMutableDictionary *requestHeaders;
@property (nonatomic, readonly) NSInteger responseStatus;
@property (nonatomic, retain, readonly) NSString *responseStringEncodingName;
@property (nonatomic, retain, readonly) NSDictionary *responseHeaders;
@property (nonatomic, retain, readonly) NSURL *url;
@property (nonatomic, retain, readonly) NSMutableData *responseData;
@property (nonatomic, retain, readonly) NSError *error;
@property (nonatomic, retain) NSString *responseString;
@property (nonatomic) NSStringEncoding forcedResponseEncoding;
@property (nonatomic) BOOL encodePOSTDictionary; // default YES
@property (nonatomic, assign) NSUInteger timeoutSeconds;
@property (nonatomic) BOOL addCredentialsToURL; // default NO
@property (nonatomic) NSString *HTTPMethod; // default: GET, or POST if POSTDictionary or files to upload

+ (STHTTPRequest *)requestWithURL:(NSURL *)url;
+ (STHTTPRequest *)requestWithURLString:(NSString *)urlString;

- (NSString *)startSynchronousWithError:(NSError **)error;
- (void)startAsynchronous;
- (void)cancel;

// Cookies
+ (void)addCookieWithName:(NSString *)name value:(NSString *)value url:(NSURL *)url;
- (void)addCookieWithName:(NSString *)name value:(NSString *)value;
- (NSArray *)requestCookies;
+ (NSArray *)sessionCookies;
+ (void)deleteSessionCookies;

// Credentials
+ (NSURLCredential *)sessionAuthenticationCredentialsForURL:(NSURL *)requestURL;
- (void)setUsername:(NSString *)username password:(NSString *)password;
- (NSString *)username;
- (NSString *)password;
+ (void)deleteAllCredentials;

// Headers
- (void)setHeaderWithName:(NSString *)name value:(NSString *)value;
- (void)removeHeaderWithName:(NSString *)name;
- (NSDictionary *)responseHeaders;

// Upload
- (void)addFileToUpload:(NSString *)path parameterName:(NSString *)param;
- (void)addDataToUpload:(NSData *)data parameterName:(NSString *)param;
- (void)addDataToUpload:(NSData *)data parameterName:(NSString *)param mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

// Session
+ (void)clearSession; // delete all credentials and cookies

@end

@interface NSError (STHTTPRequest)
- (BOOL)st_isAuthenticationError;
- (BOOL)st_isCancellationError;
@end

@interface NSString (RFC3986)
- (NSString *)st_stringByAddingRFC3986PercentEscapesUsingEncoding:(NSStringEncoding)encoding;
@end
