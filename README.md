# Lotel App - Core Algorithm Documentation

This document outlines the core algorithms and logic used in the Lotel Flutter application, excluding UI-specific implementation details. This is intended to aid in understanding the application's functionality for potential porting or refactoring (e.g., to React Native).

## 1. Application Initialization (`main.dart`, `backend/firebase/firebase_config.dart`)

- **Flutter Setup:** Initializes Flutter bindings and sets the URL strategy (`usePathUrlStrategy`).
- **Firebase Initialization:** Connects to Firebase using project-specific configuration (`initFirebase`).
- **State Management Setup:** Initializes the global application state (`FFAppState`) using `ChangeNotifierProvider` and loads any persisted state from `SharedPreferences`.
- **Routing:** Configures the application's navigation using `GoRouter`.
- **Authentication Listener:** Sets up a stream (`lotelFirebaseUserStream`) to listen for Firebase authentication state changes and updates the global app state accordingly.
- **Theme:** Manages the application's theme (Light/Dark mode).
- **Root Widget:** The main `MyApp` widget sets up the `MaterialApp.router` and handles basic configuration like localization and text scaling.
- **Navigation Bar:** A `NavBarPage` widget manages the main bottom navigation tabs and displays the corresponding page widget.

## 2. State Management (`app_state.dart`)

### 2.1. Core Mechanism

- **Provider Pattern:** Utilizes `ChangeNotifier` and `Provider` for managing global application state via the `FFAppState` singleton.
- **Persistence:** Key application state variables are persisted locally using `SharedPreferences`. Initialization (`initializePersistedState`) loads these values on app start.
- **Asynchronous Data Handling:** Employs `StreamRequestManager` and `FutureRequestManager` to handle fetching data from Firestore streams and futures, including caching mechanisms (e.g., `_roomsManager`, `_checkInCountManager`) to optimize performance and reduce reads. Methods like `clearRoomsCache` allow cache management.

### 2.2. Key State Variables

*(Variables persisted in SharedPreferences are marked with [P])*

- **`role` [P]:** (`String`) Current user's role (e.g., 'admin', 'staff', 'generic'). Determines access levels.
- **`hotel` [P]:** (`String`) Identifier or name of the currently selected/active hotel.
- **`bedPrice` [P]:** (`double`) The standard price for adding an extra bed to a booking.
- **`lastRemit` [P]:** (`DateTime?`) Timestamp of the last remittance calculation.
- **`statsReference` [P]:** (`DocumentReference?`) Firestore reference to the current month's `StatsRecord` document for the active hotel.
- **`currentStats` [P]:** (`CurrentStatsStruct`) A structured object holding details about the current stats period (see Section 2.3).
- **`settingRef` [P]:** (`DocumentReference?`) Firestore reference to the `HotelSettingsRecord` for the active hotel.
- **`extPricePerHr` [P]:** (`double`) Price per hour for booking extensions.
- **`lockDown` [P]:** (`bool`) A flag potentially used to restrict certain app functions.
- **`loopCounter`:** (`int`) A temporary counter variable, often used within actions or complex operations (e.g., iterating through lists).
- **`roomUsages`:** (`List<RoomUsageStruct>`) A list holding data about room usage, likely used during the creation or update of `StatsRecord` (see Section 2.3).

### 2.3. Custom Data Structures (`lib/backend/schema/structs/*`)

These structures group related data and are used within the app state and Firestore documents. They include serialization/deserialization logic (`fromSerializableMap`, `serialize`, `fromMap`, `toMap`) for storage.

- **`CurrentStatsStruct`:**
    - `year`: (`String?`) The year for the statistics period.
    - `month`: (`String?`) The month for the statistics period.
- **`RoomUsageStruct`:**
    - `number`: (`int?`) The room number.
    - `use`: (`int?`) A counter for room usage within a stats period.
- **`CartGoodsStruct`:**
    - `description`: (`String?`) Name/description of the item.
    - `quantity`: (`int?`) Quantity of the item in the cart.
    - `price`: (`double?`) Total price for this item line (quantity * unit price).
    - `previousQuantity`: (`int?`) Original stock quantity before adding to cart (used for inventory tracking).
- **`LineGraphStruct`:** (Used within `StatsRecord`)
    - `xData`: (`List<int>?`) (Data points for the x-axis, likely days of the month)
    - `yData`: (`List<int>?`) (Data points for the y-axis, likely daily income/usage)
