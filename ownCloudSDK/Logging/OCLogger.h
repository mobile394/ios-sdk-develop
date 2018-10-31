//
//  OCLogger.h
//  ownCloudSDK
//
//  Created by Felix Schwarz on 06.03.18.
//  Copyright © 2018 ownCloud GmbH. All rights reserved.
//

/*
 * Copyright (C) 2018, ownCloud GmbH.
 *
 * This code is covered by the GNU Public License Version 3.
 *
 * For distribution utilizing Apple mechanisms please see https://owncloud.org/contribute/iOS-license-exception/
 * You should have received a copy of this license along with this program. If not, see <http://www.gnu.org/licenses/gpl-3.0.en.html>.
 *
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OCLogLevel)
{
	OCLogLevelDebug,	//!< Verbose information
	OCLogLevelDefault,	//!< Default log level
	OCLogLevelWarning,	//!< Log level for warnings
	OCLogLevelError,	//!< Log level for errors

	OCLogLevelOff		//!< No logging
};

@class OCLogWriter;

@interface OCLogger : NSObject
{
	BOOL _maskPrivateData;

	NSMutableArray<OCLogWriter *> *_writers;
	dispatch_queue_t _writerQueue;
}

@property(assign,class) OCLogLevel logLevel;
@property(assign,class) BOOL maskPrivateData;

@property(class, readonly, strong, nonatomic) OCLogger *sharedLogger;

#pragma mark - Logging
- (void)appendLogLevel:(OCLogLevel)logLevel functionName:(NSString *)functionName file:(NSString *)file line:(NSUInteger)line message:(NSString *)formatString arguments:(va_list)args;
- (void)appendLogLevel:(OCLogLevel)logLevel functionName:(NSString *)functionName file:(NSString *)file line:(NSUInteger)line message:(NSString *)formatString, ...;

+ (nullable id)applyPrivacyMask:(nullable id)object;

#pragma mark - Writers
- (void)addWriter:(OCLogWriter *)logWriter; //!< Adds a writer and opens it
- (void)pauseWritersWithIntermittentBlock:(dispatch_block_t)intermittentBlock; //!< Pauses log writing: closes all writers, executes intermittentBlock, opens all writers, resumes logging

@end

NS_ASSUME_NONNULL_END

#define OCLogDebug(format,...)   if (OCLogger.logLevel <= OCLogLevelDebug) {  [[OCLogger sharedLogger] appendLogLevel:OCLogLevelDebug   functionName:@(__PRETTY_FUNCTION__) file:@(__FILE__) line:__LINE__ message:format, ##__VA_ARGS__]; }

#define OCLog(format,...)   if (OCLogger.logLevel <= OCLogLevelDefault) {  [[OCLogger sharedLogger] appendLogLevel:OCLogLevelDefault   functionName:@(__PRETTY_FUNCTION__) file:@(__FILE__) line:__LINE__ message:format, ##__VA_ARGS__]; }

#define OCLogWarning(format,...)   if (OCLogger.logLevel <= OCLogLevelWarning) {  [[OCLogger sharedLogger] appendLogLevel:OCLogLevelWarning   functionName:@(__PRETTY_FUNCTION__) file:@(__FILE__) line:__LINE__ message:format, ##__VA_ARGS__]; }

#define OCLogError(format,...)   if (OCLogger.logLevel <= OCLogLevelError) {  [[OCLogger sharedLogger] appendLogLevel:OCLogLevelError   functionName:@(__PRETTY_FUNCTION__) file:@(__FILE__) line:__LINE__ message:format, ##__VA_ARGS__]; }

#define OCLogPrivate(obj) [OCLogger applyPrivacyMask:(obj)]
