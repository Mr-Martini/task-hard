package com.gmail.plasmanutdev

import android.app.Notification
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationManagerCompat


class NotificationReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent?) {

        val notification: Notification? = intent!!.getParcelableExtra("notification")

        val id = intent.getIntExtra("notification-id", 0)

        with(NotificationManagerCompat.from(context)) {
            if (notification != null) {
                notify(id, notification)
            }
        }

        val service = Intent(context, ScheduleNotificationOnReceiveService::class.java)
        service.putExtra("notification-id", id)
        ScheduleNotificationOnReceiveService.enqueueWork(context, service, id)
    }


}