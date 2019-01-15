package com.hellokoding.auth.service;

import java.util.List;

import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.hellokoding.auth.model.DocumentTrack;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.repository.DocumentTrackRepository;
import javax.persistence.EntityManager;



@Service
public class DocumentTrackImpl implements DocumentTrackService {

	@PersistenceContext
	private EntityManager em;
	
	@Autowired
	DocumentTrackRepository  documentTrackRepository;
	
	@Override
	public void save(DocumentTrack documentTrack) {
		// TODO Auto-generated method stub
		documentTrackRepository.save(documentTrack);
		
	}

	@Override
	public List<DocumentTrack> getDocumentList() {
		// TODO Auto-generated method stub
		return documentTrackRepository.findAll();
	}

	@Override
	@Transactional
	public Integer update(String status,String docId) {
		try{
			int i= em.createQuery("UPDATE DocumentTrack p SET p.entryPoint ="+status+" WHERE id="+docId)
			        .executeUpdate();
			return i;
		 
		}catch(Exception e){
			
			System.out.println(e);
			return 0;
		}
		
		
		
		
	}

}


/*package com.hellokoding.auth.service;

import com.hellokoding.auth.model.DocumentTrack;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.repository.RoleRepository;
import com.hellokoding.auth.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(new HashSet<>(roleRepository.findAll()));
        userRepository.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }*/


