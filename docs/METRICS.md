[HEART Framework](https://docs.google.com/presentation/d/1rfWwJxj67yAw2FiE9D9YiSAQ5DZwrGYD0avqmL6-wlw/edit?usp=sharing)

### Metric collection — Isaac Gbaba

- **Golden-path workout access CTR (Task Success):** Log `workout_cta_view` once when the assigned-workout CTA becomes visible and `workout_cta_click` when it is selected. Include `placement`, `variant`, `platform`, `app_version`, and a generated non-personal `impression_id` shared by the paired events. Do not include invite codes, client names, health details, or workout contents. In Firebase Analytics, count distinct clicked impression IDs divided by distinct viewed impression IDs, multiplied by 100, within the same date range, platform, and variant. Prevent duplicate impression events on widget rebuilds and duplicate clicks for one impression. This measures access intent; separately log `workout_opened` only after the assigned workout successfully loads, and `workout_logged` only after the database save succeeds. Create a Sprint 2 metrics PBI for these events and verify them through the published app and Analytics DebugView/Realtime before reporting results.


### Extra Metric - Paul Moura
- **Number Of Workouts Logged:** We will log the number of workouts logged per user to see our audience presence. This will allows us to see if there is a (CONTINUE)
