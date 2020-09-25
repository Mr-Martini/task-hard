package com.gmail.plasmanutdev

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.app.JobIntentService
import com.google.gson.Gson
import java.util.*

class ScheduleNotificationOnReceiveService : JobIntentService() {

    companion object {
        fun enqueueWork(context: Context, intent: Intent, jobId: Int) {
            enqueueWork(context, ScheduleNotificationOnReceiveService::class.java, jobId, intent)
        }
    }

    override fun onHandleWork(intent: Intent) {
        try {
            val notificationId = intent.getIntExtra("notification-id", 0)
            val sharedPrefs = SharedPrefs(this)
            val gson = Gson()
            val notAsString = sharedPrefs.getNotification(notificationId)
            val notification = gson.fromJson<NotificationModel>(notAsString as String, NotificationModel::class.java)

            when (notification.type) {
                NotificationsType.oneShot -> {
                    sharedPrefs.delete(notification.id)
                }
                NotificationsType.daily -> {
                    val now = Calendar.getInstance()
                    now.add(Calendar.DAY_OF_MONTH, 1)

                    val date = Calendar.getInstance()
                    val hour = notification.hour
                    val minute = notification.minute
                    val message = notification.message
                    val title = notification.title
                    val id = notification.id

                    date.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DAY_OF_MONTH), hour, minute)

                    val time = date.timeInMillis

                    val notModel = NotificationModel(title, id, hour, minute, 0, time, NotificationsType.daily, message)

                    val json = gson.toJson(notModel, NotificationModel::class.java)

                    sharedPrefs.writeDailyNotification(id, json)

                }
                else -> {
                    val now = Calendar.getInstance()
                    now.add(Calendar.DAY_OF_MONTH, 7)

                    val date = Calendar.getInstance()
                    val hour = notification.hour
                    val minute = notification.minute
                    val message = notification.message
                    val title = notification.title
                    val id = notification.id

                    date.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DAY_OF_MONTH), hour, minute)

                    val time = date.timeInMillis

                    val notModel = NotificationModel(title, id, hour, minute, 0, time, NotificationsType.daily, message)

                    val json = gson.toJson(notModel, NotificationModel::class.java)

                    sharedPrefs.writeWeeklyNotification(id, json)
                }
            }

            val notifications = sharedPrefs.getAll()

            if (notifications.isNullOrEmpty()) {
                val receiver = ComponentName(this, NotificationReceiver::class.java)

                this.packageManager.setComponentEnabledSetting(
                        receiver,
                        PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                        PackageManager.DONT_KILL_APP
                )
            }

        } catch (e: Exception) {
            print(e.toString())
        }
    }

}