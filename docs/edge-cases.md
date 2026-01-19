# PayLite – Edge Cases & Decisions

This document records known edge cases and the explicit decisions taken
to handle them. These decisions guide implementation and testing.

---

## 1. Employee Joins Mid-Month

**Decision:**

- Salary is prorated based on working days after the joining date.

---

## 2. Employee Has Zero Attendance

**Decision:**

- Salary may be reduced to zero.
- Negative salary is not allowed.

---

## 3. Paid Leaves Exceed Allowed Limit

**Decision:**

- Excess paid leaves are treated as unpaid leaves.
- Deduction applies accordingly.

---

## 4. Unpaid Leave Exceeds Working Days

**Decision:**

- Validation error.
- Payroll generation is blocked until corrected.

---

## 5. Bonus Greater Than Base Salary

**Decision:**

- Allowed.
- Net salary may exceed base salary.

---

## 6. Payroll Generated Twice for Same Month

**Decision:**

- Second attempt is blocked.
- Redis-based lock prevents duplicate payroll generation.

---

## 7. Attendance Edited After Payroll Generation

**Decision:**

- Not allowed.
- Attendance records become read-only once payroll is generated.

---

## 8. Bonus Edited After Payroll Generation

**Decision:**

- Not allowed.
- Bonus records become read-only once payroll is generated.

---

## 9. Payroll Deletion

**Decision:**

- Payroll records cannot be deleted.
- Rollback (if required) must be explicit and audited.

---

## 10. Partial Data During Payroll Run

**Decision:**

- Payroll generation fails if any employee data is missing.
- No partial payroll generation is allowed.
