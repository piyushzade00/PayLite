# PayLite – Business Rules

This document defines the authoritative business rules used by PayLite
to calculate monthly payroll. All salary calculations must strictly
follow these rules. If application behavior differs from this document,
the application is considered incorrect.

---

## 1. Payroll Cycle

- Payroll is processed **monthly**.
- Each payroll run is associated with a specific month (YYYY-MM).
- Payroll for a month can be generated **only once**.
- Once generated, payroll data is **immutable**.

---

## 2. Payroll Policy

Each business defines exactly **one payroll policy**.

The payroll policy contains:

- Number of working days per month
- Number of paid leaves allowed per month
- Overtime rate (per hour)
- Unpaid leave deduction logic

The payroll policy must exist before any payroll can be generated.

---

## 3. Salary Calculation Rules

### 3.1 Base Salary

- Each employee has a fixed monthly base salary.
- Base salary is not affected by paid leaves.

### 3.2 Per-Day Salary

Per-Day Salary = Monthly Base Salary / Working Days

Working days are defined in the payroll policy.

---

### 3.3 Paid Leave

- Paid leaves do not reduce salary.
- Paid leaves beyond the allowed quota are treated as unpaid leaves.

---

### 3.4 Unpaid Leave

Unpaid Leave Deduction = Unpaid Leave Days × Per-Day Salary

Unpaid leave always results in salary deduction.

---

### 3.5 Overtime

Overtime Pay = Overtime Hours × Overtime Rate

- Overtime rate is defined in the payroll policy.
- Overtime pay is added to the salary after deductions.

---

### 3.6 Bonus

- Bonuses are optional and one-time.
- Bonuses are added after deductions.
- Multiple bonuses per employee per month are allowed.

---

### 3.7 Net Salary

Net Salary = Base Salary

- Unpaid Leave Deductions

* Overtime Pay
* Bonuses

---

## 4. Payroll Finalization

- Payroll generation is a **manual action**.
- After payroll is generated:
  - Attendance cannot be edited
  - Bonuses cannot be edited
  - Payroll records cannot be modified or deleted

---

## 5. Data Integrity

- Payroll must be deterministic:
  - Same inputs must always produce the same output.
- Duplicate payroll runs for the same month are not allowed.
- Payroll correctness is prioritized over automation.
