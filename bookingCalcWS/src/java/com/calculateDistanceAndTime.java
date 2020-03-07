/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.ejb.Stateless;

/**
 *
 * @author NUser1
 */
@WebService(serviceName = "calculateDistanceAndTime")
@Stateless()
public class calculateDistanceAndTime {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "calculateDistanceAndTime")
    public int add(@WebParam(name = "i") int i, @WebParam(name = "j") int j) {
        //TODO write your implementation code here:
        
        Double bookingfee = 1.5;
        Double baserate = 0.1;
        int time = i/60;            //changing seconds to minute
        int distance = j;
        int sum = (int) ((baserate*distance)+ time + bookingfee);
        
        return sum;
    }
}
