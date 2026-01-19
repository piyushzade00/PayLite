-- =========================================================
-- PayLite MVP Database Schema
-- =========================================================
-- Authoritative schema for payroll domain
-- Database: MySQL 8+
-- =========================================================


-- =========================
-- 1. BUSINESS
-- =========================
CREATE TABLE business (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    max_employees INT NOT NULL DEFAULT 10,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_max_employees CHECK (max_employees > 0)
);


-- =========================
-- 2. PAYROLL POLICY
-- =========================
CREATE TABLE payroll_policy (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    business_id BIGINT NOT NULL,
    working_days_per_month INT NOT NULL,
    paid_leaves_per_month INT NOT NULL,
    overtime_rate_per_hour DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_policy_business
        FOREIGN KEY (business_id)
        REFERENCES business(id),

    CONSTRAINT uq_policy_business UNIQUE (business_id),

    CONSTRAINT chk_working_days CHECK (working_days_per_month > 0),
    CONSTRAINT chk_paid_leaves CHECK (paid_leaves_per_month >= 0),
    CONSTRAINT chk_overtime_rate CHECK (overtime_rate_per_hour >= 0)
);


-- =========================
-- 3. EMPLOYEE
-- =========================
CREATE TABLE employee (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    business_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    base_salary DECIMAL(12,2) NOT NULL,
    joining_date DATE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_employee_business
        FOREIGN KEY (business_id)
        REFERENCES business(id),

    CONSTRAINT chk_base_salary CHECK (base_salary >= 0)
);


-- =========================
-- 4. ATTENDANCE
-- =========================
CREATE TABLE attendance (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_id BIGINT NOT NULL,
    month CHAR(7) NOT NULL, -- YYYY-MM
    paid_leave_days INT NOT NULL DEFAULT 0,
    unpaid_leave_days INT NOT NULL DEFAULT 0,
    overtime_hours DECIMAL(5,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_attendance_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(id),

    CONSTRAINT uq_attendance_employee_month
        UNIQUE (employee_id, month),

    CONSTRAINT chk_paid_leave_days CHECK (paid_leave_days >= 0),
    CONSTRAINT chk_unpaid_leave_days CHECK (unpaid_leave_days >= 0),
    CONSTRAINT chk_overtime_hours CHECK (overtime_hours >= 0)
);


-- =========================
-- 5. BONUS
-- =========================
CREATE TABLE bonus (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    employee_id BIGINT NOT NULL,
    month CHAR(7) NOT NULL, -- YYYY-MM
    amount DECIMAL(12,2) NOT NULL,
    type VARCHAR(30) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_bonus_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(id),

    CONSTRAINT chk_bonus_amount CHECK (amount >= 0)
);


-- =========================
-- 6. PAYROLL RUN
-- =========================
CREATE TABLE payroll_run (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    business_id BIGINT NOT NULL,
    month CHAR(7) NOT NULL, -- YYYY-MM
    status VARCHAR(20) NOT NULL,
    generated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payroll_run_business
        FOREIGN KEY (business_id)
        REFERENCES business(id),

    CONSTRAINT uq_payroll_run_business_month
        UNIQUE (business_id, month)
);


-- =========================
-- 7. PAYROLL ITEM
-- =========================
CREATE TABLE payroll_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    payroll_run_id BIGINT NOT NULL,
    employee_id BIGINT NOT NULL,
    base_salary DECIMAL(12,2) NOT NULL,
    unpaid_deduction DECIMAL(12,2) NOT NULL,
    overtime_pay DECIMAL(12,2) NOT NULL,
    bonus_amount DECIMAL(12,2) NOT NULL,
    net_salary DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_payroll_item_run
        FOREIGN KEY (payroll_run_id)
        REFERENCES payroll_run(id),

    CONSTRAINT fk_payroll_item_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee(id),

    CONSTRAINT uq_payroll_item_run_employee
        UNIQUE (payroll_run_id, employee_id),

    CONSTRAINT chk_net_salary CHECK (net_salary >= 0)
);
