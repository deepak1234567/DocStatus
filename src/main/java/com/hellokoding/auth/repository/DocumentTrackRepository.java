package com.hellokoding.auth.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hellokoding.auth.model.DocumentTrack;

public interface DocumentTrackRepository extends JpaRepository<DocumentTrack,Long> {

	
	 
	

}
