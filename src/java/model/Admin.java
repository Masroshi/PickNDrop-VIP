/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import static model.Booking.adminList;

/**
 *
 * @author NUser1
 */
public class Admin{
    private String adminID;
    private String username;
    private String name;
    private String email;
    private String password;
    

    public Admin() {
    }

    public Admin(String username, String name, String email, String password) {
        this.adminID = adminID();
        this.username = username;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    
    
    public final String adminID(){
        String tempID = ("A".concat(Integer.toString(adminList.size() + 0)));
        return  tempID;
    }
    
    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

   
    
}
