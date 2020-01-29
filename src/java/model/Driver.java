/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import static model.SprintOneDatabase.driverList;   // using admin list to store admin users

/**
 *
 * @author NUser1
 */
public class Driver{
 private String driverID;
    private String username;        //admin attributes
    private String name;
    private String email;
    private String password;

    public Driver() {           //empty constructor
    }

    public Driver(String username, String name, String email, String password) {
        this.driverID = driverID();      //initialize attributes 
        this.username = username;
        this.name = name;
        this.email = email;
        this.password = password;
    }
    
    public final String driverID(){
        String tempID = ("D".concat(Integer.toString(driverList.size() + 0)));    //giving id with letter
        return  tempID;             
    }
    
    public String getDriverID() {        //getters and setters to use admin users attributes
        return driverID;
    }

    public void setDriverID(String driverID) {
        this.driverID = driverID;
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
