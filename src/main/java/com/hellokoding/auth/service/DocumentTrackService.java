package com.hellokoding.auth.service;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hellokoding.auth.model.DocumentTrack;
import com.hellokoding.auth.model.User;

public interface DocumentTrackService {

	 void save(DocumentTrack documentTrack);
	 
	 public List<DocumentTrack> getDocumentList() ;
	 
	 public Integer update(String status,String docId);
	 
	 /* @Modifying
	    @Query("UPDATE DOCUMENT_TRACK c SET c.entryPoint = :status WHERE c.id = :id")
	    int updateStatus(@Param("id") String id, @Param("status") String status);
	 */

	// List<DocumentTrack> getDocumentList(String userId);
}