- **`MetricsHolderStruct`:**
    - `rooms`: (`double?`) Total income from rooms.
    - `goods`: (`double?`) Total income from goods.
    - `expenses`: (`double?`) Total general expenses.
    - `salaries`: (`double?`) Total salary expenses.
    - `bills`: (`double?`) Total bill expenses.
    - `net`: (`double?`) Net income/loss.
    - `hotel`: (`String?`) Identifier for the hotel.
- **`PayPendingStruct`:**
    - `amount`: (`double?`) The amount of the pending payment.
    - `pending`: (`bool?`) Status indicating if the payment is pending.
    - `ref`: (`DocumentReference?`) Reference to the related `TransactionsRecord`.
- **`RoomPendingStruct`:**
    - `booking`: (`DocumentReference?`) Reference to the `BookingsRecord`.
    - `room`: (`int?`) The room number.
    - `total`: (`double?`) The pending amount for the room.
    - `since`: (`DateTime?`) Timestamp indicating when the pending amount started.
    - `quantity`: (`int?`) Likely related to the number of items/nights associated with the pending amount.
- **`YearlySalesStruct`:**
    - `month`: (`String?`) The month for the sales data (e.g., 'January').
    - `sales`: (`double?`) The total sales amount for that month.
- **SalaryToPrintRemittanceStruct:**
    - `handyMan`: (`String?`) Name of the handyman/recipient.
    - `pay`: (`double?`) The amount paid.
    - `remark`: (`String?`) Optional remarks about the payment.
    - `days`: (`int?`) Number of days related to the payment (if applicable).

- **Provider Pattern:** Utilizes `ChangeNotifier` and `Provider` for managing global application state via the `FFAppState` singleton.
- **Persistence:** Key application state variables (e.g., user role, selected hotel, pricing, last remittance date, settings references, lockdown status) are persisted locally using `SharedPreferences`.
- **Data Structures:** Manages complex data structures (e.g., `CurrentStatsStruct`, `RoomUsageStruct`) including serialization/deserialization for storage.
- **Asynchronous Data Handling:** Employs `StreamRequestManager` and `FutureRequestManager` to handle fetching data from Firestore streams and futures, including caching mechanisms to optimize performance and reduce reads.

## 3. Authentication (`auth/firebase_auth/auth_util.dart`, `auth/firebase_auth/firebase_auth_manager.dart`)

### 3.1. Authentication Flow & Providers

- **Core Manager:** `FirebaseAuthManager` handles all authentication operations.
- **Supported Methods:** The application supports various sign-in methods managed by specific classes within `firebase_auth_manager.dart`:
    - Email/Password (`EmailSignInManager`)
    - Google (`GoogleSignInManager`)
    - Apple (`AppleSignInManager`)
    - Anonymous (`AnonymousSignInManager`)
    - JWT Token (`JwtSignInManager`)
    - GitHub (`GithubSignInManager`)
    - Phone (`PhoneSignInManager` - includes handling verification codes and web confirmation)
- **Sign-in/Creation:** The `_signInOrCreateAccount` private method standardizes the process for different providers, linking Firebase Auth users with Firestore `UsersRecord` data.
- **Session Management:** Firebase handles session persistence automatically. The `authenticatedUserStream` (`auth_util.dart`) listens for changes in the authentication state.
- **Password Reset:** `resetPassword` function sends a password reset email.
- **Account Management:** Functions exist for updating email (`updateEmail`), password (`updatePassword`), and deleting the user account (`deleteUser`), with checks for recent login requirements.

### 3.2. User Data Access (`auth_util.dart`)

- **Firebase Authentication:** Leverages Firebase Authentication for user sign-up, sign-in, and session management.
- **User Data Access:** Provides utility functions and streams (`currentUser`, `currentUserDocument`, `authenticatedUserStream`) to access authenticated user information (UID, email, display name, photo URL, JWT token, etc.) and associated Firestore `UsersRecord` data.
- **Token Management:** Includes a stream (`jwtTokenStream`) to handle automatic refreshing of Firebase JWT tokens.

## 4. Firestore Schema (`backend/schema/*`)

Firestore is used as the primary database. The schema is defined by Dart classes in the `lib/backend/schema/` directory. Each `.dart` file generally corresponds to a Firestore collection.

