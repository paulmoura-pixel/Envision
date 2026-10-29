Jonathan Conceicao
A/B Test: Daily Workout Access
A/B Test Name
Daily Workout Preview vs. Workout Navigation Button
User Story Number
US-04 — View Daily Workout Plan
Metrics
This A/B test will evaluate three categories from our team’s HEART framework:
1. Task Success 
  Workout Plan Access Rate: Percentage of users who successfully open their assigned workout after accessing the home screen.
  Time to Access Workout: Average time required for users to find and open their assigned workout.
  Workouts Logged: Number of workouts successfully recorded by users.
2. Engagement
  Daily Active Users: Number of unique users interacting with Envision each day.
  Workout Plan Views: Number of times users access their assigned workout plans.
3. Retention
  Average Logins per Week: Average number of times users return to Envision each week.
These measurements align with our HEART goals of helping trainees find their workout plans quickly, regularly interact with the application, and maintain consistent fitness tracking habits.

Hypothesis:
We believe that displaying a preview of the assigned daily workout directly on Envision’s home screen will increase the percentage of users who access their workout plans compared to requiring users to navigate through a separate workout button.
By making workout information immediately visible, we expect users to find their assigned exercises more quickly, potentially improving Task Success and Engagement.

What Problem Are We Trying to Solve, and what's Its Impact?
One of Envision’s primary goals is to simplify the fitness tracking experience by allowing trainees to quickly access personalized workout plans created by their trainers.
However, requiring users to navigate through multiple screens to locate their assigned workouts may create unnecessary friction and discourage consistent application usage.
Our HEART framework emphasizes that students should be able to quickly find their assigned workout plans and successfully log their workouts.
This experiment will help determine whether displaying workout information directly on the home screen improves accessibility and encourages users to interact with their assigned workout plans.

Experiment:
We will use Firebase Remote Config and Firebase A/B Testing to randomly assign eligible users to one of two home-screen variations.


Target Audience:
Trainees who have successfully created an Envision account and have at least one workout assigned by their trainer.

Experiment Distribution:
  50% of eligible users will see Variation A.
  50% of eligible users will see Variation B.
We will use an equal distribution to compare both designs under similar conditions.
Each user will remain assigned to the same variation throughout the experiment.


Experiment Duration:
The experiment will run for approximately two weeks, depending on the number of participating users.
Firebase Analytics Tracking:
We will track the following events:

Firebase Event  // Purpose  // HEART Category
home_screen_view  // Records when a user accesses the home screen.  // Engagement
workout_opened  // Records when a user opens their assigned workout.  // Task Success
workout_logged  // Records when a user successfully logs a workout.  // Task Success
user_login  // Records when a user successfully logs into Envision.  // Retention

Firebase Analytics will also be used to calculate DAU based on user activity.
We will measure the time between the home_screen_view and workout_opened events to evaluate how quickly users can access their assigned workout plans.

Success Criteria:
We will consider Variation B more successful if:
  1. A higher percentage of users successfully open their assigned workout plans.
  2. Users take less time to access their workouts.
  3. Workout logging activity remains consistent or improves.
We will also monitor DAU and average logins per week to identify potential changes in Engagement and Retention.
If the experiment has too few participants to produce reliable results, we will treat the findings as preliminary.

Variations: 

Variation A — Workout Navigation Button (Control)
The home screen displays a button labeled “View Today’s Workout.”
Users must select this button to navigate to their assigned workout plan.

<img src="https://raw.githubusercontent.com/paulmoura-pixel/Envision/refs/heads/main/docs/images/%20%20%20%20variation_a.png" alt="Description of the image">


Variation B — Daily Workout Preview (Test)
The home screen displays a preview of the assigned workout, including its name and exercises.
Users can select the preview to access their complete workout plan.

<img src="https://github.com/paulmoura-pixel/Envision/blob/main/docs/images/%20%20%20%20variation-b.png?raw=true" alt="Description of the image">


Expected Outcome:

We expect Variation B to improve Task Success by reducing the time required for trainees to locate their assigned workouts.
We also expect the workout preview to encourage more frequent interaction with workout plans, potentially improving Engagement.
The experiment will help our team determine which home-screen design better supports the goals established in Envision’s HEART framework.

