package com.hellokoding.auth.repository;

import com.hellokoding.auth.model.User;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, List> {
    User findByUsername(String username);
}