**Key Collections (based on file names):**

*   **`UsersRecord`**: Stores user profile information.
    *   `email`: (`String?`)
    *   `display_name`: (`String?`)
    *   `photo_url`: (`String?`)
    *   `uid`: (`String?`) (Firebase Auth UID)
    *   `created_time`: (`DateTime?`)
    *   `phone_number`: (`String?`)
    *   `role`: (`String?`) (e.g., 'admin', 'staff')
    *   `hotel`: (`String?`)
    *   `expired`: (`bool?`)
*   **`RoomsRecord`**: Represents hotel rooms.
    *   `number`: (`int?`)
    *   `capacity`: (`int?`)
    *   `price`: (`double?`)
    *   `vacant`: (`bool?`)
    *   `guests`: (`int?`)
    *   `hotel`: (`String?`)
    *   `currentBooking`: (`DocumentReference?`) (Ref to `BookingsRecord`)
    *   `last`: (`DateTime?`)
*   **`BookingsRecord`**: Details of room bookings.
    *   `nights`: (`int?`)
    *   `total`: (`double?`)
    *   `room`: (`DocumentReference?`) (Ref to `RoomsRecord`)
    *   `details`: (`String?`)
    *   `contact`: (`String?`)
    *   `dateIn`: (`DateTime?`)
    *   `dateOut`: (`DateTime?`)
    *   `hotel`: (`String?`)
    *   `extraBeds`: (`String?`)
    *   `guests`: (`String?`)
    *   `status`: (`String?`) (e.g., 'pending', 'paid', 'checked-out')
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord`)
    *   `pendings`: (`List<DocumentReference>?`) (Refs to `TransactionsRecord`)
    *   `transactions`: (`List<DocumentReference>?`) (Refs to `TransactionsRecord`)
    *   `ability`: (`String?`)
    *   `promo`: (`String?`)
*   **`TransactionsRecord`**: Records financial transactions.
    *   `date`: (`DateTime?`)
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord`)
    *   `total`: (`double?`)
    *   `goods`: (`List<CartGoodsStruct>?`) (See Section 2.3)
    *   `hotel`: (`String?`)
    *   `type`: (`String?`) (e.g., 'room', 'goods', 'expense', 'salary')
    *   `booking`: (`DocumentReference?`) (Ref to `BookingsRecord`)
    *   `guests`: (`int?`)
    *   `room`: (`int?`)
    *   `description`: (`String?`)
    *   `remitted`: (`bool?`)
    *   `pending`: (`bool?`)
    *   `inventories`: (`List<DocumentReference>?`) (Refs to `InventoriesRecord`)
*   **`GoodsRecord`**: Represents items sold.
    *   `price`: (`double?`)
    *   `quantity`: (`int?`) (Current stock)
    *   `hotel`: (`String?`)
    *   `category`: (`String?`)
    *   `description`: (`String?`)
    *   `replenish`: (`bool?`) (Flag for replenishment needs)
*   **`StaffsRecord`**: Information about hotel staff.
    *   `name`: (`String?`)
    *   `weeklyRate`: (`double?`)
    *   `balance`: (`double?`) (Current balance, potentially for advances/deductions)
    *   `sssRate`: (`double?`) (SSS contribution rate)
    *   `hotel`: (`String?`)
    *   `fired`: (`bool?`)
*   **`SalariesRecord`**: Records salary payments (Subcollection of `PayrollsRecord`).
    *   `sss`: (`double?`) (SSS deduction for this period)
    *   `cashAdvance`: (`double?`) (Cash advance deduction for this period)
    *   `total`: (`double?`) (Net salary paid)
    *   `pendingCA`: (`double?`) (Remaining cash advance balance after deduction)
    *   `staff`: (`DocumentReference?`) (Ref to `StaffsRecord`)
    *   `rate`: (`double?`) (Weekly rate used for calculation)
    *   `date`: (`DateTime?`) (Date of salary calculation/payment)
    *   `caRefs`: (`List<DocumentReference>?`) (Refs to `AdvancesRecord` settled in this salary)
    *   `absences`: (`double?`) (Deduction amount for absences)
    *   `absencesRefs`: (`List<DocumentReference>?`) (Refs to `AbsencesRecord` settled in this salary)
