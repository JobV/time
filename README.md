# JX-TIME

## Timer functioning

- Timer is at 0
-> START
- timer is created in DB and starts running (starttime << Time.now)
- jquery keeps counting up for visual effect
-> PAUSE
- pause_time << Time.now
-> STOP
- stop_time << Time.now

S1----P1______S2-----P2______S2------P2_____ST

