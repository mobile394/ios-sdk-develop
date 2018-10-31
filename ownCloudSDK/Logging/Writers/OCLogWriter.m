//
//  OCLogWriter.m
//  ownCloudSDK
//
//  Created by Felix Schwarz on 31.10.18.
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

#import "OCLogWriter.h"

@implementation OCLogWriter

@synthesize isOpen = _isOpen;

- (NSError *)open
{
	_isOpen = YES;
	return (nil);
}

- (NSError *)close
{
	_isOpen = NO;
	return (nil);
}

- (void)appendMessageWithLogLevel:(OCLogLevel)logLevel date:(NSDate *)date threadID:(uint64_t)threadID isMainThread:(BOOL)isMainThread privacyMasked:(BOOL)privacyMasked functionName:(NSString *)functionName file:(NSString *)file line:(NSUInteger)line message:(NSString *)message
{
	NSString *logLevelName = nil;
	NSString *timestampString = nil;

	static NSString *processName;
	static NSDateFormatter *dateFormatter;

	if (processName == nil)
	{
		processName = [NSProcessInfo processInfo].processName;

		dateFormatter = [NSDateFormatter new];
		dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSSZZZ";
	}

	switch (logLevel)
	{
		case OCLogLevelDefault:
			logLevelName = @"deflt";
		break;

		case OCLogLevelDebug:
			logLevelName = @"debug";
		break;

		case OCLogLevelWarning:
			logLevelName = @"WARNG";
		break;

		case OCLogLevelError:
			logLevelName = @"ERROR";
		break;

		case OCLogLevelOff:
			return;
		break;
	}

	timestampString = [dateFormatter stringFromDate:date];

	[self appendMessage:[NSString stringWithFormat:@"%@ %@[%d%@%06llu] [%@] | %@ [%@:%lu|%@]\n", timestampString, processName, getpid(), (isMainThread ? @"." : @":"), threadID, logLevelName, message, [file lastPathComponent], (unsigned long)line, (privacyMasked ? @"MASKED" : @"FULL")]];
}

- (void)appendMessage:(NSString *)message
{
	fwrite([message UTF8String], [message lengthOfBytesUsingEncoding:NSUTF8StringEncoding], 1, stdout);
	fflush(stdout);
}

@end
