package com.paylite.paylite_backend.domain;

import jakarta.persistence.*;
import lombok.Getter;

import java.math.BigDecimal;

@Entity
@Table(
        name = "payroll_policy",
        uniqueConstraints = {
                @UniqueConstraint(name = "uq_policy_business", columnNames = "business_id")
        }
)
@Getter
public class PayrollPolicy extends BaseEntity{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(
            name = "business_id",
            nullable = false,
            updatable = false
    )
    private Business business;

    @Column(name = "working_days_per_month", nullable = false)
    private Integer workingDaysPerMonth;

    @Column(name = "paid_leaves_per_month", nullable = false)
    private Integer paidLeavesPerMonth;

    @Column(
            name = "overtime_rate_per_hour",
            nullable = false,
            precision = 10,
            scale = 2
    )
    private BigDecimal overtimeRatePerHour;

    protected PayrollPolicy() {
        // JPA only
    }

    public PayrollPolicy(
            Business business,
            Integer workingDaysPerMonth,
            Integer paidLeavesPerMonth,
            BigDecimal overtimeRatePerHour
    ) {
        validate(business, workingDaysPerMonth, paidLeavesPerMonth, overtimeRatePerHour);

        this.business = business;
        this.workingDaysPerMonth = workingDaysPerMonth;
        this.paidLeavesPerMonth = paidLeavesPerMonth;
        this.overtimeRatePerHour = overtimeRatePerHour;
    }

    // ---- Controlled mutation ----

    public void updatePolicy(
            Integer workingDaysPerMonth,
            Integer paidLeavesPerMonth,
            BigDecimal overtimeRatePerHour
    ) {
        validate(this.business, workingDaysPerMonth, paidLeavesPerMonth, overtimeRatePerHour);

        this.workingDaysPerMonth = workingDaysPerMonth;
        this.paidLeavesPerMonth = paidLeavesPerMonth;
        this.overtimeRatePerHour = overtimeRatePerHour;
    }

    // ---- Validation ----

    private void validate(
            Business business,
            Integer workingDays,
            Integer paidLeaves,
            BigDecimal overtimeRate
    ) {
        if (business == null) {
            throw new IllegalArgumentException("Payroll policy must belong to a business");
        }
        if (workingDays == null || workingDays <= 0) {
            throw new IllegalArgumentException("Working days per month must be greater than zero");
        }
        if (paidLeaves == null || paidLeaves < 0) {
            throw new IllegalArgumentException("Paid leaves per month cannot be negative");
        }
        if (overtimeRate == null || overtimeRate.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Overtime rate must be zero or positive");
        }
    }
}
