/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ANDROID_NV_CPU_CLIENT_H
#define ANDROID_NV_CPU_CLIENT_H

#include <utils/threads.h>
#include <utils/Errors.h>

#include "INvCpuService.h"

namespace android {

class NvCpuClient {

public:
    NvCpuClient();

    void pokeCPU(NvCpuBoostStrength strength, nsecs_t timeoutNs, nsecs_t now);
    int requestCpuFreqMaxHandle(NvCpuBoostStrength strength, long long a);
    int requestMinOnlineCpuCountHandle(int handle, long long a);
    int requestMinOnlineCpuCount(int handle, long long a, long long b);

private:
    int failedConnectionAttempts;
    nsecs_t lastConnectionAttempt;
    nsecs_t lastPoke;

    void checkAndTryReconnect(nsecs_t now);
    status_t tryBindToService();
    status_t bindToService();
    void breakConnection();

    //IPC ain't cheap.  Rate limit these calls
    static const nsecs_t MINIMUM_POKE_WAIT_NS;
    static const nsecs_t MINIMUM_CONNECTION_DELAY_NS;
    static const int MAXIMUM_CONNECTION_ATTEMPTS;

    sp<INvCpuService> mInterface;
};

};

#endif //ANDROID_NV_CPU_CLIENT_H
