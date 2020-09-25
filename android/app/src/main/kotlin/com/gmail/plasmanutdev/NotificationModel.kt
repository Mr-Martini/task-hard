package com.gmail.plasmanutdev

class NotificationModel(title: String, id: Int, hour: Int, minute: Int, day: Int, time: Long, type: NotificationsType, message: String) {

    var title: String = "ddsf"
    var id: Int = 4
    var hour: Int = 0
    var minute: Int = 0
    var day: Int = 1
    var time: Long = 0
    var type: NotificationsType = NotificationsType.oneShot
    var message: String = "message"

    init {
        this.title = title
        this.id = id
        this.hour = hour
        this.minute = minute
        this.day = day
        this.time = time
        this.type = type
        this.message = message
    }
}