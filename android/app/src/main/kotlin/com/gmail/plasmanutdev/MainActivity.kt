package com.gmail.plasmanutdev

import android.app.*
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.BitmapFactory
import android.graphics.Color
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import androidx.core.app.NotificationCompat
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*


class MainActivity : FlutterActivity() {

    private val notificationMethod = "notification_method"
    private val channelId = "scheduled_notifications"

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        createNotificationChannel()
    }

    override fun onStart() {
        super.onStart()

        createNotificationChannel()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, notificationMethod).setMethodCallHandler { call, result ->
            if (call.method == "schedule_notification") {
                val title: String? = call.argument<String>("title")
                val id: Int? = call.argument<Int>("id")
                val time: Long? = call.argument<Long>("time")
                val message: String? = call.argument<String>("message")
                if (title != null && id != null && time != null && message != null) {
                    scheduleNotification(title, message, id, time)
                    result.success("Worked!")
                } else {
                    when {
                        message == null -> {
                            result.error("no_message", "message is null", "message must not be null")
                        }
                        time == null -> {
                            result.error("no_time", "time is null", "time must not be null")
                        }
                        title == null -> {
                            result.error("no_title", "title is null", "title must not be null")
                        }
                        id == null -> {
                            result.error("no_id", "id is null", "id must not be null")
                        }
                        else -> {
                            result.error("unknown_error", "unknown error", "unknown error")
                        }
                    }
                }
            } else if (call.method == "daily_notification") {
                val title: String? = call.argument<String>("title")
                val id: Int? = call.argument<Int>("id")
                val hour: Int? = call.argument<Int>("hour")
                val minute: Int? = call.argument<Int>("minute")
                val time: Long? = call.argument<Long>("time")
                val message: String? = call.argument<String>("message")
                if (title != null && id != null && hour != null && minute != null && time != null && message != null) {
                    dailyNotification(title, message, id, hour, minute, time)
                    result.success("Success")
                } else {
                    when {
                        title == null -> {
                            result.error("no_title", "title is null", "title must not be null")
                        }
                        message == null -> {
                            result.error("no_message", "message is null", "message must not be null")
                        }
                        id == null -> {
                            result.error("no_id", "id is null", "id must not be null")
                        }
                        hour == null -> {
                            result.error("no_hour", "hour is null", "hour must not be null")
                        }
                        minute == null -> {
                            result.error("no_minute", "minute is null", "minute must not be null")
                        }
                        time == null -> {
                            result.error("no_time", "time is null", "time must not be null")
                        }
                        else -> {
                            result.error("unknown_error", "unknown_error", "unknown_error")
                        }
                    }
                }
            } else if (call.method == "weekly_notification") {
                val title: String? = call.argument<String>("title")
                val id: Int? = call.argument<Int>("id")
                val hour: Int? = call.argument<Int>("hour")
                val minute: Int? = call.argument<Int>("minute")
                val day: String? = call.argument<String>("day")
                val time: Long? = call.argument<Long>("time")
                val message: String? = call.argument<String>("message")
                if (title != null && id != null && hour != null && minute != null && day != null && time != null && message != null) {
                    weeklyNotification(title, message, id, hour, minute, DAYS.valueOf(day).convert, time)
                    result.success("Success")
                } else {
                    when {
                        title == null -> {
                            result.error("no_title", "title is null", "title must not be null")
                        }
                        message == null -> {
                            result.error("no_message", "message is null", "message must not be null")
                        }
                        id == null -> {
                            result.error("no_id", "id is null", "id must not be null")
                        }
                        hour == null -> {
                            result.error("no_hour", "hour is null", "hour must not be null")
                        }
                        minute == null -> {
                            result.error("no_minute", "minute is null", "minute must not be null")
                        }
                        day == null -> {
                            result.error("no_day", "day is null", "day must not be null")
                        }
                        time == null -> {
                            result.error("no_time", "time is null", "time must not be null")
                        }
                        else -> {
                            result.error("unknown_error", "unknown_error", "unknown_error")
                        }
                    }
                }
            } else if (call.method == "cancel_notification") {
                val id: Int? = call.argument<Int>("id")
                if (id != null) {
                    cancelNotification(id)
                    result.success("Canceled")
                } else {
                    result.error("no_id", "id is null", "id cannot be null")
                }
            } else {
                result.notImplemented()
            }
        }

    }

    private fun createNotificationChannel() {
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
            val notificationManager: NotificationManager =
                    getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun scheduleNotification(title: String, message: String, id: Int, time: Long) {

        val notificationIntent = Intent(this, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id))

        val alarmIntent = PendingIntent.getBroadcast(this, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager =
                this.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        enableReceiver()

        val calendar = Calendar.getInstance().apply {
            timeInMillis = time
        }

        if (alarmIntent != null && alarmManager != null) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, alarmIntent)
        }

        val gson = Gson()

        val notificationModel = NotificationModel(title, id, 0, 0, 0, time, NotificationsType.oneShot, message)

        val json = gson.toJson(notificationModel)

        SharedPrefs(this).writeScheduleNotification(id, json)

    }

    private fun dailyNotification(title: String, message: String, id: Int, hour: Int, minute: Int, time: Long) {

        val notificationIntent = Intent(this, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id))

        val calendar: Calendar = Calendar.getInstance().apply {
            timeInMillis = time
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
        }

        val alarmIntent = PendingIntent.getBroadcast(this, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager = this.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        enableReceiver()

        if (alarmManager != null && alarmIntent != null) {
            alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, AlarmManager.INTERVAL_DAY, alarmIntent)
        }

        val gson = Gson()

        val notificationModel = NotificationModel(title, id, hour, minute, 0, time, NotificationsType.daily, message)

        val json = gson.toJson(notificationModel)

        SharedPrefs(this).writeDailyNotification(id, json)

    }

    private fun weeklyNotification(title: String, message: String, id: Int, hour: Int, minute: Int, day: Int, time: Long) {

        val notificationIntent = Intent(this, NotificationReceiver::class.java)

        notificationIntent.putExtra("notification-id", id)
        notificationIntent.putExtra("notification", buildNotification(title, message, id))


        val calendar: Calendar = Calendar.getInstance().apply {
            timeInMillis = time
        }

        val alarmIntent = PendingIntent.getBroadcast(this, id, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val alarmManager = this.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

        enableReceiver()

        if (alarmManager != null && alarmIntent != null) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, alarmIntent)
        }

        val gson = Gson()

        val notificationModel = NotificationModel(title, id, hour, minute, day, time, NotificationsType.weekly, message)

        val json = gson.toJson(notificationModel)

        SharedPrefs(this).writeWeeklyNotification(id, json)

    }

    private fun cancelNotification(id: Int) {
        val alarmManager = this.getSystemService(Context.ALARM_SERVICE) as? AlarmManager


        val pendingIntent =
                PendingIntent.getBroadcast(this, id, getAlarmIntent(), 0)

        if (alarmManager != null && pendingIntent != null) {
            alarmManager.cancel(pendingIntent)
        }
        val sharedPrefs = SharedPrefs(this)
        val notification = sharedPrefs.getNotification(id)
        sharedPrefs.delete(id)
    }

    private fun getAlarmIntent(): Intent {
        return Intent(this, NotificationReceiver::class.java)
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

    private fun enableReceiver() {
        val receiver = ComponentName(context, NotificationReceiver::class.java)

        context.packageManager.setComponentEnabledSetting(
                receiver,
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
        )
    }

}