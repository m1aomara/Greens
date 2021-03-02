package com.example.OracleMongo.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "customers")
public class EnergyTracker {

    @Id
    private String customerId;
    
    private Integer serialNumber;
    private Integer mpxn;
    private Integer totalUnits;
    private String lastMeterRead;

    public String getCustomerId() {
        return customerId;
    }

    @Override
    public String toString() {
        return "EnergyTracker{" +
                "customerId='" + customerId + '\'' +
                ", serialNumber=" + serialNumber +
                ", mpxn=" + mpxn +
                ", totalUnits=" + totalUnits +
                ", lastMeterRead=" + lastMeterRead +
                '}';
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public Integer getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(Integer serialNumber) {
        this.serialNumber = serialNumber;
    }

    public Integer getMpxn() {
        return mpxn;
    }

    public void setMpxn(Integer mpxn) {
        this.mpxn = mpxn;
    }

    public Integer getTotalUnits() {
        return totalUnits;
    }

    public void setTotalUnits(Integer totalUnits) {
        this.totalUnits = totalUnits;
    }

    public String getLastMeterRead() {
        return lastMeterRead;
    }

    public void setLastMeterRead(String lastMeterRead) {
        this.lastMeterRead = lastMeterRead;
    }

}