*   **`PayrollsRecord`**: Aggregates salary payments for a period.
    *   `date`: (`DateTime?`) (Date the payroll was generated/approved)
    *   `status`: (`String?`) (e.g., 'pending', 'approved', 'paid')
    *   `total`: (`double?`) (Total amount for the entire payroll)
    *   `hotel`: (`String?`)
    *   `approvedBy`: (`DocumentReference?`) (Ref to `UsersRecord`)
    *   `fortnight`: (`String?`) (Identifier for the pay period, e.g., '2023-Dec-1st')
*   **`AdvancesRecord`**: Tracks cash advances given to staff (Subcollection of `StaffsRecord`).
    *   `settled`: (`bool?`) (Flag indicating if the advance has been fully deducted from salary)
    *   `amount`: (`double?`)
    *   `date`: (`DateTime?`)
    *   `requestedBy`: (`DocumentReference?`) (Ref to `StaffsRecord`)
*   **`RemittancesRecord`**: Records cash remittances.
    *   `date`: (`DateTime?`)
    *   `transactions`: (`List<DocumentReference>?`) (Refs to `TransactionsRecord` included)
    *   `hotel`: (`String?`)
    *   `gross`: (`double?`) (Total income)
    *   `expenses`: (`double?`) (Total expenses)
    *   `net`: (`double?`) (Net amount remitted)
    *   `collected`: (`bool?`) (Flag indicating if the cash was collected)
    *   `bookings`: (`List<DocumentReference>?`) (Refs to `BookingsRecord` involved)
    *   `inventories`: (`List<DocumentReference>?`) (Refs to `InventoriesRecord` involved)
    *   `absences`: (`List<DocumentReference>?`) (Refs to `AbsencesRecord` involved)
    *   `preparedByName`: (`String?`)
    *   `collectedByName`: (`String?`)
*   **`StatsRecord`**: Stores monthly statistics for a hotel.
    *   `hotel`: (`String?`)
    *   `year`: (`String?`)
    *   `month`: (`String?`)
    *   `days`: (`int?`)
    *   `roomsIncome`: (`double?`)
    *   `goodsIncome`: (`double?`)
    *   `expenses`: (`double?`) (General expenses, excluding groceries, bills, salaries)
    *   `salaries`: (`double?`)
    *   `roomUsage`: (`List<RoomUsageStruct>?`) (See Section 2.3)
    *   `roomLine`: (`LineGraphStruct?`) (See Section 2.3)
    *   `goodsLine`: (`LineGraphStruct?`) (See Section 2.3)
    *   `groceryExpenses`: (`double?`)
    *   `bills`: (`double?`)
    *   `net`: (`double?`)
*   **`HistoryRecord`**: Logs significant events (Subcollection, parent unknown without more context, likely `UsersRecord` or `BookingsRecord`).
    *   `date`: (`DateTime?`)
    *   `description`: (`String?`)
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord`)
    *   `booking`: (`DocumentReference?`) (Ref to `BookingsRecord`)
*   **`HotelSettingsRecord`**: Configuration settings for a hotel.
    *   `bedPrice`: (`double?`) Price for an extra bed.
    *   `hotel`: (`String?`) Hotel identifier.
    *   `lastRemit`: (`DateTime?`) Timestamp of the last remittance.
    *   `acceptNewStaff`: (`bool?`) Flag to allow new staff registration.
    *   `remittable`: (`bool?`) Flag indicating if remittance is currently possible.
    *   `lateCheckoutFee`: (`double?`) Fee for late check-out.
    *   `failedToRemitTransactions`: (`List<DocumentReference>?`) List of transactions that failed during remittance.
    *   `collectable`: (`bool?`) Flag indicating if collection is active.
    *   `promoOn`: (`bool?`) Flag indicating if a promotion is active.
    *   `promoDetail`: (`String?`) Description of the active promotion.
    *   `promoPercent`: (`double?`) Discount percentage for the promotion.
    *   `demoAccess`: (`bool?`) Flag to enable demo access features.
*   **`InventoriesRecord`**: Tracks changes in inventory levels.
    *   `date`: (`DateTime?`)
    *   `activity`: (`String?`) Description of the inventory change (e.g., 'stock in', 'sold', 'adjustment').
    *   `hotel`: (`String?`)
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord`)
    *   `quantityChange`: (`int?`) The change in quantity (+/-).
    *   `previousQuantity`: (`int?`) Quantity before the change.
    *   `item`: (`String?`) Name/description of the item.
    *   `operator`: (`String?`) Operator symbol ('+' or '-') indicating the type of change.
    *   `previousPrice`: (`double?`) Unit price before the change (if applicable).
    *   `priceChange`: (`double?`) Change in unit price (if applicable).
    *   `remitted`: (`bool?`) Flag indicating if this inventory change was part of a remittance.
