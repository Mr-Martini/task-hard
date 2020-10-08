package com.gmail.plasmanutdev

import android.app.*
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.res.Resources
import android.graphics.BitmapFactory
import android.graphics.Color
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.util.Log
import androidx.core.app.JobIntentService
import androidx.core.app.NotificationCompat
import com.google.gson.Gson
import java.util.*

class ReScheduledNotificationsService : JobIntentService() {

    private val channelId = "scheduled_notifications"

    companion object {
        fun enqueueWork(context: Context, intent: Intent, jobId: Int) {
            enqueueWork(context, ReScheduledNotificationsService::class.java, jobId, intent)
        }
    }

    override fun onHandleWork(intent: Intent) {
        try {
            val notifications = SharedPrefs(this).getAll()
            if (!notifications.isNullOrEmpty()) {
                val gson = Gson()
                createNotificationChannel(this)
                enableReceiver(this)
                for ((_, value) in notifications) {
                    val notification = gson.fromJson<NotificationModel>(value as String, NotificationModel::class.java)
                    val type = notification.type
                    val title = notification.title
                    val id = notification.id
                    val day = notification.day
                    val hour = notification.hour
                    val minute = notification.minute
                    val time = notification.time
                    val message = notification.message
                    when (type) {
                        NotificationsType.oneShot -> {
                            scheduleNotification(title, message, id, time, this)
                        }
                        NotificationsType.daily -> {
                            dailyNotification(title, message, id, hour, minute, time, this)
                        }
                        else -> {
                            weeklyNotification(title, message, id, hour, minute, day, time, this)
                        }
                    }
                    Thread.sleep(200)
                }
            }
        } catch (e: Exception) {
            Log.d("error", e.toString())
        }
    }

    private fun createNotificationChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val vibrationPattern = longArrayOf(0, 250, 250, 250)
            val name = "Scheduled reminders"
            val description = "Notifications for scheduled reminders"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(channelId, name, importance)
            channel.description = description
            channel.enableLights(true)
            channel.lightColor = Color.BLUE
            channel.enableVibration(true)
            channel.vibrationPattern = vibrationPattern
            val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun scheduleNotification(title: String, message: String, id: Int, time: Long, context: Context) {

        val scheduledDate = Calendar.getInstance().apply {
            timeInMillis = time
            set(Calendar.SECOND, 0)
        }

        val calendar = Calendar.getInstance()

        if (scheduledDate.before(calendar)) {
            return
        } else {
            calendar.apply {
                timeInMillis = time
            }
        }

        val notificationIntent = Intent(context, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id, context))

        val alarmIntent = PendingIntent.getBroadcast(context, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager =
                context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        if (alarmIntent != null && alarmManager != null) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, alarmIntent)
        }

    }

    private fun dailyNotification(title: String, message: String, id: Int, hour: Int, minute: Int, time: Long, context: Context) {

        val calendar = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
        }

        val now = Calendar.getInstance()

        if (calendar.before(now)) {
            calendar.add(Calendar.DAY_OF_MONTH, 1)
        }

        val notificationIntent = Intent(context, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id, context))


        val alarmIntent = PendingIntent.getBroadcast(context, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        if (alarmManager != null && alarmIntent != null) {
            alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, AlarmManager.INTERVAL_DAY, alarmIntent)
        }

    }

    private fun weeklyNotification(title: String, message: String, id: Int, hour: Int, minute: Int, day: Int, time: Long, context: Context) {

        val calendar = Calendar.getInstance()

        while (calendar.get(Calendar.DAY_OF_WEEK) != day) {
            calendar.add(Calendar.DAY_OF_WEEK, 1)
        }


        calendar.apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
        }


        val now = Calendar.getInstance()

        if (calendar.before(now)) {
            calendar.add(Calendar.DAY_OF_MONTH, 7)
        }

        val notificationIntent = Intent(context, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id, context))

        val alarmIntent = PendingIntent.getBroadcast(context, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        if (alarmManager != null && alarmIntent != null) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, alarmIntent)
        }
    }

    private fun buildNotification(title: String, message: String, id: Int, context: Context): Notification {
        val defaultSound: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val pendingIntent: PendingIntent = PendingIntent.getActivity(context, id, intent, 0)

        val res: Resources = context.resources

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

        val notification: NotificationCompat.Builder = NotificationCompat.Builder(context, channelId)
                .setSmallIcon(R.drawable.ic_stat_notification)
                .setLargeIcon(BitmapFactory.decodeResource(res, R.drawable.ic_launcher))
                .setSound(defaultSound)
                .setContentTitle(title)
                .setContentText(message.take(100))
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setChannelId(channelId)
                .setContentIntent(pendingIntent)
                .setCategory(NotificationCompat.CATEGORY_REMINDER)
                .setVisibility(NotificationCompat.VISIBILITY_PRIVATE)
                .setStyle(NotificationCompat.BigTextStyle().bigText(message.take(400)))
                .setAutoCancel(true)

        return notification.build()
    }

    private fun enableReceiver(context: Context) {
        val receiver = ComponentName(context, NotificationReceiver::class.java)

        context.packageManager.setComponentEnabledSetting(
                receiver,
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
        )
    }

}