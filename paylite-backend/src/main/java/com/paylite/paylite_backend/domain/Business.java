package com.paylite.paylite_backend.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "business")
public class Business extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(name = "max_employees", nullable = false)
    private Integer maxEmployees = 10;

    protected Business() {
        // Required by JPA
    }

    public Business(String name, Integer maxEmployees) {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Business name cannot be empty");
        }
        if (maxEmployees != null && maxEmployees <= 0) {
            throw new IllegalArgumentException("Max employees must be positive");
        }

        this.name = name;
        this.maxEmployees = maxEmployees != null ? maxEmployees : 10;
    }

    // ---- Getters ONLY (no setters for id or timestamps) ----

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Integer getMaxEmployees() {
        return maxEmployees;
    }

    // ---- Controlled mutation ----

    public void updateName(String name) {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("Business name cannot be empty");
        }
        this.name = name;
    }

    public void updateMaxEmployees(Integer maxEmployees) {
        if (maxEmployees <= 0) {
            throw new IllegalArgumentException("Max employees must be positive");
        }
        this.maxEmployees = maxEmployees;
    }
}
