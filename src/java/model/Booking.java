/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author NUser1
 */
public class Booking {
    static ArrayList<Customer> customerList = new ArrayList();
    static ArrayList<Driver> driverList = new ArrayList();
    static ArrayList<Admin> adminList = new ArrayList();
    static public ArrayList<Booking> bookingList = new ArrayList();
    private String bookingID;
    private String customerID;
    private String driverID;
    private String origin;
    private String destination;
    private int duration;
    private int distance;
    private String bookingDate;
    private String bookingTime;
    private int sum;
    private String status;
    public Booking() {
    }

    public Booking(String origin, String destination, int duration, int distance, String bookingDate, String bookingTime, int sum, String status) {
        this.bookingID = bookingID();
        this.origin = origin;
        this.destination = destination;
        this.duration = duration;
        this.distance = distance;
        this.bookingDate = bookingDate;
        this.bookingTime = bookingTime;
        this.sum = sum;
        this.status = status;
    }

    public final String bookingID(){
        String tempID = ("B".concat(Integer.toString(bookingList.size() + 0)));
        return  tempID;
    }
    
    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getDriverID() {
        return driverID;
    }

    public void setDriverID(String driverID) {
        this.driverID = driverID;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(String bookingTime) {
        this.bookingTime = bookingTime;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    

    
    
    
    
    
}
