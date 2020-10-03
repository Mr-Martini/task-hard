package com.gmail.plasmanutdev

import android.app.AlarmManager
import android.app.Notification
import android.app.PendingIntent
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.BitmapFactory
import android.media.RingtoneManager
import android.net.Uri
import androidx.core.app.JobIntentService
import androidx.core.app.NotificationCompat
import com.google.gson.Gson
import java.util.*

class ScheduleNotificationOnReceiveService : JobIntentService() {

    private val channelId = "scheduled_notifications"

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
                NotificationsType.weekly -> {

                }
                else -> {
                    weeklyNotification(notification.title, notification.message, notification.id, notification.hour, notification.minute, notification.day, notification.time)
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

    private fun buildNotification(title: String, message: String, id: Int): Notification {
        val defaultSound: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val pendingIntent: PendingIntent = PendingIntent.getActivity(this, id, intent, 0)

        if (title == "") {
            val notification: NotificationCompat.Builder = NotificationCompat.Builder(this, channelId)
                    .setSmallIcon(R.drawable.ic_stat_notification)
                    .setLargeIcon(BitmapFactory.decodeResource(resources, R.drawable.ic_launcher))
                    .setSound(defaultSound)
                    .setContentTitle(message)
                    .setContentText(message.take(100))
                    .setPriority(NotificationCompat.PRIORITY_HIGH)
                    .setChannelId(channelId)
                    .setContentIntent(pendingIntent)
                    .setCategory(NotificationCompat.CATEGORY_REMINDER)
                    .setVisibility(NotificationCompat.VISIBILITY_PRIVATE)
                    .setStyle(NotificationCompat.BigTextStyle()
                            .bigText(message.take(400)))
                    .setAutoCancel(true)

            return notification.build()
        }

        val notification: NotificationCompat.Builder = NotificationCompat.Builder(this, channelId)
                .setSmallIcon(R.drawable.ic_stat_notification)
                .setLargeIcon(BitmapFactory.decodeResource(resources, R.drawable.ic_launcher))
                .setSound(defaultSound)
                .setContentTitle(title)
                .setContentText(message.take(100))
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setChannelId(channelId)
                .setContentIntent(pendingIntent)
                .setCategory(NotificationCompat.CATEGORY_REMINDER)
                .setVisibility(NotificationCompat.VISIBILITY_PRIVATE)
                .setStyle(NotificationCompat.BigTextStyle()
                        .bigText(message.take(400)))
                .setAutoCancel(true)

        return notification.build()
    }

    private fun weeklyNotification(title: String, message: String, id: Int, hour: Int, minute: Int, day: Int, time: Long) {

        val notificationIntent = Intent(this, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id))

        val calendar = Calendar.getInstance()

        calendar.apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
        }

        calendar.add(Calendar.DAY_OF_MONTH, 7)


        val alarmIntent = PendingIntent.getBroadcast(this, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager = this.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        if (alarmManager != null && alarmIntent != null) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, alarmIntent)
        }

    }

}