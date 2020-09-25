package com.gmail.plasmanutdev

import android.content.Context
import android.content.SharedPreferences

class SharedPrefs(context: Context) {

    private val fileName = "notifications_preference"
    private val prefs: SharedPreferences = context.getSharedPreferences(fileName, Context.MODE_PRIVATE)

    fun writeScheduleNotification(id: Int, json: String) {

        with(prefs.edit()) {
            putString("$id", json).apply()
        }
    }

    fun writeDailyNotification(id: Int, json: String) {

        with(prefs.edit()) {
            putString("$id", json).apply()
        }
    }

    fun writeWeeklyNotification(id: Int, json: String) {

        with(prefs.edit()) {
            putString("$id", json).apply()
        }
    }

    fun delete(id: Int) {
        with(prefs.edit()) {
            remove("$id").apply()
        }
    }

    fun getAll(): MutableMap<String, *>? {
        return prefs.all
    }

    fun getNotification(id: Int): String? {
        return prefs.getString("$id", "")
    }
}