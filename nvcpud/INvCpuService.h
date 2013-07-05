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

#ifndef ANDROID_I_NV_CPU_SERVICE_H
#define ANDROID_I_NV_CPU_SERVICE_H

#include <stdint.h>
#include <sys/types.h>

#include <utils/RefBase.h>
#include <utils/Errors.h>

#include <binder/IInterface.h>

namespace android {

enum NvCpuBoostStrength {
    NVCPU_BOOST_STRENGTH_LOWEST = 0,
    NVCPU_BOOST_STRENGTH_LOW,
    NVCPU_BOOST_STRENGTH_MEDIUM_LOW,
    NVCPU_BOOST_STRENGTH_MEDIUM,
    NVCPU_BOOST_STRENGTH_MEDIUM_HIGH,
    NVCPU_BOOST_STRENGTH_HIGH,
    NVCPU_BOOST_STRENGTH_HIGHEST,
    NVCPU_BOOST_STRENGTH_COUNT
};

class NvCpuService;

class INvCpuService : public IInterface
{
public:
DECLARE_META_INTERFACE(NvCpuService) ;

    //Will time out on it's own
    //In case you crash/forget
    virtual status_t pokeCPU(NvCpuBoostStrength strength, nsecs_t timeoutNs) = 0;
};

class BnNvCpuService : public BnInterface<INvCpuService>
{
    public:
    enum {
        POKE_CPU,
    };

    virtual status_t onTransact(uint32_t code,
            const Parcel& data,
            Parcel* reply,
            uint32_t flags = 0);
};

}; // namespace android

#endif //ANDROID_I_NV_CPU_SERVICE_H
