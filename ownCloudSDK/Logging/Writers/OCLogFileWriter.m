//
//  OCLogFileWriter.m
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

#import "OCLogFileWriter.h"
#import "OCAppIdentity.h"

@interface OCLogFileWriter ()
{
	int _logFileFD;
}
@end

static NSURL *sDefaultLogFileURL;

@implementation OCLogFileWriter

+ (void)setLogFileURL:(NSURL *)logFileURL
{
	sDefaultLogFileURL = logFileURL;
}

+ (NSURL *)logFileURL
{
	if (sDefaultLogFileURL == nil)
	{
		sDefaultLogFileURL = [[OCAppIdentity.sharedAppIdentity appGroupContainerURL] URLByAppendingPathComponent:@"ownCloudApp.log"];
	}

	return (sDefaultLogFileURL);
}

- (OCLogWriterIdentifier)identifier
{
	return (OCLogWriterIdentifierFile);
}

- (NSString *)name
{
	return (@"Logfile");
}

- (instancetype)initWithLogFileURL:(NSURL *)url
{
	if ((self = [super init]) != nil)
	{
		_logFileURL = url;
	}

	return (self);
}

- (instancetype)init
{
	return ([self initWithLogFileURL:[self class].logFileURL]);
}

- (NSError *)open
{
	NSError *error = nil;

	if (!_isOpen)
	{
		// Open file
		if ((_logFileFD = open((const char *)_logFileURL.path.UTF8String, O_APPEND|O_WRONLY|O_CREAT)) != -1)
		{
			_isOpen = YES;

			OCLogDebug(@"Starting logging to %@", _logFileURL.path);
		}
		else
		{
			error = [NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:nil];
		}
	}

	return (error);
}

- (NSError *)close
{
	NSError *error = nil;

	if (_isOpen)
	{
		[self appendMessage:[NSString stringWithFormat:@"-- %@: closing log file --", [NSDate date]]];

		if (close(_logFileFD) != 0)
		{
			error = [NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:nil];
		}

		_logFileFD = 0;
		_isOpen = NO;
	}

	return (error);
}

- (void)appendMessage:(NSString *)message
{
	if (_isOpen)
	{
		NSData *messageData;

		if ((messageData = [message dataUsingEncoding:NSUTF8StringEncoding]) != nil)
		{
			write(_logFileFD, messageData.bytes, (size_t)messageData.length);
		}
	}
}

@end

OCLogWriterIdentifier OCLogWriterIdentifierFile = @"file";