*   **`IssuesRecord`**: Records reported issues or maintenance requests.
    *   `date`: (`DateTime?`) Date the issue was reported.
    *   `detail`: (`String?`) Description of the issue.
    *   `status`: (`String?`) Current status (e.g., 'pending', 'fixed').
    *   `hotel`: (`String?`)
    *   `dateFixed`: (`DateTime?`) Date the issue was resolved.
    *   `staffName`: (`String?`) Name of the staff member who reported or fixed the issue.
*   **`AbsencesRecord`**: Tracks staff absences and associated deductions (Subcollection of `StaffsRecord`).
    *   `settled`: (`bool?`) Flag indicating if the absence deduction has been settled/paid.
    *   `amount`: (`double?`) Deduction amount for the absence.
    *   `date`: (`DateTime?`) Date of the absence.
    *   `encodedBy`: (`DocumentReference?`) (Ref to `UsersRecord` who recorded the absence)
    *   `remitted`: (`bool?`) Flag indicating if this deduction was included in a remittance.
    *   `hotel`: (`String?`)
*   **`GroceriesRecord`**: Records grocery purchase expenses.
    *   `hotel`: (`String?`)
    *   `date`: (`DateTime?`)
    *   `recordedBy`: (`DocumentReference?`) (Ref to `UsersRecord`)
    *   `amount`: (`double?`) Cost of the groceries.
    *   `remark`: (`String?`) Optional notes about the purchase.
*   **`BillsRecord`**: Tracks utility and other recurring bills.
    *   `description`: (`String?`) Description of the bill (e.g., 'Electricity', 'Water').
    *   `amount`: (`double?`) Amount due for the current period.
    *   `date`: (`DateTime?`) Due date or payment date.
    *   `hotel`: (`String?`)
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord` who recorded/paid the bill)
    *   `afterDue`: (`double?`) Amount due if paid after the due date (including penalties).
*   **`GoodsRevenueRatioRecord`**: Tracks the ratio between grocery expenses and goods revenue.
    *   `date`: (`DateTime?`) Timestamp for the record (likely start of month/period).
    *   `grocery`: (`double?`) Total grocery expense for the period.
    *   `revenue`: (`double?`) Total revenue from goods sold for the period.
    *   `hotel`: (`String?`)
    *   `daysToBreakEven`: (`int?`) Calculated number of days needed to cover grocery costs with revenue.
    *   `daysPassed`: (`int?`) Number of days passed in the current period.
*   **`OptionsRecord`**: Stores predefined choices for dropdowns or selection fields.
    *   `type`: (`String?`) Category of the option (e.g., 'room_type', 'payment_method', 'goods_category').
    *   `choice`: (`String?`) The specific option value.
*   **`BillChangesRecord`**: Logs when changes are made to `BillsRecord` entries.
    *   `date`: (`DateTime?`) Timestamp of the change.
    *   `description`: (`String?`) Description of the change made.
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord` who made the change)
    *   `hotel`: (`String?`)
    *   `date`: (`DateTime?`) Timestamp of the change.
    *   `description`: (`String?`) Description of the change made.
    *   `staff`: (`DocumentReference?`) (Ref to `UsersRecord` who made the change)
    *   `hotel`: (`String?`)
*   **`RecordsRecord`**: Generic records, potentially for logging deliveries or other miscellaneous events.
    *   `date`: (`DateTime?`)
    *   `detail`: (`String?`) Description of the record.
    *   `hotel`: (`String?`)
    *   `receivedBy`: (`String?`) Name of the person who received something.
    *   `issuedBy`: (`String?`) Name of the person who issued something.
    *   `date`: (`DateTime?`)
    *   `detail`: (`String?`) Description of the record.
    *   `hotel`: (`String?`)
    *   `receivedBy`: (`String?`) Name of the person who received something.
    *   `issuedBy`: (`String?`) Name of the person who issued something.
