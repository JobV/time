Timer.create
Moment.create(end_time: Time.parse("12:00") + 1.hour, timer_id: 1 )
Moment.create(end_time: Time.parse("12:00") - 2.hours, timer_id: 1, created_at: Time.parse("12:00") - 3.hours )
Moment.create(end_time: Time.parse("12:00") - 4.hours, timer_id: 1, created_at: Time.parse("12:00") - 5.hours )
