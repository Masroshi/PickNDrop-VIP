/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import static model.SprintOneDatabase.customerList;  // using customer list to store customer users

/**
 *
 * @author NUser1
 */
public class Customer{
     private String customerID;
    private String username;        //customer attributes
    private String name;
    private String email;
    private String password;

    public Customer() {         //empty constructor
    }

    public Customer(String username, String name, String email, String password) {
        this.customerID = customerID();     //initialize attributes 
        this.username = username;
        this.name = name;
        this.email = email;
        this.password = password;
    }
    
    public final String customerID(){
        String tempID = ("C".concat(Integer.toString(customerList.size() + 0)));    //giving id with letter
        return  tempID;     
    }

    public String getCustomerID() { //getters and setters to use admin users attributes
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
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