*   **`ReplacementRecord`**: Tracks replacement requests, particularly for light bulbs.
    *   `requestedBy`: (`String?`) Name of the person requesting the replacement.
    *   `date`: (`DateTime?`) Date of the request.
    *   `watts`: (`int?`) Wattage of the bulb needed.
    *   `quantity`: (`int?`) Number of items needed.
    *   `hotel`: (`String?`)
    *   `location`: (`DocumentReference?`) (Ref to `LocationsRecord` where replacement is needed)
    *   `cr`: (`DocumentReference?`) (Ref to `ComfortRoomsRecord` if applicable)
    *   `requestedBy`: (`String?`) Name of the person requesting the replacement.
    *   `date`: (`DateTime?`) Date of the request.
    *   `watts`: (`int?`) Wattage of the bulb needed.
    *   `quantity`: (`int?`) Number of items needed.
    *   `hotel`: (`String?`)
    *   `location`: (`DocumentReference?`) (Ref to `LocationsRecord` where replacement is needed)
    *   `cr`: (`DocumentReference?`) (Ref to `ComfortRoomsRecord` if applicable)
*   **`LocationsRecord`**: Defines specific locations within the hotel (other than guest rooms).
    *   `sockets`: (`int?`) Number of light sockets in this location.
    *   `withCR`: (`bool?`) Flag indicating if this location includes a comfort room.
    *   `hotel`: (`String?`)
    *   `description`: (`String?`) Name or description of the location (e.g., 'Lobby', 'Hallway Floor 2').
    *   `sockets`: (`int?`) Number of light sockets in this location.
    *   `withCR`: (`bool?`) Flag indicating if this location includes a comfort room.
    *   `hotel`: (`String?`)
    *   `description`: (`String?`) Name or description of the location (e.g., 'Lobby', 'Hallway Floor 2').
*   **`ComfortRoomsRecord`**: Defines comfort rooms (restrooms) within the hotel.
    *   `sockets`: (`int?`) Number of light sockets in the comfort room.
    *   `hotel`: (`String?`)
    *   `description`: (`String?`) Name or description (e.g., 'Ground Floor CR', 'Staff CR').
*   **`CrRecord`**: Seems related to `ComfortRoomsRecord` and `ReplacementRecord`, possibly a subcollection. *(File `cr_record.dart` exists but its exact relationship/parent collection needs clarification from code usage)*
    *   `replacements`: (`List<DocumentReference>?`) (Refs to `ReplacementRecord`)
    *   `sockets`: (`int?`)
    *   `hotel`: (`String?`)
    *   `sockets`: (`int?`) Number of light sockets in the comfort room.
    *   `hotel`: (`String?`)
    *   `description`: (`String?`) Name or description (e.g., 'Ground Floor CR', 'Staff CR').
*   **`PurgedRecord`**: Logs when data purging operations are performed.
    *   `start`: (`DateTime?`) Start date of the purged data range.
    *   `end`: (`DateTime?`) End date of the purged data range.
    *   `records`: (`int?`) Number of records purged.
    *   `authorized`: (`String?`) Name of the user who authorized the purge.
    *   `date`: (`DateTime?`) Date the purge operation was performed.
    *   `hotel`: (`String?`)
    *   `start`: (`DateTime?`) Start date of the purged data range.
    *   `end`: (`DateTime?`) End date of the purged data range.
    *   `records`: (`int?`) Number of records purged.
    *   `authorized`: (`String?`) Name of the user who authorized the purge.
    *   `date`: (`DateTime?`) Date the purge operation was performed.
    *   `hotel`: (`String?`)
*   **`LastLoginRecord`**: Tracks the last login time for a user within a specific hotel context (Subcollection of `UsersRecord`).
    *   `datetime`: (`DateTime?`) Timestamp of the last login.
    *   `hotel`: (`String?`)

*(Note: Field names are inferred and may require inspecting the specific `.dart` files for exact definitions and data types.)*

**Schema Utilities (`backend/schema/util/*`):** Contains helper functions for Firestore data conversion (`firestore_util.dart`) and general schema operations (`schema_util.dart`).

## 5. Backend Interaction (`backend/backend.dart`)

