# ABOverlayWindow

An easy-to-use overlay window that helps you fit your content to a grid.

![screenshot](https://raw.github.com/aaronbrethorst/ABOverlayWindow/master/screenshot.png)

## Quick Start

1. Drop `ABOverlayWindow.h` and `ABOverlayWindow.m` into your codebase.
2. Import `ABOverlayWindow` into your App Delegate.
3. Add a property of type `ABOverlayWindow` to your App Delegate.
4. Add the following code block to `-application:didFinishLaunchingWithOptions:`

    if TARGET_IPHONE_SIMULATOR
        self.overlayWindow = [[ABOverlayWindow alloc] init];
        [self.overlayWindow showWithConfiguration:nil];
    endif

## License

    Copyright (c) 2016 Aaron Brethorst

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.