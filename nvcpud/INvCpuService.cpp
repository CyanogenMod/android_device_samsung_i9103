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

#define LOG_TAG "NvCpuService"

#include <stdint.h>
#include <sys/types.h>

#include <binder/Parcel.h>
#include <binder/IMemory.h>
#include <binder/IPCThreadState.h>
#include <binder/IServiceManager.h>

#include "INvCpuService.h"

namespace android {

class BpNvCpuService : public BpInterface<INvCpuService> {
public:
    BpNvCpuService(const sp<IBinder>& impl)
        : BpInterface<INvCpuService>(impl)
    { }

    virtual status_t pokeCPU(NvCpuBoostStrength strength, nsecs_t timeoutNs)
    {
        Parcel data, reply;
        data.writeInterfaceToken(INvCpuService::getInterfaceDescriptor());
        data.writeInt32(strength);
        data.writeInt64(timeoutNs);
        return remote()->transact(BnNvCpuService::POKE_CPU, data, &reply, IBinder::FLAG_ONEWAY);
    }
};

IMPLEMENT_META_INTERFACE(NvCpuService, "android.INvCpuService") ;

status_t BnNvCpuService::onTransact(
    uint32_t code, const Parcel& data, Parcel* reply, uint32_t flags)
{
    switch(code) {
        case POKE_CPU: {
            CHECK_INTERFACE(INvCpuService, data, reply);
            status_t res = pokeCPU((NvCpuBoostStrength)data.readInt32(), (nsecs_t)data.readInt64());
            reply->writeInt32(res);
        } break;
        default:
            return BBinder::onTransact(code, data, reply, flags);
    }
    return NO_ERROR;
}


}; //namespace android