- **Firestore Abstraction:** Provides a layer of abstraction for interacting with Cloud Firestore.
- **Query Functions:** Offers standardized functions (`queryCollection`, `queryCollectionOnce`, `queryCollectionCount`, `queryCollectionPage`) to query Firestore collections, supporting streams, futures, counts, and pagination.
- **Schema Definitions:** Defines Dart classes (`UsersRecord`, `RoomsRecord`, `BookingsRecord`, etc.) corresponding to Firestore collections, handling data mapping and serialization (`fromSnapshot`, `createUsersRecordData`, etc.).
- **Firestore Utilities:** Includes helper functions for Firestore operations (e.g., `mapToFirestore`, `getDocs`, `getDocumentOnce`).

## 6. Core Business Logic (`flutter_flow/custom_functions.dart`)

This file contains numerous utility functions encapsulating specific business logic:

- **Booking Calculations (`getTotalAmount`):**
    1. Initializes `totalAmount` to 0.0.
    2. **Bed Cost Calculation:**
        - If `beds` is not "+" (indicating specific bed count, not just adding excessive beds):
            - Parses `startingBeds` and `beds` into integers (defaulting to 0 if parsing fails).
            - If `parsedStartingBeds` is -1 (likely indicating a new booking or no previous bed count), adds `parsedBeds * bedPrice` to `totalAmount`.
            - Otherwise, calculates the `bedDifference` (`parsedBeds - parsedStartingBeds`) and adds `bedDifference * bedPrice` to `totalAmount`.
        - If `beds` is "+", adds `excessiveBeds * bedPrice` to `totalAmount`.
    3. **Night Cost Calculation:**
        - If `startingNights` is not 0:
            - Calculates the `nightDifference` (`nights - startingNights`) and adds `nightDifference * roomPrice` to `totalAmount`.
        - Otherwise (new booking or starting from 0 nights), adds `nights * roomPrice` to `totalAmount`.
    4. **Late Fee:** If `lateCheckoutFee` is provided (not null), adds it to `totalAmount`.
    5. Returns the final `totalAmount`.
- **Date/Time Utilities:** Functions for getting current/past dates (`today`, `yesterdayDate`), extracting date components (`currentYear`, `currentMonth`), calculating days in a month (`daysInTodaysMonth`), and formatting time differences (`hoursAgo`).
- **Cart Management:**
    - **`summarizeCart`:**
        1. Takes a list of `GoodsRecord` (`cart`) as input.
        2. Returns `null` if the cart is null or empty.
        3. Initializes an empty map `summary` to store `CartGoodsStruct` keyed by item description.
        4. Iterates through each `item` in the `cart`:
            - Gets the `item.description`.
            - If the description already exists as a key in `summary`:
                - Increments the `quantity` of the existing `CartGoodsStruct`.
                - Recalculates the `price` based on the new quantity (`item.price * new_quantity`).
            - If the description is new:
                - Creates a new `CartGoodsStruct` with `quantity` 1, `price` (`item.price * 1`), and stores the original `item.quantity` in `previousQuantity`.
                - Adds the new struct to the `summary` map with the description as the key.
        5. Converts the values of the `summary` map (the `CartGoodsStruct` objects) into a list and returns it.
    - **`totalOfCart`:**
        1. Takes a list of `GoodsRecord` (`cart`) as input.
        2. Returns 0.0 if the cart is null or empty.
        3. Performs the same summarization logic as `summarizeCart` to merge items by description and calculate quantities/prices per unique item.
        4. Initializes `totalPrice` to 0.0.
        5. Iterates through the summarized list of `CartGoodsStruct`.
        6. Adds the `price` of each summarized item to `totalPrice`.
        7. Returns the final `totalPrice`.
    - **`cartToTextSummary`:**
        1. Takes a list of `CartGoodsStruct` (`cartGoods`) as input.
        2. Returns `null` if the list is null or empty.
        3. Initializes a `StringBuffer` called `summary`.
        4. Iterates through each `item` in `cartGoods`.
        5. Appends a line to the `summary` buffer in the format: "`item.description` x `item.quantity`\n".
        6. Returns the final string from the `summary` buffer after trimming whitespace.
