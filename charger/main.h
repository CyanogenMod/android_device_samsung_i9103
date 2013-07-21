/**************************************************************************************************
Copyright (c) 2013, Tanguy Pruvot
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:
- Redistributions of source code must retain the above copyright notice, this list of conditions
  and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions
  and the following disclaimer in the documentation and/or other materials provided with the
  distribution.
- Neither the name of the Motorola, Inc. nor the names of its contributors may be used to endorse or
  promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**************************************************************************************************/

#ifndef _CHARGER_MAIN_H
#define _CHARGER_MAIN_H

#define LOG_TAG "charger"

#define FB_XOFFT  0
#define FB_WIDTH  480
#define FB_HEIGHT 800
#define FB_SIZE   (FB_WIDTH * FB_HEIGHT)

#define DEBUG_EVENTS_STDERR      0
#define KEY_DEVICE_BUTTON_CODE   102 /* KEY_HOME */
#define DEVICE_KEYBOARD_NAME     "sec_key"
#define DEVICE_BATTERY_MSGFILTER "power_supply/battery"

#define POWERUP_MIN_VOLTAGE 3150000

#define USE_RLE_LOGO 0

/* can use led hal if system is mounted */
#define CHARGER_USE_LIBHARDWARE  0

#define ALT_SYSFS_BACKLIGHT_BRIGHTNESS "/sys/class/backlight/pwm-backlight/brightness"

#endif
