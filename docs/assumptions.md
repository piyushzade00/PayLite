# PayLite – Assumptions

This document lists the assumptions under which the PayLite MVP is
designed and implemented. These assumptions intentionally limit scope
to ensure simplicity and correctness.

---

## 1. Business Size

- PayLite is designed for businesses with **10 or fewer employees**.
- The system enforces this limit at the application level.

---

## 2. User Roles

- There is exactly **one role** in the MVP: ADMIN.
- Employees do not log in to the system.
- The admin is trusted to enter correct attendance and bonus data.

---

## 3. Payroll Scope

- PayLite handles **gross salary calculation only**.
- The following are explicitly excluded:
  - Income tax
  - PF / ESI
  - Statutory compliance
  - Bank or UPI payments

---

## 4. Attendance

- Attendance is entered **manually** by the admin.
- There is no automated attendance tracking.
- Attendance data is assumed to be correct once payroll is generated.

---

## 5. Payroll Execution

- Payroll is triggered manually by the admin.
- Payroll is not auto-generated on any date.
- Payroll is expected to be run once per month.

---

## 6. Currency & Locale

- All salary values are stored as numeric values.
- Currency handling is outside the scope of MVP.
- The system assumes a single currency per business.

---

## 7. Data Trust Model

- Once payroll is generated, data is considered final.
- Corrections require an explicit rollback action (manual, audited).
- Silent recalculation is not allowed.

---

## 8. Non-Goals of MVP

- HR management
- Performance reviews
- Employee self-service
- Analytics dashboards
- Notifications
