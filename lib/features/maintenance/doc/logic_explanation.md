### Maintenance Task Logic

For the Maintenance feature, a rule-based logic is needed to compute whether a service is due. We will define an Isar model `MaintenanceTask`. 

A task becomes "due" whenever **either** of two thresholds is crossed:
1. **Mileage threshold:** `currentCarMileage >= nextDueMileage`
2. **Time threshold:** `currentDate >= nextDueDate`

#### The Logic

1. **User input:** 
   The user specifies when a service was last performed: 
   - `lastServiceDate`
   - `lastServiceMileage`
   
   The user specifies the required intervals for this task (at least one is required):
   - `mileageInterval` (e.g., every 5,000 miles)
   - `timeIntervalMonths` (e.g., every 6 months)

2. **Computed Due Thresholds:**
   These shouldn't technically be stored as persistent data fields because they can be easily derived, but for the sake of fast Isar querying and sorting by "next due", we can store them and update them whenever `lastServiceDate` or `lastServiceMileage` changes.
   - `nextDueMileage = lastServiceMileage + mileageInterval`
   - `nextDueDate = lastServiceDate + timeIntervalMonths`

3. **ReminderCalculator Class (Business Logic):**
   A dedicated Dart class (or extension) that evaluates these thresholds against the car's current state. 
   
   ```dart
   enum MaintenanceStatus {
     good,     // Not due yet
     dueSoon,  // Within 10% of mileage interval or within 30 days
     overdue   // Passed either time or mileage threshold
   }
   ```

   **Calculation Algorithm:**
   - **Step 1:** If `mileageInterval` exists, calculate `milesRemaining = nextDueMileage - currentCarMileage`.
   - **Step 2:** If `timeIntervalMonths` exists, calculate `daysRemaining = nextDueDate.difference(DateTime.now()).inDays`.
   - **Step 3 (Overdue Check):** If `milesRemaining <= 0` OR `daysRemaining <= 0`, return `MaintenanceStatus.overdue`.
   - **Step 4 (Due Soon Check):** If `milesRemaining` is less than 10% of the interval (e.g. 500 miles left on a 5000 mile interval) OR `daysRemaining <= 30`, return `MaintenanceStatus.dueSoon`.
   - **Step 5:** Otherwise, return `MaintenanceStatus.good`.

4. **Changes Required:**
   - I will rename and refactor the old `MaintenanceReminder` Isar schema to `MaintenanceTask` to match this robust logic.
   - I will create `ReminderCalculator` as a utility class or an extension on `MaintenanceTask` so the UI can just call `task.status(currentMileage)`.
