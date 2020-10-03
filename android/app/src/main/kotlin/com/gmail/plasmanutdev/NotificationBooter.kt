package com.gmail.plasmanutdev

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class NotificationBooter : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent?) {
        if (intent != null) {
            when (intent.action) {
                Intent.ACTION_BOOT_COMPLETED -> {
                    val service = Intent(context, ReScheduledNotificationsService::class.java)
                    ReScheduledNotificationsService.enqueueWork(context, service, 123)
                }
            }
        }
    }

}