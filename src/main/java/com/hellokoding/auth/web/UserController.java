package com.hellokoding.auth.web;

import com.hellokoding.auth.model.DocumentTrack;
import com.hellokoding.auth.model.EntryPoint;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.service.DocumentTrackService;
import com.hellokoding.auth.service.SecurityService;
import com.hellokoding.auth.service.UserService;
import com.hellokoding.auth.validator.UserValidator; 

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.io.DocumentSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private DocumentTrackService documentTrackService;
    
    @Autowired
    private UserValidator userValidator;
    
    Map <String,String> docStatus =null;
    public UserController(){
    docStatus = new HashMap<String,String>();
    	
    	docStatus.put("101", "Initiate Document");
    	docStatus.put("102", "Post Document");
    	docStatus.put("103", "Received But not verified");
    	docStatus.put("104", "Closed");
    	 
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        return "welcome";
    }
    
    @RequestMapping(value = {"/createDocumentTrack"}, method = RequestMethod.GET)
    public String createDocumentTrack(Model model) {
    	
    	model.addAttribute("documentTrack", new DocumentTrack());
    	model.addAttribute("userList", userService.getUserList());
        return "createDocumentTrack";
    }
    
    @RequestMapping(value = {"/docsStatus"}, method = RequestMethod.GET)
    public String getDocsStatus(Model model) {
    	
    	
    	model.addAttribute("documentTrack", new DocumentTrack());
    	model.addAttribute("userList", userService.getUserList());
    	model.addAttribute("docStatus",docStatus);
        return "createDocumentTrack";
    }
  /*   @RequestMapping(value = {"/editStatus"}, method = RequestMethod.GET)
    public String editStatus(Model model) {
     	model.addAttribute("editStatus", new EntryPoint());
         return "documentStatus";
  }*/
    
    
    @RequestMapping(value = "/editStatus",method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView cashOrderList( 
			@RequestParam(value = "status",required=false,defaultValue = "") String status, 
			@RequestParam(value = "docId",required=false,defaultValue = "") String docId, 
			HttpServletRequest request){
		try {				
			ModelAndView modelAndView = new ModelAndView("documentStatus");
			 			 System.out.println("adsda"+status);
			 			 
			 			List<DocumentTrack> list = documentTrackService.getDocumentList();
			 	    	List<User> userList = userService.getUserList();
			 	    	for(DocumentTrack  documentTrack:list){
			 	    		documentTrack.setEntryPoint(docStatus.get(documentTrack.getEntryPoint()));
			 	    		for(User  user:userList){
			 	    			if(user.getId().toString().trim().equals(documentTrack.getFromUser()))
			 	    				documentTrack.setFromUser(user.getUsername());
			 	    			if(user.getId().toString().trim().equals(documentTrack.getToUser()))
			 	    				documentTrack.setToUser(user.getUsername());
			 	    			
			 	        	
			 	        	}
			 	    	}
			 	    	
			 	    	modelAndView.addObject("list",list);
			 			 int docStatus = documentTrackService.update(status,docId);
			 			 if(docStatus==1){
			 				modelAndView.addObject("msg", "Successfully Updated Document Status");
			 			 }
			 			 else{
					 				modelAndView.addObject("msg", "Internal Server Error");
					 		}
			 			 
			 
			return modelAndView;
		} catch (Exception e) {
			 
			return null;
		}
	}
    @RequestMapping(value = {"/editStatus"}, method = RequestMethod.POST)
    public String editStatus(Model model){
    	  
    	  return "redirect:/welcome";
    }
    
    @RequestMapping(value = {"/documentStatus"}, method = RequestMethod.GET)
    public String documentStatus(Model model) {
    	List<DocumentTrack> list = documentTrackService.getDocumentList();
    	List<User> userList = userService.getUserList();
    	for(DocumentTrack  documentTrack:list){
    		documentTrack.setEntryPoint(docStatus.get(documentTrack.getEntryPoint()));
    		for(User  user:userList){
    			if(user.getId().toString().trim().equals(documentTrack.getFromUser()))
    				documentTrack.setFromUser(user.getUsername());
    			if(user.getId().toString().trim().equals(documentTrack.getToUser()))
    				documentTrack.setToUser(user.getUsername());
    			
        	
        	}
    	}
    	
    	model.addAttribute("list",list);
    	//model.addAttribute("status",documentTrackService.getDocumentList());
        return "documentStatus";
    }
    
    @RequestMapping(value = "/documentList",method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_VALUE)
	public List<DocumentTrack> documentList( 
			HttpServletRequest request){
		try {
			
			return  documentTrackService.getDocumentList();
		} catch (Exception e) {
			 
			return null;
		}
	}

    
    @RequestMapping(value = "/createDocumentTrack", method = RequestMethod.POST)
    public String createDocumentTrack(@ModelAttribute("documentTrack") DocumentTrack documentTrack, 
    		Model model) {
    	
    	documentTrackService.save(documentTrack); 
    	
    	model.addAttribute("msg", "Sucessfully Created Document");
          return "createDocumentTrack";
        
   
    }
}