- **Remittance Calculation (`totalToRemit`):**
    1. Takes a list of `TransactionsRecord` (`transactions`) as input.
    2. Returns 0.0 if the list is null.
    3. Initializes `total` to 0.0.
    4. Iterates through each `transaction` in the list:
        - If `transaction.type` is 'expense', subtracts `transaction.total` from `total`.
        - If `transaction.type` is 'income', adds `transaction.total` to `total`.
        - (Implicitly ignores other transaction types).
    5. Returns the final calculated `total`.
- **Data Formatting/Parsing:** Simple utilities like `stringToInt`, `paidOrPending` (boolean to status string), `whichItemCategory` (handling 'All' category filter), `noRedundantCategories` (creating unique lists).
- **Statistics Helpers (`initEmptyLineGraph`, `updateLineGraph`, `currentMonthYear`):** Functions likely used to prepare data structures for displaying statistics or charts.

## 7. High-Level Actions (`actions/actions.dart`)

These functions orchestrate more complex operations involving multiple backend calls and state updates:

- **`createNewStats`:**
    1. **Reset State:** Sets `FFAppState().loopCounter` to 0 and clears `FFAppState().roomUsages` list.
    2. **Show Snackbar:** Displays a temporary message "Creating new stat!".
    3. **Fetch Rooms:** Queries Firestore for all `RoomsRecord` documents where the `hotel` field matches `FFAppState().hotel`.
    4. **Initialize Room Usage:**
        - Enters a `while` loop that continues as long as `FFAppState().loopCounter` is less than the number of fetched rooms (`roomsFire.length`).
        - Inside the loop:
            - Creates a `RoomUsageStruct` using the `number` from the room at the current loop index (`roomsFire[FFAppState().loopCounter].number`) and sets `use` to 0.
            - Adds this new struct to the `FFAppState().roomUsages` list.
            - Increments `FFAppState().loopCounter`.
    5. **Create Stats Document:**
        - Generates a new Firestore document reference for the `StatsRecord` collection.
        - Sets the data for this new document:
            - `hotel`: `FFAppState().hotel`
            - `year`: Result of `functions.currentYear()`
            - `month`: Result of `functions.currentMonth()`
            - `roomsIncome`, `goodsIncome`, `salaries`, `expenses`, `groceryExpenses`, `net`: Initialized to 0.0
            - `days`: Result of `functions.daysInTodaysMonth()` (defaulting to 0).
            - `roomLine`, `goodsLine`: Initialized using `functions.initEmptyLineGraph()`.
            - `roomUsage`: Maps the `FFAppState().roomUsages` list to Firestore data format using `getRoomUsageListFirestoreData`.
    6. **Update App State:** Stores the reference of the newly created `StatsRecord` document in `FFAppState().statsReference` and updates `FFAppState().currentStats` with the result of `functions.currentMonthYear()`.
- **`payBalanceOfPending`:**
    1. **Input:** Takes a `BookingsRecord` (`booking`) as input.
    2. **Reset Counter:** Sets `FFAppState().loopCounter` to 0.
    3. **Iterate Pending Transactions:**
        - Enters a `while` loop that continues as long as `FFAppState().loopCounter` is less than the length of the `booking.pendings` list.
        - Inside the loop:
            a. **Fetch Transaction:** Fetches the `TransactionsRecord` corresponding to the reference at `booking.pendings[FFAppState().loopCounter]`.
            b. **Update Transaction:** Updates the fetched transaction document in Firestore:
                - Sets `pending` to `false`.
                - Sets `description`: If the original `pendingTrans.total` was negative, keeps the original description; otherwise, sets it to a formatted string indicating the balance payment (e.g., "Guest paid the outstanding balance since [time ago] for [original description]").
                - Sets `date` to the server timestamp (`FieldValue.serverTimestamp()`).
            c. **Update Booking Lists:** Updates the `booking` document in Firestore:
                - Removes the current transaction reference (`booking.pendings[FFAppState().loopCounter]`) from the `pendings` array.
                - Adds the same transaction reference to the `transactions` array.
            d. **Increment Counter:** Increments `FFAppState().loopCounter`.
    4. **Update Booking Status:** Updates the `booking` document in Firestore, setting the `status` field to 'paid'.
    5. **Create History Log:** Creates a new `HistoryRecord` document associated with the `booking.room`:
        - Sets `description` to "Guest settled balance.".
        - Sets `staff` to the current user's reference (`currentUserReference`).
        - Sets `booking` to the reference of the input `booking`.
        - Sets `date` to the server timestamp.