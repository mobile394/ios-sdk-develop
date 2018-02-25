# Configuration

## Introduction

The ownCloud iOS SDK provides a flexible mechanism for configuration. While it currently only returns the default values defined by the classes itself, MDM and branding support can be added in the future with relatively little effort.

This document provides an overview over the available sections and variables.

## Connection

**Section ID**: `connection`

**Variables**:
	- `endpoint-capabilities`: Endpoint to use for retrieving server capabilities
		- type: string
		- default: `/ocs/v1.php/cloud/capabilities`
	- `endpoint-webdav`: Endpoint to use for WebDAV
		- type: string
		- default: `remote.php/webdav`
	- `connection-insert-x-request-id`: Send a unique, random UUID in the `X-Request_ID` HTTP header with every request to enable server-side tracing ([Details](https://github.com/owncloud/ios-sdk/issues/1))
		- type: boolean
		- default: `true`

## OAuth2

**Section ID**: `authentication-oauth2`
**Variables**:
	- `oa2-authorization-endpoint`: OAuth2 authorization endpoint
		- type: string
		- default: `index.php/apps/oauth2/authorize`
	- `oa2-token-endpoint`: OAuth2 token endpoint
		- type: string
		- default: `index.php/apps/oauth2/api/v1/token`
	- `oa2-redirect-uri`: OAuth2 Redirect URI
		- type: string
		- default: `oc://ios.owncloud.com`
	- `oa2-client-id`: OAuth2 Client ID
		- type: string
		- default: `mxd5OQDk6es5LzOzRvidJNfXLUZS2oN3oUFeXPP8LpPrhx3UroJFduGEYIBOxkY1`
	- `oa2-client-secret`: OAuth2 Client Secret
		- type: string
		- default: `KFeFWWEZO9TkisIQzR3fo7hfiMXlOpaqP8CFuTbSHzV1TUuGECglPxpiVKJfOXIx`
