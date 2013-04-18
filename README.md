Description
---

A sample app using the ordnancesurvey-ios-sdk to demonstrate Overlays.

The app is a game with the objective being to find all the overlays that are created at random locations on the map and then remove each overlay by tapping on them until none remain



![ScreenShot](https://github.com/OrdnanceSurvey/ios-sdk-demo-overlay-finder/raw/master/screenshot.png "Screenshot of demo app")


Getting started
---

#### Requirements

This project requires the following points are met:

- Minimum iOS version: 6.0.1
- Xcode version: 4.5.2
- iOS Openspace SDK version: TBC


#### Register for an OS OpenSpace API Key

Developers who wish to use the WMTS services will need to register an App Name in order to authenticate the API key in the following format:

APPLE_ID.BUNDLE_ID e.g. 12345678.com.example.find-a-postbox 

Apple App ID: This is a numerical value that is unique for each iOS app and has to be created in Apple's iOS Provisioning portal.
Bundle Identifier: This is the reverse domain name specified in Xcode, this is generated from the app name (how you name your project) and the company identifier specified. 

#### Registration Process

If you do not own a re-use data licence you can register for an API key to access [OS OpenSpace Pro] (https://www.ordnancesurvey.co.uk/oswebsite/web-services/os-openspace/pro/index.html) under a 90 day trial or a commercial re-use licence. 

If you own a data licence, for example, you are a member of the PSMA, you can register for an API key to access [OSOnDemand WMTS] (http://www.ordnancesurvey.co.uk/oswebsite/web-services/os-ondemand/pricing.html).

#### Download project

Copy the project to your local machine, eg:

<pre>
git clone https://github.com/OrdnanceSurvey/ios-sdk-demo-overlay-finder.git
</pre>

#### Download ordnancesurvey-ios-sdk

- Download the latest ordnancesurvey-ios-sdk static framework TBC 
- Unzip the SDK into the `StaticFrameworks` directory at the root of the project

<pre>
$SRCROOT/StaticFrameworks
</pre>
 

#### Update demo app with your API Key and Bundle Identifier details

Copy and paste the API Key into the demo app

Update the Bundle Identifier associated with the API Key

<pre>
//In MapViewController.m

static NSString *const kOSApiKey = @"YOUR_KEY_HERE";
static BOOL const kOSIsPro = YES;

</pre>

#### Build and run

Project can now be built and run. Have fun!

Questions and Issues
-------

If you have any questions or issues with the ordnancesurey-ios-sdk or this demo app then please email osopenspacepro@ordnancesurvey.co.uk

Licence
-------

The Ordnance Survey iOS SDK is protected by © Crown copyright – Ordnance
Survey 2013. It is subject to licensing terms granted by Ordnance Survey, the
national mapping agency of Great Britain.

The Ordnance Survey iOS SDK includes the Route-Me library. The Route-Me
library is copyright (c) 2008-2013, Route-Me Contributors All rights reserved
(subject to the BSD licence terms as follows):

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer. * Redistributions in binary
  form must reproduce the above copyright notice, this list of conditions and
  the following disclaimer in the documentation and/or other materials provided
  with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Route-Me depends on the Proj4 Library. [ http://trac.osgeo.org/proj/wiki/WikiStart ]
Proj4 is copyright (c) 2000, Frank
Warmerdam / Gerald Evenden Proj4 is subject to the MIT licence as follows:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
